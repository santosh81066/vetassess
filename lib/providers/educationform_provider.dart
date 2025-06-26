import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/services/auth_service.dart';
import 'package:vetassess/models/educationform_model.dart';
import '../utils/vetassess_api.dart';

// Enhanced result class for better error handling
class EducationSubmissionResult {
  final bool success;
  final String? errorMessage;
  final Map<String, dynamic>? errorDetails;
  final dynamic data;

  const EducationSubmissionResult({
    required this.success,
    this.errorMessage,
    this.errorDetails,
    this.data,
  });

  @override
  String toString() {
    return 'EducationSubmissionResult(success: $success, errorMessage: $errorMessage)';
  }
}

class EducationFormProvider extends StateNotifier<EducationFormData> {
  EducationFormProvider() : super(EducationFormData.empty());

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
      Map<String, String> headers,
      Map<String, dynamic> body,
      ) async {
    try {
      print('Making request to: $url');
      print('Request headers: $headers');
      print('Request body: $body');

      final response = await http
          .post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      )
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException('Request timed out after 15 seconds', const Duration(seconds: 15));
        },
      );

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

  // Enhanced helper method to convert date formats
  String? _convertDateFormat(String? dateText) {
    if (dateText == null || dateText.trim().isEmpty) return null;

    try {
      // Handle dd/mm/yyyy format
      if (dateText.contains('/')) {
        final parts = dateText.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);

          // Validate date
          final date = DateTime(year, month, day);
          if (date.day == day && date.month == month && date.year == year) {
            return '${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
          } else {
            print('Invalid date: $dateText');
            return null;
          }
        }
      }

      // Handle yyyy-mm-dd format (already correct)
      if (dateText.contains('-')) {
        final parts = dateText.split('-');
        if (parts.length == 3) {
          final year = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final day = int.parse(parts[2]);

          // Validate date
          final date = DateTime(year, month, day);
          if (date.day == day && date.month == month && date.year == year) {
            return dateText; // Already in correct format
          }
        }
      }

      print('Unable to parse date format: $dateText');
      return null;
    } catch (e) {
      print('Error converting date format: $e');
      return null;
    }
  }

  // Update primary school data
  void updatePrimarySchool({
    String? dateStarted,
    String? dateFinished,
    int? numberOfYears,
    String? country,
    int? yearCompleted,
  }) {
    state = state.copyWith(
      primarySchool: state.primarySchool.copyWith(
        dateStarted: dateStarted?.trim(),
        dateFinished: dateFinished?.trim(),
        numberOfYears: numberOfYears,
        country: country?.trim() ?? '',
        yearCompleted: yearCompleted,
      ),
    );
  }

  // Update secondary school data
  void updateSecondarySchool({
    String? dateStarted,
    String? dateFinished,
    int? numberOfYears,
    String? country,
  }) {
    state = state.copyWith(
      secondarySchool: state.secondarySchool.copyWith(
        dateStarted: dateStarted?.trim(),
        dateFinished: dateFinished?.trim(),
        numberOfYears: numberOfYears,
        country: country?.trim() ?? '',
      ),
    );
  }

  // Update highest schooling certificate data
  void updateHighestSchoolingCertificate({
    String? certificateDetails,
    int? yearObtained,
  }) {
    state = state.copyWith(
      highestSchoolingCertificate: state.highestSchoolingCertificate.copyWith(
        certificateDetails: certificateDetails?.trim() ?? '',
        yearObtained: yearObtained,
      ),
    );
  }

  // Validate form data with detailed error messages
  EducationSubmissionResult _validateFormData() {
    final errors = <String>[];

    // Primary school validation
    if (state.primarySchool.numberOfYears <= 0) {
      errors.add('Primary school number of years must be greater than 0');
    }
    if (state.primarySchool.numberOfYears > 50) {
      errors.add('Primary school number of years seems too high (max 50)');
    }
    if (state.primarySchool.country.isEmpty) {
      errors.add('Primary school country is required');
    }

    // Secondary school validation
    if (state.secondarySchool.numberOfYears <= 0) {
      errors.add('Secondary school number of years must be greater than 0');
    }
    if (state.secondarySchool.numberOfYears > 50) {
      errors.add('Secondary school number of years seems too high (max 50)');
    }
    if (state.secondarySchool.country.isEmpty) {
      errors.add('Secondary school country is required');
    }

    // Certificate validation
    if (state.highestSchoolingCertificate.certificateDetails.isEmpty) {
      errors.add('Highest schooling certificate details are required');
    }
    if (state.highestSchoolingCertificate.yearObtained <= 0) {
      errors.add('Certificate year obtained is required');
    }

    // Date validation
    if (state.primarySchool.dateStarted != null && state.primarySchool.dateFinished != null) {
      try {
        final startDate = _parseDate(state.primarySchool.dateStarted!);
        final endDate = _parseDate(state.primarySchool.dateFinished!);
        if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
          errors.add('Primary school start date cannot be after end date');
        }
      } catch (e) {
        errors.add('Invalid primary school date format');
      }
    }

    if (state.secondarySchool.dateStarted != null && state.secondarySchool.dateFinished != null) {
      try {
        final startDate = _parseDate(state.secondarySchool.dateStarted!);
        final endDate = _parseDate(state.secondarySchool.dateFinished!);
        if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
          errors.add('Secondary school start date cannot be after end date');
        }
      } catch (e) {
        errors.add('Invalid secondary school date format');
      }
    }

    if (errors.isNotEmpty) {
      return EducationSubmissionResult(
        success: false,
        errorMessage: 'Please fix the following errors:\n${errors.join('\n')}',
      );
    }

    return const EducationSubmissionResult(success: true);
  }

  // Helper method to parse dates
  DateTime? _parseDate(String dateString) {
    try {
      if (dateString.contains('/')) {
        final parts = dateString.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      print('Error parsing date: $e');
    }
    return null;
  }

  // Enhanced submit education details method
  Future<EducationSubmissionResult> submitEducationDetails({required int userId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Validate user ID
      if (userId <= 0) {
        state = state.copyWith(isLoading: false);
        return const EducationSubmissionResult(
          success: false,
          errorMessage: 'Invalid user ID',
        );
      }

      // Validate form data
      final validation = _validateFormData();
      if (!validation.success) {
        state = state.copyWith(isLoading: false);
        return validation;
      }

      // Validate API URL
      const url = VetassessApi.form_genedu;
      if (url.isEmpty) {
        state = state.copyWith(isLoading: false);
        return const EducationSubmissionResult(
          success: false,
          errorMessage: 'API URL not configured properly',
        );
      }

      print('Submitting education details for user: $userId');

      // Create educations array with the enhanced format
      List<Map<String, dynamic>> educations = [];

      // Primary School (levelId: 1)
      educations.add({
        "levelId": 1,
        "dateStarted": _convertDateFormat(state.primarySchool.dateStarted),
        "dateFinished": _convertDateFormat(state.primarySchool.dateFinished),
        "numberOfYears": state.primarySchool.numberOfYears > 0 ? state.primarySchool.numberOfYears : null,
        "country": state.primarySchool.country.isNotEmpty ? state.primarySchool.country : null,
        "yearCompleted": state.primarySchool.yearCompleted?.toString(),
        "certificateDetails": null,
      });

      // Secondary School (levelId: 2)
      educations.add({
        "levelId": 2,
        "dateStarted": _convertDateFormat(state.secondarySchool.dateStarted),
        "dateFinished": _convertDateFormat(state.secondarySchool.dateFinished),
        "numberOfYears": state.secondarySchool.numberOfYears > 0 ? state.secondarySchool.numberOfYears : null,
        "country": state.secondarySchool.country.isNotEmpty ? state.secondarySchool.country : null,
        "yearCompleted": state.highestSchoolingCertificate.yearObtained > 0
            ? state.highestSchoolingCertificate.yearObtained.toString()
            : null,
        "certificateDetails": state.highestSchoolingCertificate.certificateDetails.isNotEmpty
            ? state.highestSchoolingCertificate.certificateDetails
            : null,
      });

      // Create request body
      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "educations": educations,
      };

      // Get authenticated headers
      final headers = await _getHeaders();

      // Make HTTP request
      final response = await _makeHttpRequest(url, headers, requestBody);

      // Handle response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("✅ Education details submitted successfully!");

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

        state = state.copyWith(isLoading: false, errorMessage: null);
        return EducationSubmissionResult(
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

        state = state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
        );

        return EducationSubmissionResult(
          success: false,
          errorMessage: errorMessage,
          errorDetails: errorDetails,
        );
      }
    } catch (e) {
      print('❌ Exception during education submission: $e');
      final errorMessage = e.toString();

      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      );

      return EducationSubmissionResult(
        success: false,
        errorMessage: errorMessage,
      );
    }
  }

  // Enhanced save as draft method
  Future<EducationSubmissionResult> saveAsDraft({required int userId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Validate user ID
      if (userId <= 0) {
        state = state.copyWith(isLoading: false);
        return const EducationSubmissionResult(
          success: false,
          errorMessage: 'Invalid user ID',
        );
      }

      // For draft, we don't need full validation
      const url = VetassessApi.form_genedu; // You might need a separate draft endpoint

      if (url.isEmpty) {
        state = state.copyWith(isLoading: false);
        return const EducationSubmissionResult(
          success: false,
          errorMessage: 'API URL not configured properly',
        );
      }

      print('Saving education draft for user: $userId');

      // Create educations array (similar to submit but with action: draft)
      List<Map<String, dynamic>> educations = [];

      // Primary School (levelId: 1)
      educations.add({
        "levelId": 1,
        "dateStarted": _convertDateFormat(state.primarySchool.dateStarted),
        "dateFinished": _convertDateFormat(state.primarySchool.dateFinished),
        "numberOfYears": state.primarySchool.numberOfYears > 0 ? state.primarySchool.numberOfYears : null,
        "country": state.primarySchool.country.isNotEmpty ? state.primarySchool.country : null,
        "yearCompleted": state.primarySchool.yearCompleted?.toString(),
        "certificateDetails": null,
      });

      // Secondary School (levelId: 2)
      educations.add({
        "levelId": 2,
        "dateStarted": _convertDateFormat(state.secondarySchool.dateStarted),
        "dateFinished": _convertDateFormat(state.secondarySchool.dateFinished),
        "numberOfYears": state.secondarySchool.numberOfYears > 0 ? state.secondarySchool.numberOfYears : null,
        "country": state.secondarySchool.country.isNotEmpty ? state.secondarySchool.country : null,
        "yearCompleted": state.highestSchoolingCertificate.yearObtained > 0
            ? state.highestSchoolingCertificate.yearObtained.toString()
            : null,
        "certificateDetails": state.highestSchoolingCertificate.certificateDetails.isNotEmpty
            ? state.highestSchoolingCertificate.certificateDetails
            : null,
      });

      // Create request body with draft action
      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "action": "draft",
        "educations": educations,
      };

      // Get authenticated headers
      final headers = await _getHeaders();

      // Make HTTP request
      final response = await _makeHttpRequest(url, headers, requestBody);

      // Handle response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("✅ Education draft saved successfully!");

        dynamic responseData;
        try {
          if (response.body.isNotEmpty) {
            responseData = json.decode(response.body);
          }
        } catch (e) {
          print("Response parsing error (but draft save was successful): $e");
        }

        state = state.copyWith(isLoading: false, errorMessage: null);
        return EducationSubmissionResult(
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

        state = state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
        );

        return EducationSubmissionResult(
          success: false,
          errorMessage: errorMessage,
          errorDetails: errorDetails,
        );
      }
    } catch (e) {
      print('❌ Exception during draft save: $e');
      final errorMessage = e.toString();

      state = state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      );

      return EducationSubmissionResult(
        success: false,
        errorMessage: errorMessage,
      );
    }
  }

  // Load existing education data (if needed)
  Future<EducationSubmissionResult> loadEducationData({required int userId}) async {
    try {
      final url = '${VetassessApi.form_genedu}?userId=$userId';

      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Update state with loaded data if needed
        return EducationSubmissionResult(success: true, data: data);
      } else {
        return EducationSubmissionResult(
          success: false,
          errorMessage: _parseErrorMessage(response),
        );
      }
    } catch (e) {
      return EducationSubmissionResult(
        success: false,
        errorMessage: 'Failed to load education data: ${e.toString()}',
      );
    }
  }

  // Legacy validate form method (for backward compatibility)
  bool validateForm() {
    final result = _validateFormData();
    return result.success;
  }

  // Reset form
  void resetForm() {
    state = EducationFormData.empty();
  }

  // Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  // Check if form has any data
  bool get hasAnyData {
    return state.primarySchool.country.isNotEmpty ||
        state.primarySchool.numberOfYears > 0 ||
        state.secondarySchool.country.isNotEmpty ||
        state.secondarySchool.numberOfYears > 0 ||
        state.highestSchoolingCertificate.certificateDetails.isNotEmpty;
  }

  // Get form completion percentage
  double get completionPercentage {
    int completedFields = 0;
    const int totalFields = 6; // Required fields count

    if (state.primarySchool.numberOfYears > 0) completedFields++;
    if (state.primarySchool.country.isNotEmpty) completedFields++;
    if (state.secondarySchool.numberOfYears > 0) completedFields++;
    if (state.secondarySchool.country.isNotEmpty) completedFields++;
    if (state.highestSchoolingCertificate.certificateDetails.isNotEmpty) completedFields++;
    if (state.highestSchoolingCertificate.yearObtained > 0) completedFields++;

    return completedFields / totalFields;
  }
}

final educationFormProvider =
StateNotifierProvider<EducationFormProvider, EducationFormData>((ref) {
  return EducationFormProvider();
});

// Additional provider for loading state
final educationLoadingProvider = StateProvider<bool>((ref) => false);