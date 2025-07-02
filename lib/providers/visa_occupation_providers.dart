// lib/providers/visa_occupation_providers.dart (Updated with debugging)

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/models/visa_occupation_models.dart';
import 'package:vetassess/services/auth_service.dart';
import 'login_provider.dart';

// Base URL - you might want to move this to a constants file
const String baseUrl = 'https://vetassess.com.co';

// HTTP Service for API calls with authentication and debugging
class VisaOccupationService {
  static Future<Map<String, String>> _getHeaders() async {
    return await AuthService.getAuthHeaders();
  }

  // Enhanced logging method
  static void _logRequest(String method, String url, Map<String, String> headers, String? body) {
    if (kDebugMode) {
      print('=== API REQUEST ===');
      print('Method: $method');
      print('URL: $url');
      print('Headers: $headers');
      if (body != null) {
        print('Body: $body');
      }
      print('==================');
    }
  }

  static void _logResponse(int statusCode, String? body) {
    if (kDebugMode) {
      print('=== API RESPONSE ===');
      print('Status Code: $statusCode');
      if (body != null) {
        print('Response Body: $body');
      }
      print('===================');
    }
  }

  // Add visa types with enhanced debugging
  static Future<VisaTypeResponse> addVisaTypes(VisaTypeRequest request) async {
    try {
      final url = Uri.parse('$baseUrl/admin/visa-types');
      final headers = await _getHeaders();
      final body = jsonEncode(request.toJson());

      _logRequest('POST', url.toString(), headers, body);

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      _logResponse(response.statusCode, response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return VisaTypeResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Authentication failed. Please login again.');
      } else {
        // Enhanced error handling for 500 errors
        String errorMessage = 'Failed to add visa types: ${response.statusCode}';
        try {
          final errorData = jsonDecode(response.body);
          if (errorData['message'] != null) {
            errorMessage += ' - ${errorData['message']}';
          }
          if (errorData['error'] != null) {
            errorMessage += ' - ${errorData['error']}';
          }
          if (errorData['details'] != null) {
            errorMessage += ' - Details: ${errorData['details']}';
          }
        } catch (e) {
          errorMessage += ' - Response: ${response.body}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding visa types: $e');
      }
      rethrow;
    }
  }

  // Add occupations with enhanced debugging
  static Future<OccupationResponse> addOccupations(OccupationRequest request) async {
    try {
      final url = Uri.parse('$baseUrl/admin/occupations');
      final headers = await _getHeaders();
      final body = jsonEncode(request.toJson());

      _logRequest('POST', url.toString(), headers, body);

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      _logResponse(response.statusCode, response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return OccupationResponse.fromJson(data);
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Authentication failed. Please login again.');
      } else {
        // Enhanced error handling for 500 errors
        String errorMessage = 'Failed to add occupations: ${response.statusCode}';
        try {
          final errorData = jsonDecode(response.body);
          if (errorData['message'] != null) {
            errorMessage += ' - ${errorData['message']}';
          }
          if (errorData['error'] != null) {
            errorMessage += ' - ${errorData['error']}';
          }
          if (errorData['details'] != null) {
            errorMessage += ' - Details: ${errorData['details']}';
          }
          if (errorData['errors'] != null) {
            errorMessage += ' - Validation errors: ${errorData['errors']}';
          }
        } catch (e) {
          errorMessage += ' - Response: ${response.body}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding occupations: $e');
      }
      rethrow;
    }
  }

  // Test endpoint connectivity
  static Future<bool> testConnection() async {
    try {
      final url = Uri.parse('$baseUrl/admin/test'); // Or any basic endpoint
      final headers = await _getHeaders();

      _logRequest('GET', url.toString(), headers, null);

      final response = await http.get(url, headers: headers);

      _logResponse(response.statusCode, response.body);

      return response.statusCode < 400;
    } catch (e) {
      if (kDebugMode) {
        print('Connection test failed: $e');
      }
      return false;
    }
  }

