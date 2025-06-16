import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/services/auth_service.dart';
import 'package:vetassess/models/document_type.dart';
import 'dart:convert';

import 'package:vetassess/utils/vetassess_api.dart';

// Updated Provider with API integration
class GetAllformsProviders extends StateNotifier<GetAllFormsModel> {
  final Ref ref;

  GetAllformsProviders(this.ref) : super(GetAllFormsModel.initial());

  Future<void> fetchallCategories() async {
    try {
      final headers = await AuthService.getAuthHeaders();

      const url = VetassessApi.allform_upload_doc;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final GetAllFormsModels = GetAllFormsModel.fromJson(jsonData);
        state = GetAllFormsModels;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception('Failed to load all forms: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching all Forms: $e');
      // Keep the current state or set to empty
      state = GetAllFormsModel.initial();
    }
  }
}

final getAllformsProviders =
    StateNotifierProvider<GetAllformsProviders, GetAllFormsModel>((ref) {
      return GetAllformsProviders(ref);
    });
