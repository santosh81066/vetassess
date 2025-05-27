// services/token_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TokenService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _loginTimestampKey = 'login_timestamp';
  static const String _userDataKey = 'user_data';

  // Store tokens and user data
  static Future<void> storeTokens({
    required String accessToken,
    required String refreshToken,
    Map<String, dynamic>? userData,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setInt(
      _loginTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );

    if (userData != null) {
      await prefs.setString(_userDataKey, jsonEncode(userData));
    }
  }

  // Get stored access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Get stored refresh token
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Get user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);

    if (userDataString != null) {
      try {
        return jsonDecode(userDataString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }

  // Check if token is expired (JWT tokens typically expire in 15 minutes)
  static Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_loginTimestampKey);

    if (timestamp == null) return true;

    final loginTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    // Check if more than 14 minutes have passed (1 minute buffer)
    return now.difference(loginTime).inMinutes > 14;
  }

  // Get token with Bearer prefix for HTTP headers
  static Future<String?> getBearerToken() async {
    final token = await getAccessToken();
    return token != null ? 'Bearer $token' : null;
  }

  // Clear all tokens and user data (logout)
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_loginTimestampKey);
    await prefs.remove(_userDataKey);
  }

  // Parse JWT payload (without verification - for display purposes only)
  static Map<String, dynamic>? parseJWTPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));

      return jsonDecode(decoded) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // Get user info from token
  static Future<Map<String, dynamic>?> getUserInfoFromToken() async {
    final token = await getAccessToken();
    if (token == null) return null;

    return parseJWTPayload(token);
  }
}
