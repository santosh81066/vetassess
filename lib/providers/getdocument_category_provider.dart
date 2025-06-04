import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/Service/auth_service.dart';
import 'dart:convert';
import 'package:vetassess/models/getdocument_category.dart';

// Updated Provider with API integration
class DocumentCategoryProvider extends StateNotifier<DocumentCategory> {
  DocumentCategoryProvider() : super(DocumentCategory.initial());

  Future<void> fetchDocumentCategories() async {
    try {

      final headers = await AuthService.getAuthHeaders();

      const String apiUrl = 'http://103.98.12.226:5100';
      final response = await http.get(
        Uri.parse('$apiUrl/user/document-categories'),
        headers: headers,
      );

  if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final documentCategory = DocumentCategory.fromJson(jsonData);
        state = documentCategory;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception('Failed to load document categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching document categories: $e');
      // Keep the current state or set to empty
      state = DocumentCategory.initial();
    }
  }
}



final documentCategoryProvider = StateNotifierProvider<DocumentCategoryProvider, DocumentCategory>((ref) {
  return DocumentCategoryProvider();
});