// providers/login_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState()) {
    // Check login status when provider is initialized
    _checkInitialLoginStatus();
  }

  static const String baseUrl = 'http://103.98.12.226:5100';
  static const int tokenExpiryHours = 24;

  // Check initial login status
  Future<void> _checkInitialLoginStatus() async {
    final isLoggedInResult = await isLoggedIn();
    if (isLoggedInResult) {
      // User is logged in, set success state
      state = state.copyWith(isSuccess: true, isLoading: false);
    } else {
      // User is not logged in, ensure state reflects this
      state = state.copyWith(
        isSuccess: false,
        isLoading: false,
        response: null,
      );
    }
  }

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
          error: null, // Clear any previous errors
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
          response: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: 'Network error: ${e.toString()}',
        response: null,
      );
    }
  }

  Future<void> _storeTokens(String? accessToken, String? refreshToken) async {
    final prefs = await SharedPreferences.getInstance();

    if (accessToken != null && accessToken.isNotEmpty) {
      await prefs.setString('access_token', accessToken);
    }

    if (refreshToken != null && refreshToken.isNotEmpty) {
      await prefs.setString('refresh_token', refreshToken);
    }

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

  // Check if token has expired
  Future<bool> _isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final loginTimestamp = prefs.getInt('login_timestamp');

    if (loginTimestamp == null) return true;

    final loginTime = DateTime.fromMillisecondsSinceEpoch(loginTimestamp);
    final expiryTime = loginTime.add(Duration(hours: tokenExpiryHours));

    return DateTime.now().isAfter(expiryTime);
  }

  // Check if user is logged in and token is valid
  Future<bool> isLoggedIn() async {
    try {
      final accessToken = await getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        return false;
      }

      // Check if token has expired
      final isExpired = await _isTokenExpired();
      if (isExpired) {
        // Try to refresh token
        final refreshSuccessful = await _tryRefreshToken();
        return refreshSuccessful;
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  // Try to refresh the access token
  Future<bool> _tryRefreshToken() async {
    try {
      final refreshToken = await getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final newAccessToken = responseData['accessToken'];
        final newRefreshToken = responseData['refreshToken'];

        // Store new tokens
        await _storeTokens(newAccessToken, newRefreshToken);

        // Update state to reflect successful refresh
        state = state.copyWith(isSuccess: true, isLoading: false);

        return true;
      } else {
        // Refresh failed, logout user
        await _performLogout();
        return false;
      }
    } catch (e) {
      // Refresh failed, logout user
      await _performLogout();
      return false;
    }
  }

  // Public logout method
  Future<void> logout() async {
    // Set loading state during logout
    state = state.copyWith(isLoading: true);

    try {
      // Perform the actual logout
      await _performLogout();
    } catch (e) {
      // Even if there's an error, we should still log out locally
      await _performLogout();
    }
  }

  // Force logout without API call (for cases where user manually logs out)
  Future<void> forceLogout() async {
    await _performLogout();
  }

  // Clear authentication state
  void resetState() {
    state = LoginState().copyWith(
      isSuccess: false,
      isLoading: false,
      response: null,
      error: null,
    );
  }

  // Get user info from stored tokens (if needed)
  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final accessToken = await getAccessToken();
      if (accessToken == null) return null;

      // If you need to decode JWT token to get user info
      // You can add JWT decoding logic here
      return null;
    } catch (e) {
      return null;
    }
  }

  //user id
  Future _storeUserData(LoginResponse loginResponse) async {
    final prefs = await SharedPreferences.getInstance();

    if (loginResponse.accessToken != null &&
        loginResponse.accessToken!.isNotEmpty) {
      await prefs.setString('access_token', loginResponse.accessToken!);
    }

    if (loginResponse.refreshToken != null &&
        loginResponse.refreshToken!.isNotEmpty) {
      await prefs.setString('refresh_token', loginResponse.refreshToken!);
    }

    // Store userId
    if (loginResponse.userId != null) {
      await prefs.setInt('user_id', loginResponse.userId!);
    }

    // Store login timestamp for token expiry management
    await prefs.setInt(
      'login_timestamp',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  // Add method to get userId
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // 2. Replace the existing _storeTokens method call in login method
  // In the login method, replace this line:
  // await _storeTokens(loginResponse.accessToken, loginResponse.refreshToken);
  // With:
  // await _storeUserData(loginResponse);

  // 3. Update the _performLogout method to clear userId
  Future _performLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('login_timestamp');
    await prefs.remove('user_id'); // Add this line

    // Reset state to logged out
    state = LoginState().copyWith(
      isSuccess: false,
      isLoading: false,
      response: null,
      error: null,
    );
  }

  // 4. Create a provider to access login provider from other widgets
  // Add this at the bottom of providers/login_provider.dart:
}

// Provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

final userIdProvider = FutureProvider<int?>((ref) async {
  final loginNotifier = ref.read(loginProvider.notifier);
  return await loginNotifier.getUserId();
});
