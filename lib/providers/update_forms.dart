import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/utils/vetassess_api.dart';

class FormsApiService {
  static const String baseUrl = VetassessApi.baseUrl;

  // Update all forms data
  static Future<bool> updateUserForms({
    required int userId,
    required String authToken,
    PersonalDetails? personalDetails,
    List<EducationQualifications>? educationQualifications,
    List<Educations>? educations,
    List<Employments>? employments,
    List<UploadedDocuments>? uploadedDocuments,
    List<UserVisas>? userVisas,
    List<UserOccupations>? userOccupations,
    List<Licences>? licences,
    PriorityProcess? priorityProcess,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/user/update-forms');

      // Build the request body
      Map<String, dynamic> requestBody = {'userId': userId};

      // Add sections only if they exist
      if (personalDetails != null) {
        requestBody['personalDetails'] = personalDetails.toJson();
      }

      if (educationQualifications != null &&
          educationQualifications.isNotEmpty) {
        requestBody['educationQualifications'] =
            educationQualifications.map((e) => e.toJson()).toList();
      }

      if (educations != null && educations.isNotEmpty) {
        requestBody['educations'] = educations.map((e) => e.toJson()).toList();
      }

      if (employments != null && employments.isNotEmpty) {
        requestBody['employments'] =
            employments.map((e) => e.toJson()).toList();
      }

      if (uploadedDocuments != null && uploadedDocuments.isNotEmpty) {
        requestBody['uploadedDocuments'] =
            uploadedDocuments.map((e) => e.toJson()).toList();
      }

      if (userVisas != null && userVisas.isNotEmpty) {
        requestBody['userVisas'] = userVisas.map((e) => e.toJson()).toList();
      }

      if (userOccupations != null && userOccupations.isNotEmpty) {
        requestBody['userOccupations'] =
            userOccupations.map((e) => e.toJson()).toList();
      }

      if (licences != null && licences.isNotEmpty) {
        requestBody['licences'] = licences.map((e) => e.toJson()).toList();
      }

      if (priorityProcess != null) {
        requestBody['priorityProcess'] = priorityProcess.toJson();
      }

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $authToken', // Adjust based on your auth format
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['message'] == 'User data updated successfully';
      } else {
        print(
          'Error updating forms: ${response.statusCode} - ${response.body}',
        );
        return false;
      }
    } catch (e) {
      print('Exception in updateUserForms: $e');
      return false;
    }
  }

  // Update individual sections
  static Future<bool> updatePersonalDetails({
    required int userId,
    required String authToken,
    required PersonalDetails personalDetails,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      personalDetails: personalDetails,
    );
  }

  static Future<bool> updateEducationQualifications({
    required int userId,
    required String authToken,
    required List<EducationQualifications> educationQualifications,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      educationQualifications: educationQualifications,
    );
  }

  static Future<bool> updateEducations({
    required int userId,
    required String authToken,
    required List<Educations> educations,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      educations: educations,
    );
  }

  static Future<bool> updateEmployments({
    required int userId,
    required String authToken,
    required List<Employments> employments,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      employments: employments,
    );
  }

  static Future<bool> updateDocuments({
    required int userId,
    required String authToken,
    required List<UploadedDocuments> documents,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      uploadedDocuments: documents,
    );
  }

  static Future<bool> updateVisas({
    required int userId,
    required String authToken,
    required List<UserVisas> visas,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      userVisas: visas,
    );
  }

  static Future<bool> updateOccupations({
    required int userId,
    required String authToken,
    required List<UserOccupations> occupations,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      userOccupations: occupations,
    );
  }

  static Future<bool> updateLicences({
    required int userId,
    required String authToken,
    required List<Licences> licences,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      licences: licences,
    );
  }

  static Future<bool> updatePriorityProcess({
    required int userId,
    required String authToken,
    required PriorityProcess priorityProcess,
  }) async {
    return await updateUserForms(
      userId: userId,
      authToken: authToken,
      priorityProcess: priorityProcess,
    );
  }
}
