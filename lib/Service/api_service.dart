// services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class ApiService {
  static const String baseUrl = 'http://103.98.12.226:5100';

  // Generic GET request with automatic token handling
  static Future<http.Response> get(String endpoint) async {
    final headers = await _getHeaders();

    return await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
  }

  // Generic POST request with automatic token handling
  static Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final headers = await _getHeaders();

    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // Generic PUT request with automatic token handling
  static Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final headers = await _getHeaders();

    return await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }

  // Generic DELETE request with automatic token handling
  static Future<http.Response> delete(String endpoint) async {
    final headers = await _getHeaders();

    return await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);
  }

  // Get headers with authorization token
  static Future<Map<String, String>> _getHeaders({
    bool includeAuth = true,
  }) async {
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (includeAuth) {
      final bearerToken = await TokenService.getBearerToken();
      if (bearerToken != null) {
        headers['Authorization'] = bearerToken;
      }
    }

    return headers;
  }

  // Public method to get headers without auth (for login, register, etc.)
  static Map<String, String> getPublicHeaders() {
    return {'Content-Type': 'application/json'};
  }

  // Handle API response
  static Map<String, dynamic>? handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Handle API errors
  static String handleError(http.Response response) {
    try {
      final errorData = jsonDecode(response.body) as Map<String, dynamic>;
      return errorData['message'] ?? 'API Error: ${response.statusCode}';
    } catch (e) {
      return 'API Error: ${response.statusCode}';
    }
  }
}
