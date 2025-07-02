// services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userRoleKey = 'user_role';
  static const String _userEmailKey = 'user_email';
  static const String _loginTimestampKey = 'login_timestamp';
  static const int tokenExpiryHours = 24;
  static const String baseUrl = 'https://vetassess.com.co'; // Same as your provider

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  static Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      return false;
    }

    // Check if token has expired
    return !await isTokenExpired();
  }

  static Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final loginTimestamp = prefs.getInt(_loginTimestampKey);

    if (loginTimestamp == null) return true;

    final loginTime = DateTime.fromMillisecondsSinceEpoch(loginTimestamp);
    final expiryTime = loginTime.add(Duration(hours: tokenExpiryHours));

    return DateTime.now().isAfter(expiryTime);
  }

  /// Store authentication tokens and user info
  static Future<void> storeAuthData({
    required String accessToken,
    String? refreshToken,
    String? userRole,
    String? userEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setInt(_loginTimestampKey, DateTime.now().millisecondsSinceEpoch);

    if (refreshToken != null) {
      await prefs.setString(_refreshTokenKey, refreshToken);
    }

    if (userRole != null) {
      await prefs.setString(_userRoleKey, userRole);
    }

    if (userEmail != null) {
      await prefs.setString(_userEmailKey, userEmail);
    }
  }

  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getAccessToken();

    if (token != null && token.isNotEmpty && !await isTokenExpired()) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }

    // If token is expired, try to refresh it
    if (token != null && await isTokenExpired()) {
      final refreshSuccess = await _attemptTokenRefresh();
      if (refreshSuccess) {
        final newToken = await getAccessToken();
        if (newToken != null) {
          return {
            'Authorization': 'Bearer $newToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          };
        }
      }
    }

    // Return basic headers if no valid token
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  /// Validates if the current token is still valid
  /// Returns true if token exists and hasn't expired
  static Future<bool> validateToken() async {
    final token = await getAccessToken();
    if (token == null || token.isEmpty) {
      return false;
    }

    // If token is expired, try to refresh it
    if (await isTokenExpired()) {
      return await _attemptTokenRefresh();
    }

    return true;
  }

  /// Attempts to refresh the access token using the refresh token
  static Future<bool> _attemptTokenRefresh() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'), // Adjust endpoint as needed
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'refresh_token': refreshToken,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final newAccessToken = responseData['access_token'];

        if (newAccessToken != null) {
          await storeAuthData(
            accessToken: newAccessToken,
            refreshToken: responseData['refresh_token'] ?? refreshToken,
          );
          return true;
        }
      }
    } catch (e) {
      // Refresh failed, clear auth data
      await clearAuthData();
    }

    return false;
  }

  /// Checks if the user has admin role
  static Future<bool> isAdmin() async {
    final role = await getUserRole();
    return role?.toLowerCase() == 'admin';
  }

  /// Clears all authentication data
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userRoleKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_loginTimestampKey);
  }

  /// Logout user and clear all data
  static Future<void> logout() async {
    try {
      final token = await getAccessToken();
      if (token != null && token.isNotEmpty) {
        // Optional: Call logout endpoint on server
        await http.post(
          Uri.parse('$baseUrl/auth/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
      }
    } catch (e) {
      // Even if server logout fails, clear local data
    } finally {
      await clearAuthData();
    }
  }

  /// Get user info from stored preferences
  static Future<Map<String, String?>> getUserInfo() async {
    return {
      'email': await getUserEmail(),
      'role': await getUserRole(),
    };
  }
}