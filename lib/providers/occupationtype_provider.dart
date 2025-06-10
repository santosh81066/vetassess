import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/Service/auth_service.dart';
import 'package:vetassess/models/getoccupationtype_model.dart';

class OccupationtypeProvider extends StateNotifier<OccupationTypeModel> {
  OccupationtypeProvider() : super(OccupationTypeModel.initial());
  
  Future<void> fetchDocumentCategories() async {
    try {
      final headers = await AuthService.getAuthHeaders();
      const String apiUrl = 'http://103.98.12.226:5100';
      final response = await http.get(
        Uri.parse('$apiUrl/admin/occupations'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("Select occupations fetched successfully....${response.statusCode}");
        print("Select occupations fetched successfully....${response.body}");
        final jsonData = json.decode(response.body);
        final documentTypes = OccupationTypeModel.fromJson(jsonData);
        state = documentTypes;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception('Failed to load occupation Types: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching occupation Types: $e');
      // Keep the current state or set to empty
      state = OccupationTypeModel.initial();
    }
  }

  Future<bool> submitOccupations({
    required int userId,
    required int visaId,
    required int occupationId
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "visaId": visaId,
        "occupationId": occupationId
      };

      final headers = await AuthService.getAuthHeaders();
      const String apiUrl = 'http://103.98.12.226:5100';
      
      print('Sending request to: $apiUrl/admin/submit-selection');
      print('Request body: $requestBody');
      print('Headers: $headers');

      final response = await http.post(
        Uri.parse('$apiUrl/admin/submit-selection'),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Check for successful status codes (200, 201, etc.)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("✅ Occupation submission successful!");
        
        // Optionally parse the response to get more details
        try {
          final responseData = json.decode(response.body);
          if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
            print("Server message: ${responseData['message']}");
          }
        } catch (e) {
          print("Response parsing error (but submission was successful): $e");
        }
        
        return true;
      } else if (response.statusCode == 401) {
        print("❌ Unauthorized: Please login again");
        throw Exception('Unauthorized: Please login again');
      } else {
        print("❌ Server error: ${response.statusCode}");
        print("Error response: ${response.body}");
        return false;
      }
    } catch (e) {
      print('❌ Error submitting occupation: $e');
      return false;
    }
  }
}

final occupationtypeProvider = StateNotifierProvider<OccupationtypeProvider, OccupationTypeModel>((ref) {
  return OccupationtypeProvider();
});