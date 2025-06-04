// providers/educationform_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/Service/auth_service.dart';
import 'package:vetassess/models/educationform_model.dart'; // Import your models

class EducationFormProvider extends StateNotifier<EducationFormData> {
  EducationFormProvider() : super(EducationFormData.empty());

  // Helper method to convert MM/yyyy format to a proper date string
  String? _convertDateFormat(String? dateText) {
    if (dateText == null || dateText.isEmpty) return null;
    
    // Assuming the input is in MM/yyyy format
    if (dateText.contains('/')) {
      final parts = dateText.split('/');
      if (parts.length == 2) {
        return '${parts[1]}-${parts[0].padLeft(2, '0')}-01'; // Convert to yyyy-MM-dd format
      }
    }
    return dateText;
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
        dateStarted: dateStarted,
        dateFinished: dateFinished,
        numberOfYears: numberOfYears,
        country: country,
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
        dateStarted: dateStarted,
        dateFinished: dateFinished,
        numberOfYears: numberOfYears,
        country: country,
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
        certificateDetails: certificateDetails,
        yearObtained: yearObtained,
      ),
    );
  }

  // Submit education details with new format
  Future<bool> submitEducationDetails({required int userId}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      print('Submitting education details for user: $userId');
      const String apiUrl = 'http://103.98.12.226:5100';

      // Create educations array with the new format
      List<Map<String, dynamic>> educations = [];

      // Primary School (levelId: 1)
      educations.add({
        "levelId": 1,
        "dateStarted": _convertDateFormat(state.primarySchool.dateStarted),
        "dateFinished": _convertDateFormat(state.primarySchool.dateFinished),
        "numberOfYears": state.primarySchool.numberOfYears > 0 ? state.primarySchool.numberOfYears : null,
        "country": state.primarySchool.country.isNotEmpty ? state.primarySchool.country : null,
        "yearCompleted": state.primarySchool.yearCompleted?.toString(),
        "certificateDetails": null
      });

      // Secondary School (levelId: 2)
      educations.add({
        "levelId": 2,
        "dateStarted": _convertDateFormat(state.secondarySchool.dateStarted),
        "dateFinished": _convertDateFormat(state.secondarySchool.dateFinished),
        "numberOfYears": state.secondarySchool.numberOfYears > 0 ? state.secondarySchool.numberOfYears : null,
        "country": state.secondarySchool.country.isNotEmpty ? state.secondarySchool.country : null,
        "yearCompleted": state.highestSchoolingCertificate.yearObtained > 0 ? state.highestSchoolingCertificate.yearObtained.toString() : null,
        "certificateDetails": state.highestSchoolingCertificate.certificateDetails.isNotEmpty ? state.highestSchoolingCertificate.certificateDetails : null
      });

      // Create request body with new format
      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "educations": educations
      };

      // Get headers with authentication token
      final headers = await AuthService.getAuthHeaders();

      print('Request body: $requestBody');

      final response = await http.post(
        Uri.parse('$apiUrl/api/education/'),
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        final errorMessage = 'Error submitting education details: ${response.statusCode}';
        print(errorMessage);
        print('Response body: ${response.body}');
        state = state.copyWith(isLoading: false, errorMessage: errorMessage);
        return false;
      }
    } catch (e) {
      final errorMessage = 'Exception occurred while submitting education details: $e';
      print(errorMessage);
      state = state.copyWith(isLoading: false, errorMessage: errorMessage);
      return false;
    }
  }

  // Validate form data
  bool validateForm() {
    // Check required fields
    if (state.primarySchool.numberOfYears <= 0) return false;
    if (state.primarySchool.country.isEmpty) return false;
    if (state.secondarySchool.numberOfYears <= 0) return false;
    if (state.secondarySchool.country.isEmpty) return false;
    if (state.highestSchoolingCertificate.certificateDetails.isEmpty) return false;
    if (state.highestSchoolingCertificate.yearObtained <= 0) return false;
    
    return true;
  }

  // Reset form
  void resetForm() {
    state = EducationFormData.empty();
  }
}

final educationFormProvider = StateNotifierProvider<EducationFormProvider, EducationFormData>((ref) {
  return EducationFormProvider();
});