  // Alternative endpoint structure for testing
  static Future<OccupationResponse> addOccupationsAlternative(OccupationRequest request) async {
    try {
      // Try different endpoint structures
      final endpoints = [
        '$baseUrl/admin/occupations',
        '$baseUrl/admin/occupation',
        '$baseUrl/api/admin/occupations',
        '$baseUrl/api/occupations',
      ];

      for (String endpoint in endpoints) {
        try {
          final url = Uri.parse(endpoint);
          final headers = await _getHeaders();
          final body = jsonEncode(request.toJson());

          if (kDebugMode) {
            print('Trying endpoint: $endpoint');
          }

          _logRequest('POST', url.toString(), headers, body);

          final response = await http.post(
            url,
            headers: headers,
            body: body,
          );

          _logResponse(response.statusCode, response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            final data = jsonDecode(response.body);
            return OccupationResponse.fromJson(data);
          } else if (response.statusCode == 404) {
            // Try next endpoint
            continue;
          } else if (response.statusCode == 401) {
            throw AuthenticationException('Authentication failed. Please login again.');
          } else {
            // If we get a 500 on the first endpoint, stop trying others
            // and return the detailed error
            String errorMessage = 'Failed to add occupations: ${response.statusCode}';
            try {
              final errorData = jsonDecode(response.body);
              if (errorData['message'] != null) {
                errorMessage += ' - ${errorData['message']}';
              }
              if (errorData['error'] != null) {
                errorMessage += ' - ${errorData['error']}';
              }
            } catch (e) {
              errorMessage += ' - Response: ${response.body}';
            }
            throw Exception(errorMessage);
          }
        } catch (e) {
          if (e is AuthenticationException) {
            rethrow;
          }
          // Continue to next endpoint
          if (kDebugMode) {
            print('Endpoint $endpoint failed: $e');
          }
        }
      }

      throw Exception('All endpoints failed');
    } catch (e) {
      if (kDebugMode) {
        print('Error in alternative method: $e');
      }
      rethrow;
    }
  }

  // Get visa types (existing method with debugging)
// Fixed getVisaTypes method in VisaOccupationService class
// Fixed getVisaTypes method in VisaOccupationService class
  static Future<List<VisaType>> getVisaTypes() async {
    try {
      final url = Uri.parse('$baseUrl/admin/visa-types');
      final headers = await _getHeaders();

      _logRequest('GET', url.toString(), headers, null);

      final response = await http.get(url, headers: headers);

      _logResponse(response.statusCode, response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // FIXED: Handle direct array response instead of expecting wrapped object
        List<dynamic> visaTypesData;
        if (data is List) {
          // Direct array response
          visaTypesData = data;
        } else if (data is Map && data['visaTypes'] != null) {
          // Wrapped response
          visaTypesData = data['visaTypes'] as List;
        } else {
          return [];
        }

        return visaTypesData
            .map((item) => VisaType(
          id: item['id']?.toString(),
          // FIXED: Map 'visaName' from API to 'name' in model
          name: item['visaName'] ?? item['name'] ?? '',
          category: item['category'] ?? '',
          // FIXED: Handle missing assessmentType field
          assessmentType: _parseToInt(item['assessmentType']) ?? 0,
          status: item['status'] ?? 'active',
          // FIXED: Handle missing isActive field (default to true)
          isActive: item['isActive'] ?? true,
          // FIXED: Handle missing createdAt field
          createdAt: item['createdAt'] != null
              ? DateTime.tryParse(item['createdAt'])
              : null,
        ))
            .toList();
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to fetch visa types: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching visa types: $e');
      }
      rethrow;
    }
  }

// Helper method to safely parse values to int
  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  // Get occupations (existing method with debugging)
  static Future<List<Occupation>> getOccupations() async {
    try {
      final url = Uri.parse('$baseUrl/admin/occupations');
      final headers = await _getHeaders();

      _logRequest('GET', url.toString(), headers, null);

      final response = await http.get(url, headers: headers);

      _logResponse(response.statusCode, response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['occupations'] != null) {
          return (data['occupations'] as List)
              .map((item) => Occupation(
            id: item['id']?.toString(),
            occupationName: item['occupationName'] ?? '',
            anzscoCode: item['anzscoCode'] ?? '',
            skillsRequirement: item['skillsRequirement'] ?? '',
            isActive: item['isActive'] ?? true,
            createdAt: item['createdAt'] != null
                ? DateTime.parse(item['createdAt'])
                : null,
          ))
              .toList();
        }
        return [];
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to fetch occupations: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching occupations: $e');
      }
      rethrow;
    }
  }

  // ... (rest of the methods remain the same but with enhanced logging)

  // Update visa type status
  static Future<bool> updateVisaTypeStatus(String id, bool isActive) async {
    try {
      final url = Uri.parse('$baseUrl/admin/visa-types/$id/status');
      final headers = await _getHeaders();
      final body = jsonEncode({'isActive': isActive});

      _logRequest('PATCH', url.toString(), headers, body);

      final response = await http.patch(
        url,
        headers: headers,
        body: body,
      );

      _logResponse(response.statusCode, response.body);

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to update visa type status: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating visa type status: $e');
      }
      rethrow;
    }
  }

  // Update occupation status
  static Future<bool> updateOccupationStatus(String id, bool isActive) async {
    try {
      final url = Uri.parse('$baseUrl/admin/occupations/$id/status');
      final headers = await _getHeaders();
      final body = jsonEncode({'isActive': isActive});

      _logRequest('PATCH', url.toString(), headers, body);

      final response = await http.patch(
        url,
        headers: headers,
        body: body,
      );

      _logResponse(response.statusCode, response.body);

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to update occupation status: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating occupation status: $e');
      }
      rethrow;
    }
  }

  // Delete visa type
  static Future<bool> deleteVisaType(String id) async {
    try {
      final url = Uri.parse('$baseUrl/admin/visa-types/$id');
      final headers = await _getHeaders();

      _logRequest('DELETE', url.toString(), headers, null);

      final response = await http.delete(url, headers: headers);

      _logResponse(response.statusCode, response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to delete visa type: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting visa type: $e');
      }
      rethrow;
    }
  }

  // Delete occupation
  static Future<bool> deleteOccupation(String id) async {
    try {
      final url = Uri.parse('$baseUrl/admin/occupations/$id');
      final headers = await _getHeaders();

      _logRequest('DELETE', url.toString(), headers, null);

      final response = await http.delete(url, headers: headers);

      _logResponse(response.statusCode, response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 401) {
        throw AuthenticationException('Authentication failed. Please login again.');
      } else {
        throw Exception('Failed to delete occupation: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting occupation: $e');
      }
      rethrow;
    }
  }
}

