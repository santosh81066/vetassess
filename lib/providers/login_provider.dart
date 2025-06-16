// providers/login_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetassess/utils/vetassess_api.dart';
import '../models/login_model.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState()) {
    // Check login status when provider is initialized
    _checkInitialLoginStatus();
  }

  static const int tokenExpiryHours = 24;

  // Check initial login status
  Future<void> _checkInitialLoginStatus() async {
    final isLoggedInResult = await isLoggedIn();
    if (isLoggedInResult) {
      // Get stored user role
      final userRole = await getUserRole();
      // User is logged in, set success state
      state = state.copyWith(
        isSuccess: true,
        isLoading: false,
        userRole: userRole,
      );
    } else {
      // User is not logged in, ensure state reflects this
      state = state.copyWith(
        isSuccess: false,
        isLoading: false,
        response: null,
        userRole: null,
      );
    }
  }

  // Fetch captcha from API
  Future<void> fetchCaptcha() async {
    state = state.copyWith(isLoadingCaptcha: true);
    const url = VetassessApi.captcha;
    try {
      final response = await http.get(
        Uri.parse(url),
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
    const url = VetassessApi.login;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(responseData);

        // Store user data including tokens and userId
        await _storeUserData(loginResponse);

        // Store user role (use response role or fallback to request role)
        final userRole = loginResponse.role ?? request.role;
        await _storeUserRole(userRole);

        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          response: loginResponse,
          userRole: userRole,
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
          userRole: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: 'Network error: ${e.toString()}',
        response: null,
        userRole: null,
      );
    }
  }

  // Store user data including tokens and userId
  Future<void> _storeUserData(LoginResponse loginResponse) async {
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

  // Store user role
  Future<void> _storeUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role);
  }

  // Get stored user role
  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
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

  // Add method to get userId
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
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
        // Make sure state reflects logged out status
        await _performLogout();
        return false;
      }

      // Check if token has expired
      final isExpired = await _isTokenExpired();
      if (isExpired) {
        // Try to refresh token
        final refreshSuccessful = await _tryRefreshToken();
        if (!refreshSuccessful) {
          // Refresh failed, ensure state reflects logged out status
          await _performLogout();
        }
        return refreshSuccessful;
      }

      return true;
    } catch (e) {
      // On any error, ensure user is logged out
      await _performLogout();
      return false;
    }
  }

  // Try to refresh the access token
  Future<bool> _tryRefreshToken() async {
    const url = VetassessApi.auth_refresh;

    try {
      final refreshToken = await getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        await _performLogout();
        return false;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final newAccessToken = responseData['accessToken'];
        final newRefreshToken = responseData['refreshToken'];

        // Store new tokens (maintain existing userId)
        final prefs = await SharedPreferences.getInstance();
        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await prefs.setString('access_token', newAccessToken);
        }
        if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
          await prefs.setString('refresh_token', newRefreshToken);
        }
        
        // Update login timestamp
        await prefs.setInt(
          'login_timestamp',
          DateTime.now().millisecondsSinceEpoch,
        );

        // Get stored user role and update state
        final userRole = await getUserRole();
        final userId = await getUserId();
        
        // Create a new LoginResponse with the refreshed data
        final loginResponse = LoginResponse(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
          userId: userId,
          role: userRole,
        );

        state = state.copyWith(
          isSuccess: true,
          isLoading: false,
          userRole: userRole,
          response: loginResponse,
          error: null,
        );

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

  // Clear authentication state and storage
  Future<void> _performLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('login_timestamp');
    await prefs.remove('user_id');
    await prefs.remove('user_role');

    // Reset state to logged out - this will trigger router refresh
    state = LoginState().copyWith(
      isSuccess: false,
      isLoading: false,
      response: null,
      error: null,
      userRole: null,
    );
  }

  // Clear authentication state without affecting storage
  void resetState() {
    state = LoginState().copyWith(
      isSuccess: false,
      isLoading: false,
      response: null,
      error: null,
      userRole: null,
    );
  }

  // Get user info from stored tokens (if needed)
  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final accessToken = await getAccessToken();
      final userRole = await getUserRole();

      if (accessToken == null) return null;

      return {'role': userRole, 'hasToken': true};
    } catch (e) {
      return null;
    }
  }

  // Get navigation route based on user role
  String getNavigationRouteForRole() {
    final role = state.userRole;
    switch (role) {
      case 'admin':
        return '/admin_users';
      case 'applicant':
        return '/appli_opt';
      case 'agent':
        return '/appli_opt'; // You can change this if agents have different route
      default:
        return '/appli_opt'; // Default fallback
    }
  }

  // Add this method to validate current session
  Future<bool> validateSession() async {
    final isValid = await isLoggedIn();
    if (!isValid) {
      // Session is invalid, ensure state reflects this
      await _performLogout();
    }
    return isValid;
  }
}

final userIdProvider = FutureProvider<int?>((ref) async {
  final loginNotifier = ref.read(loginProvider.notifier);
  return await loginNotifier.getUserId();
});

// Provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});