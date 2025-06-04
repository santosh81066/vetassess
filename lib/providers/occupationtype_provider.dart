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

 Future<bool> submitOccupations(
      {
        required int userId,
        required int visaId
      }
     ) async {
    try {
      
        final Map<String, dynamic> requestBody = {
        "userId": userId ,       
        "visaId": visaId,
        "occupationId": 27
        
      };
      final headers = await AuthService.getAuthHeaders();

      const String apiUrl = 'http://103.98.12.226:5100';
      final response = await http.post(
        Uri.parse('$apiUrl/admin/submit-selection'),
        headers: headers,
        body: jsonEncode(requestBody),
      );
     print('sending ids.....$requestBody');

      if (response.statusCode == 200) {
      print("occupations File submit successfully....${response.statusCode}");
      print("occupations file successfully....${response.body}");
      // final jsonData = json.decode(response.body);
      // final documentTypes = OccupationTypeModel.fromJson(jsonData);
      // state = documentTypes;
      return true; // ✅ Return true on success
      } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Please login again');
      } else {
      print('Failed response: ${response.body}');
      return false; // ✅ Return false on error
      }

      } catch (e) {
      print('Error submit occupation file: $e');
      
      return false; // ✅ Return false on error
    }
  }
  }


final occupationtypeProvider = StateNotifierProvider<OccupationtypeProvider, OccupationTypeModel>((ref) {
  return OccupationtypeProvider();
});