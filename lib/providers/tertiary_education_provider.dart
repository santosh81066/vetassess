import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/Service/auth_service.dart';
import 'package:vetassess/models/tertiary_education_model.dart';



class TertiaryEducationProvider extends StateNotifier<TertiaryEducationState> {
  TertiaryEducationProvider() : super(const TertiaryEducationState());

  // Replace with your actual API endpoint
  static const String _baseUrl = 'http://103.98.12.226:5100';
  static const String _endpoint = '/user/tertiary-qualification';

  Future<bool> submitTertiaryEducation({
    required int userId,
    required Map<String, dynamic> formData,
  }) async {
    try {
      // Set loading state
      state = state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);

      // Prepare the API payload
      final payload = _preparePayload(userId, formData);

      print('Sending payload: ${jsonEncode(payload)}'); // Debug print

      final headers = await AuthService.getAuthHeaders();

      // Make API call
      final response = await http.post(
        Uri.parse('$_baseUrl$_endpoint'),
      headers: headers,
        body: jsonEncode(payload),
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        Map<String, dynamic>? responseData;
        try {
          responseData = jsonDecode(response.body);
        } catch (e) {
          // If response is not JSON, that's okay
          responseData = {'message': 'Success'};
        }

        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          responseData: responseData,
        );
        return true;
      } else {
        // Handle error response
        String errorMessage = 'Failed to save tertiary education data';
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorData['error'] ?? errorMessage;
        } catch (e) {
          // If error response is not JSON, use status code
          errorMessage = 'Server error: ${response.statusCode}';
        }
        
        state = state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: errorMessage,
        );
        return false;
      }
    } catch (e) {
      // Handle network or other errors
      print('API Error: $e'); // Debug print
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: 'Network error: ${e.toString()}',
      );
      return false;
    }
  }
  

  Map<String, dynamic> _preparePayload(int userId, Map<String, dynamic> formData) {
    // Helper function to safely get string values
    String? getStringValue(String key) {
      final value = formData[key];
      return (value != null && value.toString().trim().isNotEmpty) 
          ? value.toString().trim() 
          : null;
    }

    // Helper function to safely get int values
    int? getIntValue(String key) {
      final value = formData[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return int.tryParse(value.toString().trim());
      }
      return null;
    }

    // Prepare course length - combine years and semesters
    String? courseLengthYearsOrSemesters;
    final years = getStringValue('courseLengthYears');
    final semesters = getStringValue('courseLengthSemesters');
    
    if (years != null) {
      courseLengthYearsOrSemesters = '$years years';
    } else if (semesters != null) {
      courseLengthYearsOrSemesters = '$semesters semesters';
    }

    // Prepare semester length (you can adjust this logic as needed)
    String? semesterLengthWeeksOrMonths;
    final hoursPerWeek = getStringValue('hoursPerWeek');
    if (hoursPerWeek != null) {
      // You might want to calculate this differently based on your business logic
      semesterLengthWeeksOrMonths = hoursPerWeek;
    }

    // Build the payload matching your API structure
    final payload = <String, dynamic>{
      'userId': userId,
    };

    // Add optional fields only if they have values
    final stringFields = {
      'studentRegistrationNumber': 'studentRegistration',
      'qualificationName': 'qualificationName',
      'majorField': 'majorField',
      'awardingBodyName': 'awardingBodyName',
      'campusAttended': 'campusAttended',
      'institutionName': 'institutionName',
      'streetAddress1': 'streetAddress1',
      'streetAddress2': 'streetAddress2',
      'suburbCity': 'suburbCity',
      'state': 'state',
      'postCode': 'postCode',
      'normalEntryRequirement': 'normalEntryRequirement',
      'entryBasis': 'entryBasis',
      'courseStartDate': 'courseStartDate',
      'courseEndDate': 'courseEndDate',
      'qualificationAwardedDate': 'qualificationAwardedDate',
      'activityDetails': 'activityDetails',
    };

    // Add string fields
    stringFields.forEach((apiKey, formKey) {
      final value = getStringValue(formKey);
      if (value != null) {
        payload[apiKey] = value;
      }
    });

    // Add dropdown fields
    if (formData['awardingBodyCountry'] != null) {
      payload['awardingBodyCountry'] = formData['awardingBodyCountry'];
    }
    if (formData['institutionCountry'] != null) {
      payload['institutionCountry'] = formData['institutionCountry'];
    }
    if (formData['studyMode'] != null) {
      payload['studyMode'] = formData['studyMode'];
    }

    // Add course length
    if (courseLengthYearsOrSemesters != null) {
      payload['courseLengthYearsOrSemesters'] = courseLengthYearsOrSemesters;
    }
    if (semesterLengthWeeksOrMonths != null) {
      payload['semesterLengthWeeksOrMonths'] = semesterLengthWeeksOrMonths;
    }

    // Add hours per week as integer
    final hoursPerWeekInt = getIntValue('hoursPerWeek');
    if (hoursPerWeekInt != null) {
      payload['hoursPerWeek'] = hoursPerWeekInt;
    }

    // Add weeks for activities only if checkboxes are selected
    if (formData['internshipChecked'] == true) {
      final weeks = getIntValue('internshipWeeks');
      if (weeks != null) {
        payload['internshipWeeks'] = weeks;
      }
    }

    if (formData['thesisChecked'] == true) {
      final weeks = getIntValue('thesisWeeks');
      if (weeks != null) {
        payload['thesisWeeks'] = weeks;
      }
    }

    if (formData['majorProjectChecked'] == true) {
      final weeks = getIntValue('majorProjectWeeks');
      if (weeks != null) {
        payload['majorProjectWeeks'] = weeks;
      }
    }

    return payload;
  }

  // Reset state
  void resetState() {
    state = const TertiaryEducationState();
  }

  // Clear error message
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final tertiaryEducationProvider = StateNotifierProvider<TertiaryEducationProvider, TertiaryEducationState>((ref) {
  return TertiaryEducationProvider();
});