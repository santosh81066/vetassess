import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:vetassess/utils/vetassess_api.dart';
import '../models/registration_model.dart';

class SignupRepository {
  static const String baseUrl = VetassessApi.baseUrl;
  static const String signupEndpoint = '/auth/signup/applicant';
  static const String captchaEndpoint = '/auth/captcha';

  late final Dio _dio;

  SignupRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          // Accept all status codes to handle them manually
          return status != null && status < 500;
        },
      ),
    );

    // Add interceptor for logging (optional)
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print(obj),
      ),
    );
  }

  Future<SignupResponse> signup(SignupRequest request) async {
    try {
      print('Sending signup request to: $baseUrl$signupEndpoint');
      print('Request body: ${jsonEncode(request.toJson())}');

      final response = await _dio.post(signupEndpoint, data: request.toJson());

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle both Map and String responses
        Map<String, dynamic> jsonData;
        if (response.data is String) {
          jsonData = jsonDecode(response.data);
        } else {
          jsonData = response.data as Map<String, dynamic>;
        }
        return SignupResponse.fromJson(jsonData);
      } else {
        // Better error handling for different status codes
        String errorMessage;
        try {
          Map<String, dynamic> errorData;
          if (response.data is String) {
            errorData = jsonDecode(response.data);
          } else {
            errorData = response.data as Map<String, dynamic>;
          }
          errorMessage =
              errorData['message'] ??
              errorData['error'] ??
              'Signup failed with status ${response.statusCode}';
        } catch (e) {
          errorMessage = 'Signup failed with status ${response.statusCode}';
        }
        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      print('Dio error: ${e.type} - ${e.message}');

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw Exception(
            'Request timeout. Please check your internet connection and try again.',
          );

        case DioExceptionType.connectionError:
          throw Exception(
            'Connection error. Please check your internet connection and server availability.',
          );

        case DioExceptionType.badResponse:
          String errorMessage = 'Server error';
          if (e.response?.data != null) {
            try {
              Map<String, dynamic> errorData;
              if (e.response!.data is String) {
                errorData = jsonDecode(e.response!.data);
              } else {
                errorData = e.response!.data as Map<String, dynamic>;
              }
              errorMessage =
                  errorData['message'] ?? errorData['error'] ?? errorMessage;
            } catch (_) {
              errorMessage = 'Server returned status ${e.response?.statusCode}';
            }
          }
          throw Exception(errorMessage);

        case DioExceptionType.cancel:
          throw Exception('Request was cancelled');

        default:
          throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      print('Signup error: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      } else {
        throw Exception('Unexpected error: ${e.toString()}');
      }
    }
  }

  Future<String> getCaptcha() async {
    try {
      print('Fetching captcha from: $baseUrl$captchaEndpoint');

      final response = await _dio.get(captchaEndpoint);

      print('Captcha response status: ${response.statusCode}');
      print('Captcha response data: ${response.data}');

      if (response.statusCode == 200) {
        try {
          Map<String, dynamic> jsonData;
          if (response.data is String) {
            jsonData = jsonDecode(response.data);
          } else {
            jsonData = response.data as Map<String, dynamic>;
          }

          final captcha = jsonData['captcha'];

          if (captcha != null && captcha.toString().trim().isNotEmpty) {
            return captcha.toString().trim();
          } else {
            throw Exception('Empty or null captcha received from server');
          }
        } catch (e) {
          // Maybe the response is plain text, not JSON
          if (response.data is String) {
            final captchaText = response.data.toString().trim();
            if (captchaText.isNotEmpty && captchaText.length < 20) {
              return captchaText;
            }
          }
          throw Exception('Invalid captcha response format');
        }
      } else {
        String errorMessage =
            'Failed to load captcha - Status: ${response.statusCode}';
        if (response.data != null) {
          try {
            Map<String, dynamic> errorData;
            if (response.data is String) {
              errorData = jsonDecode(response.data);
            } else {
              errorData = response.data as Map<String, dynamic>;
            }
            errorMessage =
                errorData['message'] ?? errorData['error'] ?? errorMessage;
          } catch (_) {
            // Keep the default error message
          }
        }
        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      print('Captcha Dio error: ${e.type} - ${e.message}');

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw Exception('Captcha request timeout. Please try again.');

        case DioExceptionType.connectionError:
          throw Exception(
            'Connection error. Please check your internet connection.',
          );

        case DioExceptionType.badResponse:
          throw Exception('Failed to load captcha - Server error');

        case DioExceptionType.cancel:
          throw Exception('Captcha request was cancelled');

        default:
          throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      print('Captcha error: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      } else {
        throw Exception('Unexpected error: ${e.toString()}');
      }
    }
  }

  void dispose() {
    _dio.close();
  }
}

