import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/services/auth_service.dart';
import 'package:vetassess/models/document_type.dart';
import 'dart:convert';

import 'package:vetassess/utils/vetassess_api.dart';

// Updated Provider with API integration
class DocumentTypeProvider extends StateNotifier<DocumentType> {
  DocumentTypeProvider() : super(DocumentType.initial());

  Future<void> getDocumentTypes() async {
    try {
      final headers = await AuthService.getAuthHeaders();

      const url = VetassessApi.formdoc_type;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final documentTypes = DocumentType.fromJson(jsonData);
        state = documentTypes;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please login again');
      } else {
        throw Exception(
          'Failed to load document Types: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching document Types: $e');
      // Keep the current state or set to empty
      state = DocumentType.initial();
    }
  }
}

final documentTypeProvider =
    StateNotifierProvider<DocumentTypeProvider, DocumentType>((ref) {
      return DocumentTypeProvider();
    });