// Custom exception for authentication errors
class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}

// ... (rest of the state management classes remain the same)

// Visa Types State Management
class VisaTypesState {
  final List<VisaType> visaTypes;
  final bool isLoading;
  final String? error;

  VisaTypesState({
    this.visaTypes = const [],
    this.isLoading = false,
    this.error,
  });

  VisaTypesState copyWith({
    List<VisaType>? visaTypes,
    bool? isLoading,
    String? error,
  }) {
    return VisaTypesState(
      visaTypes: visaTypes ?? this.visaTypes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class VisaTypesNotifier extends StateNotifier<VisaTypesState> {
  final Ref ref;

  VisaTypesNotifier(this.ref) : super(VisaTypesState()) {
    loadVisaTypes();
  }

  Future<void> loadVisaTypes() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final visaTypes = await VisaOccupationService.getVisaTypes();
      state = state.copyWith(
        visaTypes: visaTypes,
        isLoading: false,
      );
    } catch (e) {
      if (e is AuthenticationException) {
        ref.read(loginProvider.notifier).forceLogout();
      }
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> addVisaTypes({
    required String category,
    required int assessmentType,
    required List<String> visaNames,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = VisaTypeRequest(
        category: category,
        assessmentType: assessmentType,
        visaNames: visaNames,
      );

      final response = await VisaOccupationService.addVisaTypes(request);

      final newVisaTypes = response.results
          .map((result) => VisaType.fromResult(result, category))
          .toList();

      state = state.copyWith(
        visaTypes: [...state.visaTypes, ...newVisaTypes],
        isLoading: false,
      );

      return true;
    } catch (e) {
      if (e is AuthenticationException) {
        ref.read(loginProvider.notifier).forceLogout();
      }
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  void updateVisaType(VisaType updatedVisa) {
    final updatedList = state.visaTypes.map((visa) {
      return visa.id == updatedVisa.id ? updatedVisa : visa;
    }).toList();

    state = state.copyWith(visaTypes: updatedList);
  }

  Future<bool> deleteVisaType(String id) async {
    try {
      final success = await VisaOccupationService.deleteVisaType(id);
      if (success) {
        final updatedList = state.visaTypes.where((visa) => visa.id != id).toList();
        state = state.copyWith(visaTypes: updatedList);
      }
      return success;
    } catch (e) {
      if (e is AuthenticationException) {
        ref.read(loginProvider.notifier).forceLogout();
      }
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<void> toggleVisaStatus(String id) async {
    final visa = state.visaTypes.firstWhere((v) => v.id == id);
    final newStatus = !visa.isActive;

    try {
      final success = await VisaOccupationService.updateVisaTypeStatus(id, newStatus);
      if (success) {
        final updatedList = state.visaTypes.map((visa) {
          return visa.id == id ? visa.copyWith(isActive: newStatus) : visa;
        }).toList();

        state = state.copyWith(visaTypes: updatedList);
      }
    } catch (e) {
      if (e is AuthenticationException) {
        ref.read(loginProvider.notifier).forceLogout();
      }
      state = state.copyWith(error: e.toString());
    }
  }
}

// Occupations State Management
class OccupationsState {
  final List<Occupation> occupations;
  final bool isLoading;
  final String? error;

  OccupationsState({
    this.occupations = const [],
    this.isLoading = false,
    this.error,
  });

  OccupationsState copyWith({
    List<Occupation>? occupations,
    bool? isLoading,
    String? error,
  }) {
    return OccupationsState(
      occupations: occupations ?? this.occupations,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class OccupationsNotifier extends StateNotifier<OccupationsState> {
  final Ref ref;

  OccupationsNotifier(this.ref) : super(OccupationsState()) {
    loadOccupations();
  }

  Future<void> loadOccupations() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final occupations = await VisaOccupationService.getOccupations();
      state = state.copyWith(
        occupations: occupations,
        isLoading: false,
      );
    } catch (e) {
      if (e is AuthenticationException) {
        ref.read(loginProvider.notifier).forceLogout();
      }
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> addOccupations(List<OccupationItem> occupationItems) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = OccupationRequest(occupations: occupationItems);
      final response = await VisaOccupationService.addOccupations(request);

      final newOccupations = occupationItems
          .map((item) => Occupation.fromItem(item))
          .toList();

      state = state.copyWith(
        occupations: [...state.occupations, ...newOccupations],
        isLoading: false,
      );

      return true;
    } catch (e) {
      if (e is AuthenticationException) {
        ref.read(loginProvider.notifier).forceLogout();
      }
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> addSingleOccupation({
    required String occupationName,
    required String anzscoCode,
    required String skillsRequirement,
  }) async {
    final occupationItem = OccupationItem(
      occupationName: occupationName,
      anzscoCode: anzscoCode,
      skillsRequirement: skillsRequirement,
    );

    return await addOccupations([occupationItem]);
  }

  void updateOccupation(Occupation updatedOccupation) {
    final updatedList = state.occupations.map((occupation) {
      return occupation.id == updatedOccupation.id ? updatedOccupation : occupation;
    }).toList();

    state = state.copyWith(occupations: updatedList);
  }

  Future<bool> deleteOccupation(String id) async {
    try {
      final success = await VisaOccupationService.deleteOccupation(id);
      if (success) {
        final updatedList = state.occupations.where((occupation) => occupation.id != id).toList();
        state = state.copyWith(occupations: updatedList);
      }
      return success;
    } catch (e) {
      if (e is AuthenticationException) {
        ref.read(loginProvider.notifier).forceLogout();
      }
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  Future<void> toggleOccupationStatus(String id) async {
    final occupation = state.occupations.firstWhere((o) => o.id == id);
    final newStatus = !occupation.isActive;

    try {
      final success = await VisaOccupationService.updateOccupationStatus(id, newStatus);
      if (success) {
        final updatedList = state.occupations.map((occupation) {
          return occupation.id == id ? occupation.copyWith(isActive: newStatus) : occupation;
        }).toList();

        state = state.copyWith(occupations: updatedList);
      }
    } catch (e) {
      if (e is AuthenticationException) {
        ref.read(loginProvider.notifier).forceLogout();
      }
      state = state.copyWith(error: e.toString());
    }
  }
}

// Providers
final visaTypesProvider = StateNotifierProvider<VisaTypesNotifier, VisaTypesState>((ref) {
  return VisaTypesNotifier(ref);
});

final occupationsProvider = StateNotifierProvider<OccupationsNotifier, OccupationsState>((ref) {
  return OccupationsNotifier(ref);
});