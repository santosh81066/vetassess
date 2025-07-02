// providers/document_category_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/document_category_modal.dart';
import '../services/auth_service.dart'; // Import the AuthService

// Document Category Notifier
class DocumentCategoryNotifier extends StateNotifier<DocumentCategoryState> {
  DocumentCategoryNotifier() : super(DocumentCategoryState());

  static const String baseUrl = 'https://vetassess.com.co';

  // Helper method to check authentication and get headers
  Future<Map<String, String>?> _getAuthenticatedHeaders() async {
    if (!await AuthService.validateToken()) {
      state = state.copyWith(
        error: 'Authentication token expired. Please login again.',
        isLoading: false,
      );
      return null;
    }
    return await AuthService.getAuthHeaders();
  }

  // Helper method to handle common HTTP errors
  void _handleHttpError(int statusCode, String operation) {
    String errorMessage;
    switch (statusCode) {
      case 401:
        errorMessage = 'Authentication failed. Please login again.';
        break;
      case 403:
        errorMessage = 'You don\'t have permission to perform this action.';
        break;
      case 404:
        errorMessage = 'Resource not found.';
        break;
      case 422:
        errorMessage = 'Validation error. Please check your input.';
        break;
      case 500:
        errorMessage = 'Server error. Please try again later.';
        break;
      default:
        errorMessage = 'Failed to $operation: HTTP $statusCode';
    }

    state = state.copyWith(
      isLoading: false,
      error: errorMessage,
    );
  }

  // Fetch all document categories
  Future<void> fetchDocumentCategories() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return; // Authentication failed

      final response = await http.get(
        Uri.parse('$baseUrl/admin/document-category'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<DocumentCategory> categories = [];

        if (jsonData['data'] != null) {
          for (var item in jsonData['data']) {
            categories.add(DocumentCategory.fromJson(item));
          }
        }

        state = state.copyWith(
          categories: categories,
          isLoading: false,
        );
      } else {
        _handleHttpError(response.statusCode, 'fetch document categories');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Network error: Please check your connection and try again.',
      );
    }
  }

  // Add new document category
  Future<bool> addDocumentCategory(String categoryName, int subtype) async {
    state = state.copyWith(error: null);

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false; // Authentication failed

      final response = await http.post(
        Uri.parse('$baseUrl/admin/document-category'),
        headers: headers,
        body: json.encode({
          'documentCategory': categoryName,
          'subtype': subtype,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Refresh the list after successful addition
        await fetchDocumentCategories();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'add document category');
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Network error: Please check your connection and try again.',
      );
      return false;
    }
  }

  // Update document category
  Future<bool> updateDocumentCategory(int id, String categoryName, int subtype) async {
    state = state.copyWith(error: null);

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false; // Authentication failed

      final response = await http.put(
        Uri.parse('$baseUrl/admin/document-category/$id'),
        headers: headers,
        body: json.encode({
          'documentCategory': categoryName,
          'subtype': subtype,
        }),
      );

      if (response.statusCode == 200) {
        await fetchDocumentCategories();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'update document category');
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Network error: Please check your connection and try again.',
      );
      return false;
    }
  }

  // Delete document category
  Future<bool> deleteDocumentCategory(int id) async {
    state = state.copyWith(error: null);

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false; // Authentication failed

      final response = await http.delete(
        Uri.parse('$baseUrl/admin/document-category/$id'),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchDocumentCategories();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'delete document category');
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Network error: Please check your connection and try again.',
      );
      return false;
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Method to handle authentication failures
  void handleAuthenticationFailure() {
    state = state.copyWith(
      error: 'Session expired. Please login again.',
      isLoading: false,
    );
  }
}

// Provider
final documentCategoryProvider = StateNotifierProvider<DocumentCategoryNotifier, DocumentCategoryState>((ref) {
  return DocumentCategoryNotifier();
});