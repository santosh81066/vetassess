import 'dart:convert';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/registration_model.dart';

class SignupRepository {
  static const String baseUrl = 'http://103.98.12.226:5100';
  static const String signupEndpoint = '/auth/signup/applicant';
  static const String captchaEndpoint = '/auth/captcha';

  Future<SignupResponse> signup(SignupRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$signupEndpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return SignupResponse.fromJson(jsonData);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Signup failed');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<String> getCaptcha() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$captchaEndpoint'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData['captcha'] ?? 'ERROR';
      } else {
        throw Exception('Failed to load captcha');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}

// Repository provider
final signupRepositoryProvider = Provider<SignupRepository>((ref) {
  return SignupRepository();
});

// State notifier for signup
class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier(this._repository) : super(SignupState()) {
    // Load initial captcha when the notifier is created
    _loadCaptcha();
  }

  final SignupRepository _repository;

  Future<void> _loadCaptcha() async {
    try {
      final captcha = await _repository.getCaptcha();
      state = state.copyWith(captchaText: captcha);
    } catch (e) {
      // If captcha fails to load, keep default or show error
      state = state.copyWith(captchaText: 'ERROR');
    }
  }

  Future<void> signup(SignupFormData formData) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      final request = SignupRequest(
        givenNames: formData.givenNames,
        surname: formData.surname,
        dateOfBirth: formData.dateOfBirth,
        email: formData.email,
        confirmEmail: formData.confirmEmail,
        password: formData.password,
        confirmPassword: formData.confirmPassword,
        isAgreedToReceiveNewsChecked: formData.isAgreedToReceiveNews,
        captchaInput: formData.captchaInput,
        captchaOriginal: state.captchaText,
      );

      final response = await _repository.signup(request);

      state = state.copyWith(
        isLoading: false,
        response: response,
        errorMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> refreshCaptcha() async {
    try {
      final captcha = await _repository.getCaptcha();
      state = state.copyWith(captchaText: captcha);
    } catch (e) {
      state = state.copyWith(
        captchaText: 'ERROR',
        errorMessage: 'Failed to refresh captcha',
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: '');
  }

  void reset() {
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
