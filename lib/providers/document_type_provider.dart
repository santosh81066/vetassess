import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/Service/auth_service.dart';
import 'package:vetassess/models/document_type.dart';
import 'dart:convert';


// Updated Provider with API integration
class DocumentTypeProvider extends StateNotifier<DocumentType> {
  DocumentTypeProvider() : super(DocumentType.initial());

  Future<void> fetchDocumentCategories() async {
    try {

      final headers = await AuthService.getAuthHeaders();

      const String apiUrl = 'http://103.98.12.226:5100';
      final response = await http.get(
        Uri.parse('$apiUrl/user/document-types'),
        headers: headers,
      );

  if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final documentTypes = DocumentType.fromJson(jsonData);
        state = documentTypes;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception('Failed to load document Types: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching document Types: $e');
      // Keep the current state or set to empty
      state = DocumentType.initial();
    }
  }
}


final documentTypeProvider = StateNotifierProvider<DocumentTypeProvider, DocumentType>((ref) {
  return DocumentTypeProvider();
});
