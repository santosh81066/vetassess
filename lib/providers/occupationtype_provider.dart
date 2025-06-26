import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/services/auth_service.dart';
import 'package:vetassess/models/getoccupationtype_model.dart';
import '../utils/vetassess_api.dart';

// Result class for better error handling
class OccupationSubmissionResult {
  final bool success;
  final String? errorMessage;
  final Map<String, dynamic>? errorDetails;
  final dynamic data;

  const OccupationSubmissionResult({
    required this.success,
    this.errorMessage,
    this.errorDetails,
    this.data,
  });

  @override
  String toString() {
    return 'OccupationSubmissionResult(success: $success, errorMessage: $errorMessage)';
  }
}

class OccupationtypeProvider extends StateNotifier<OccupationTypeModel> {
  OccupationtypeProvider() : super(OccupationTypeModel.initial());

  // Enhanced method to get authenticated headers
  Future<Map<String, String>> _getHeaders() async {
    try {
      final headers = await AuthService.getAuthHeaders();
      headers['Content-Type'] = 'application/json';
      headers['Accept'] = 'application/json';
      headers['User-Agent'] = 'VetAssess-Flutter-App/1.0';
      return headers;
    } catch (e) {
      print('Error getting auth headers: $e');
      rethrow;
    }
  }

  // Enhanced error message parsing
  String _parseErrorMessage(http.Response response) {
    String errorMessage = 'Unknown error occurred';

    try {
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> errorDetails = json.decode(response.body);

        // Try different possible error message keys
        if (errorDetails.containsKey('message')) {
          errorMessage = errorDetails['message'].toString();
        } else if (errorDetails.containsKey('error')) {
          errorMessage = errorDetails['error'].toString();
        } else if (errorDetails.containsKey('detail')) {
          errorMessage = errorDetails['detail'].toString();
        } else if (errorDetails.containsKey('errors')) {
          // Handle validation errors array
          final errors = errorDetails['errors'];
          if (errors is List && errors.isNotEmpty) {
            errorMessage = errors.map((e) => e.toString()).join(', ');
          } else if (errors is Map) {
            errorMessage = errors.values.join(', ');
          }
        } else {
          // If no specific error field, use the whole response
          errorMessage = response.body;
        }
      } else {
        errorMessage = 'HTTP ${response.statusCode}: ${_getHttpStatusMessage(response.statusCode)}';
      }
    } catch (e) {
      print('Could not parse error response: $e');
      errorMessage = response.body.isNotEmpty
          ? response.body
          : 'HTTP ${response.statusCode}: ${_getHttpStatusMessage(response.statusCode)}';
    }

