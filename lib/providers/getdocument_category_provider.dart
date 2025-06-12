import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/services/auth_service.dart';
import 'package:vetassess/main.dart';
import 'dart:convert';
import 'package:vetassess/models/getdocument_category.dart';

import '../utils/vetassess_api.dart';

// Updated Provider with API integration
class DocumentCategoryProvider extends StateNotifier<DocumentCategory> {
  DocumentCategoryProvider() : super(DocumentCategory.initial());

  Future<void> fetchDocumentCategories() async {
    try {
      final headers = await AuthService.getAuthHeaders();

      const String url = VetassessApi.formdoc_cat;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final documentCategory = DocumentCategory.fromJson(jsonData);
        state = documentCategory;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception(
          'Failed to load document categories: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching document categories: $e');
      // Keep the current state or set to empty
      state = DocumentCategory.initial();
    }
  }
}

final documentCategoryProvider =
    StateNotifierProvider<DocumentCategoryProvider, DocumentCategory>((ref) {
      return DocumentCategoryProvider();
    });