// Repository provider
final signupRepositoryProvider = Provider<SignupRepository>((ref) {
  final repository = SignupRepository();

  // Dispose the repository when it's no longer needed
  ref.onDispose(() {
    repository.dispose();
  });

  return repository;
});

// State notifier for signup
class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier(this._repository) : super(SignupState()) {
    // Load initial captcha when the notifier is created
    _loadCaptcha();
  }

  final SignupRepository _repository;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _loadCaptcha() async {
    if (_isDisposed) return;

    try {
      print('Loading initial captcha...');
      state = state.copyWith(errorMessage: ''); // Clear previous errors

      final captcha = await _repository.getCaptcha();

      if (_isDisposed) return; // Check again after async operation

      print('Captcha loaded successfully: $captcha');
      state = state.copyWith(captchaText: captcha, errorMessage: '');
    } catch (e) {
      if (_isDisposed) return;

      print('Failed to load initial captcha: $e');

      // Generate a fallback captcha for development/testing
      final fallbackCaptcha = _generateFallbackCaptcha();

      state = state.copyWith(
        captchaText: fallbackCaptcha,
        errorMessage:
            'Failed to load captcha from server. Using fallback: ${e.toString().replaceFirst('Exception: ', '')}',
      );
    }
  }

  String _generateFallbackCaptcha() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        5,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  Future<void> signup(SignupFormData formData) async {
    if (_isDisposed) return;

    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // Validate captcha input matches current captcha (case-insensitive)
      final userInput = formData.captchaInput.trim().toUpperCase();
      final expectedCaptcha = state.captchaText.trim().toUpperCase();

      if (userInput != expectedCaptcha) {
        if (_isDisposed) return;

        state = state.copyWith(
          isLoading: false,
          errorMessage:
              'Captcha verification failed. Please check the text and try again.',
        );

        // Refresh captcha after failed attempt
        await refreshCaptcha();
        return;
      }

      final request = SignupRequest(
        givenNames: formData.givenNames.trim(),
        surname: formData.surname.trim(),
        dateOfBirth: formData.dateOfBirth.trim(),
        email: formData.email.trim().toLowerCase(),
        confirmEmail: formData.confirmEmail.trim().toLowerCase(),
        password: formData.password,
        confirmPassword: formData.confirmPassword,
        isAgreedToReceiveNewsChecked: formData.isAgreedToReceiveNews,
        captchaInput: formData.captchaInput.trim(),
        captchaOriginal: state.captchaText.trim(),
      );

      print('Attempting signup with form data...');
      final response = await _repository.signup(request);

      if (_isDisposed) return;

      print('Signup successful!');

      state = state.copyWith(
        isLoading: false,
        response: response,
        errorMessage: '',
      );
    } catch (e) {
      if (_isDisposed) return;

      print('Signup failed: $e');
      String errorMessage = e.toString().replaceFirst('Exception: ', '');

      // Refresh captcha on error (in case it expired or there was a server error)
      await refreshCaptcha();

      state = state.copyWith(isLoading: false, errorMessage: errorMessage);
    }
  }

  Future<void> refreshCaptcha() async {
    if (_isDisposed) return;

    try {
      print('Refreshing captcha...');

      final captcha = await _repository.getCaptcha();

      if (_isDisposed) return;

      print('Captcha refreshed successfully: $captcha');
      state = state.copyWith(
        captchaText: captcha,
        errorMessage: '', // Clear captcha-related errors
      );
    } catch (e) {
      if (_isDisposed) return;

      print('Failed to refresh captcha: $e');

      // Generate fallback captcha
      final fallbackCaptcha = _generateFallbackCaptcha();

      state = state.copyWith(
        captchaText: fallbackCaptcha,
        errorMessage: 'Failed to refresh captcha from server. Using fallback.',
      );
    }
  }

  void clearError() {
    if (_isDisposed) return;
    state = state.copyWith(errorMessage: '');
  }

  void reset() {
    if (_isDisposed) return;
    state = SignupState();
    _loadCaptcha();
  }
}

// State notifier provider
final signupProvider = StateNotifierProvider<SignupNotifier, SignupState>((
  ref,
) {
  final repository = ref.read(signupRepositoryProvider);
  return SignupNotifier(repository);
});

// Form data provider for managing form state
final signupFormProvider = StateProvider<SignupFormData>((ref) {
  return SignupFormData();
});