    return errorMessage;
  }

  // Get human-readable HTTP status messages
  String _getHttpStatusMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request - Invalid data submitted';
      case 401:
        return 'Unauthorized - Please login again';
      case 403:
        return 'Forbidden - Access denied';
      case 404:
        return 'Not Found - API endpoint not available';
      case 422:
        return 'Validation Error - Please check your data';
      case 429:
        return 'Too Many Requests - Please try again later';
      case 500:
        return 'Internal Server Error - Please try again later';
      case 502:
        return 'Bad Gateway - Server temporarily unavailable';
      case 503:
        return 'Service Unavailable - Please try again later';
      case 504:
        return 'Gateway Timeout - Request timed out';
      default:
        return 'Unexpected error';
    }
  }

  // Enhanced HTTP request method
  Future<http.Response> _makeHttpRequest(
      String url,
      Map<String, String> headers, {
        Map<String, dynamic>? body,
        String method = 'GET',
      }) async {
    try {
      print('Making $method request to: $url');
      print('Request headers: $headers');
      if (body != null) print('Request body: $body');

      late http.Response response;

      if (method == 'GET') {
        response = await http
            .get(Uri.parse(url), headers: headers)
            .timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            throw TimeoutException('Request timed out after 15 seconds', const Duration(seconds: 15));
          },
        );
      } else if (method == 'POST') {
        response = await http
            .post(
          Uri.parse(url),
          headers: headers,
          body: body != null ? json.encode(body) : null,
        )
            .timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            throw TimeoutException('Request timed out after 15 seconds', const Duration(seconds: 15));
          },
        );
      }

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      return response;
    } on SocketException catch (e) {
      print('Socket Exception: $e');
      throw Exception('Network connection failed. Please check your internet connection.');
    } on TimeoutException catch (e) {
      print('Timeout Exception: $e');
      throw Exception('Request timed out. Please try again.');
    } on FormatException catch (e) {
      print('Format Exception: $e');
      throw Exception('Invalid data format. Please check your input.');
    } catch (e) {
      print('HTTP Request Exception: $e');
      if (e.toString().contains('ClientException')) {
        throw Exception('Failed to connect to server. Please check your internet connection and try again.');
      }
      rethrow;
    }
  }

  // Enhanced fetch document categories method
  Future<void> fetchDocumentCategories() async {
    try {
      // Validate API URL
      const url = VetassessApi.form_occutype;
      if (url.isEmpty) {
        print('API URL not configured properly');
        state = OccupationTypeModel.initial();
        return;
      }

      final headers = await _getHeaders();
      final response = await _makeHttpRequest(url, headers);

      if (response.statusCode == 200) {
        print("✅ Occupations fetched successfully: ${response.statusCode}");
        print("Response body: ${response.body}");

        try {
          final jsonData = json.decode(response.body);
          final occupationTypes = OccupationTypeModel.fromJson(jsonData);
          state = occupationTypes;
          print("✅ Occupations parsed and set to state successfully");
        } catch (e) {
          print('❌ Error parsing occupation data: $e');
          state = OccupationTypeModel.initial();
        }
      } else if (response.statusCode == 401) {
        print('❌ Unauthorized: Please login again');
        state = OccupationTypeModel.initial();
        throw Exception('Unauthorized: Please login again');
      } else {
        final errorMessage = _parseErrorMessage(response);
        print('❌ Failed to load occupation types: $errorMessage');
        state = OccupationTypeModel.initial();
        throw Exception('Failed to load occupation types: $errorMessage');
      }
    } catch (e) {
      print('❌ Error fetching occupation types: $e');
      // Keep the current state or set to empty
      state = OccupationTypeModel.initial();
      rethrow; // Re-throw to let the UI handle the error
    }
  }

  // Enhanced submit occupations method
  Future<OccupationSubmissionResult> submitOccupations({
    required int userId,
    required int visaId,
    required int occupationId,
  }) async {
    try {
      // Validate inputs
      if (userId <= 0) {
        return const OccupationSubmissionResult(
          success: false,
          errorMessage: 'Invalid user ID',
        );
      }

      if (visaId <= 0) {
        return const OccupationSubmissionResult(
          success: false,
          errorMessage: 'Invalid visa ID',
        );
      }

      if (occupationId <= 0) {
        return const OccupationSubmissionResult(
          success: false,
          errorMessage: 'Invalid occupation ID',
        );
      }

      // Validate API URL
      const url = VetassessApi.form_occupation;
      if (url.isEmpty) {
        return const OccupationSubmissionResult(
          success: false,
          errorMessage: 'API URL not configured properly',
        );
      }

      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "visaId": visaId,
        "occupationId": occupationId,
      };

      final headers = await _getHeaders();
      final response = await _makeHttpRequest(url, headers, body: requestBody, method: 'POST');

      // Handle response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("✅ Occupation submission successful!");

        // Try to parse response data
        dynamic responseData;
        try {
          if (response.body.isNotEmpty) {
            responseData = json.decode(response.body);
            if (responseData is Map<String, dynamic> &&
                responseData.containsKey('message')) {
              print("Server message: ${responseData['message']}");
            }
          }
        } catch (e) {
          print("Response parsing error (but submission was successful): $e");
        }

        return OccupationSubmissionResult(
          success: true,
          data: responseData,
        );
      } else {
        print("❌ Server error: ${response.statusCode}");

        final errorMessage = _parseErrorMessage(response);
        Map<String, dynamic>? errorDetails;

        try {
          if (response.body.isNotEmpty) {
            errorDetails = json.decode(response.body);
          }
        } catch (e) {
          print('Could not parse error response as JSON');
        }

        return OccupationSubmissionResult(
          success: false,
          errorMessage: errorMessage,
          errorDetails: errorDetails,
        );
      }
    } catch (e) {
      print('❌ Exception during occupation submission: $e');
      return OccupationSubmissionResult(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  // New method to save as draft
  Future<OccupationSubmissionResult> saveAsDraft({
    required int userId,
    int? visaId,
    int? occupationId,
    String? assessmentType,
  }) async {
    try {
      // Validate user ID
      if (userId <= 0) {
        return const OccupationSubmissionResult(
          success: false,
          errorMessage: 'Invalid user ID',
        );
      }

      // For draft, some fields can be null/empty
      const url = VetassessApi.form_occupation; // You might need a separate draft endpoint

      if (url.isEmpty) {
        return const OccupationSubmissionResult(
          success: false,
          errorMessage: 'API URL not configured properly',
        );
      }

      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "action": "draft",
        "visaId": visaId,
        "occupationId": occupationId,
        "assessmentType": assessmentType,
      };

      // Remove null values
      requestBody.removeWhere((key, value) => value == null);

      final headers = await _getHeaders();
      final response = await _makeHttpRequest(url, headers, body: requestBody, method: 'POST');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("✅ Draft saved successfully!");

        dynamic responseData;
        try {
          if (response.body.isNotEmpty) {
            responseData = json.decode(response.body);
          }
        } catch (e) {
          print("Response parsing error (but draft save was successful): $e");
        }

        return OccupationSubmissionResult(
          success: true,
          data: responseData,
        );
      } else {
        print("❌ Draft save failed: ${response.statusCode}");

        final errorMessage = _parseErrorMessage(response);
        Map<String, dynamic>? errorDetails;

        try {
          if (response.body.isNotEmpty) {
            errorDetails = json.decode(response.body);
          }
        } catch (e) {
          print('Could not parse error response as JSON');
        }

        return OccupationSubmissionResult(
          success: false,
          errorMessage: errorMessage,
          errorDetails: errorDetails,
        );
      }
    } catch (e) {
      print('❌ Exception during draft save: $e');
      return OccupationSubmissionResult(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  // Load existing occupation data (if needed)
  Future<OccupationSubmissionResult> loadOccupationData({required int userId}) async {
    try {
      final url = '${VetassessApi.form_occupation}?userId=$userId';

      final headers = await _getHeaders();
      final response = await _makeHttpRequest(url, headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Update state with loaded data if needed
        return OccupationSubmissionResult(success: true, data: data);
      } else {
        return OccupationSubmissionResult(
          success: false,
          errorMessage: _parseErrorMessage(response),
        );
      }
    } catch (e) {
      return OccupationSubmissionResult(
        success: false,
        errorMessage: 'Failed to load occupation data: ${e.toString()}',
      );
    }
  }

  // Clear state
  void clearState() {
    state = OccupationTypeModel.initial();
  }

  // Check if occupations are loaded
  bool get hasOccupations {
    return state.occupations != null && state.occupations!.isNotEmpty;
  }

  // Get occupation by ID
  Occupations? getOccupationById(int id) {
    if (state.occupations == null) return null;

    try {
      return state.occupations!.firstWhere((occupation) => occupation.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search occupations by name or code
  List<Occupations> searchOccupations(String query) {
    if (state.occupations == null || query.trim().isEmpty) {
      return state.occupations ?? [];
    }

    final lowercaseQuery = query.toLowerCase();
    return state.occupations!.where((occupation) {
      final name = occupation.occupationName?.toLowerCase() ?? '';
      final code = occupation.anzscoCode?.toLowerCase() ?? '';
      return name.contains(lowercaseQuery) || code.contains(lowercaseQuery);
    }).toList();
  }
}

final occupationtypeProvider =
StateNotifierProvider<OccupationtypeProvider, OccupationTypeModel>((ref) {
  return OccupationtypeProvider();
});

// Additional provider for loading state
final occupationLoadingProvider = StateProvider<bool>((ref) => false);