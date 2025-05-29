// providers/login_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  static const String baseUrl = 'http://103.98.12.226:5100';

  // Fetch captcha from API
  Future<void> fetchCaptcha() async {
    
    state = state.copyWith(isLoadingCaptcha: true);
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/captcha'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final captchaResponse = CaptchaResponse.fromJson(responseData);

        state = state.copyWith(
          isLoadingCaptcha: false,
          captcha: captchaResponse.captcha,
        );
      } else {
        state = state.copyWith(
          isLoadingCaptcha: false,
          error: 'Failed to fetch captcha',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingCaptcha: false,
        error: 'Network error while fetching captcha: ${e.toString()}',
      );
    }
  }

  Future<void> login(LoginRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(responseData);

        // Store tokens in SharedPreferences
        await _storeTokens(
          loginResponse.accessToken,
          loginResponse.refreshToken,
        );

        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          response: loginResponse,
        );
      } else {
        // Handle different status codes
        String errorMessage;
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? 'Login failed';
        } catch (e) {
          errorMessage = 'Login failed. Status: ${response.statusCode}';
        }

        state = state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: errorMessage,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: 'Network error: ${e.toString()}',
      );
    }
  }

  Future<void> _storeTokens(String? accessToken, String? refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken!);
    await prefs.setString('refresh_token', refreshToken!);

    // Store login timestamp for token expiry management
    await prefs.setInt(
      'login_timestamp',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // Get stored access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Get stored refresh token
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }

  // Logout - clear tokens
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('login_timestamp');

    state = LoginState(); // Reset state
  }

  void resetState() {
    state = LoginState();
  }
}

// Provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
