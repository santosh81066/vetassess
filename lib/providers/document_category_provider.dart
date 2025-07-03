// providers/document_management_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/document_category_modal.dart';
import '../services/auth_service.dart';

// Network Service with improved error handling
class NetworkService {
  static const Duration _timeout = Duration(seconds: 30);
  static const int _maxRetries = 3;

  // Generic retry logic for GET requests
  static Future<http.Response> getWithRetry(
      String url,
      Map<String, String> headers,
      ) async {
    Exception? lastException;

    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        final response = await http
            .get(Uri.parse(url), headers: headers)
            .timeout(_timeout);

        // Return successful responses (2xx) or client errors (4xx) immediately
        if (response.statusCode >= 200 && response.statusCode < 500) {
          return response;
        }

        // For server errors (5xx), retry if not the last attempt
        if (attempt == _maxRetries) {
          return response;
        }

        // Exponential backoff
        await Future.delayed(Duration(seconds: attempt * 2));

      } on SocketException catch (e) {
        lastException = e;
        if (attempt == _maxRetries) rethrow;
        await Future.delayed(Duration(seconds: attempt * 2));
      } on http.ClientException catch (e) {
        lastException = e;
        if (attempt == _maxRetries) rethrow;
        await Future.delayed(Duration(seconds: attempt * 2));
      } catch (e) {
        lastException = e is Exception ? e : Exception(e.toString());
        if (attempt == _maxRetries) rethrow;
        await Future.delayed(Duration(seconds: attempt * 2));
      }
    }

    throw lastException ?? Exception('Max retries exceeded');
  }

  static Future<http.Response> postWithTimeout(
      String url,
      Map<String, String> headers,
      String body,
      ) async {
    try {
      return await http
          .post(Uri.parse(url), headers: headers, body: body)
          .timeout(_timeout);
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> putWithTimeout(
      String url,
      Map<String, String> headers,
      String body,
      ) async {
    try {
      return await http
          .put(Uri.parse(url), headers: headers, body: body)
          .timeout(_timeout);
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> deleteWithTimeout(
      String url,
      Map<String, String> headers,
      ) async {
    try {
      return await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(_timeout);
    } catch (e) {
      rethrow;
    }
  }
}

// Combined Document Management Notifier
class DocumentManagementNotifier extends StateNotifier<DocumentManagementState> {
  DocumentManagementNotifier() : super(const DocumentManagementState());

  static const String baseUrl = 'https://vetassess.com.co';

  // Helper method to check authentication and get headers
  Future<Map<String, String>?> _getAuthenticatedHeaders() async {
    try {
      if (!await AuthService.validateToken()) {
        state = state.setError('Authentication token expired. Please login again.');
        return null;
      }
      return await AuthService.getAuthHeaders();
    } catch (e) {
      state = state.setError('Authentication error. Please try again.');
      return null;
    }
  }

  // Helper method to handle common HTTP errors
  void _handleHttpError(int statusCode, String operation, {String? responseBody}) {
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
      case 409:
        errorMessage = 'Conflict: The resource already exists or cannot be modified.';
        break;
      case 422:
        if (responseBody != null) {
          try {
            final errorJson = json.decode(responseBody);
            if (errorJson['message'] != null) {
              errorMessage = errorJson['message'];
            } else if (errorJson['error'] != null) {
              errorMessage = errorJson['error'];
            } else {
              errorMessage = 'Validation error. Please check your input.';
            }
          } catch (e) {
            errorMessage = 'Validation error. Please check your input.';
          }
        } else {
          errorMessage = 'Validation error. Please check your input.';
        }
        break;
      case 429:
        errorMessage = 'Too many requests. Please try again later.';
        break;
      case 500:
        errorMessage = 'Server error. Please try again later.';
        break;
      case 502:
        errorMessage = 'Bad gateway. Server is temporarily unavailable.';
        break;
      case 503:
        errorMessage = 'Service unavailable. Please try again later.';
        break;
      case 504:
        errorMessage = 'Gateway timeout. Please try again later.';
        break;
      default:
        errorMessage = 'Failed to $operation: HTTP $statusCode';
    }

    state = state.setError(errorMessage);
  }

  // Helper method to handle network exceptions
  void _handleNetworkError(dynamic error, String operation) {
    String errorMessage;

    if (error is SocketException) {
      errorMessage = 'No internet connection. Please check your network and try again.';
    } else if (error is http.ClientException) {
      errorMessage = 'Connection failed. Please try again.';
    } else if (error.toString().contains('TimeoutException') ||
        error.toString().contains('timeout')) {
      errorMessage = 'Request timeout. Please check your connection and try again.';
    } else {
      errorMessage = 'Network error occurred. Please try again.';
    }

    state = state.setError(errorMessage);
  }

  // Safe JSON parsing helper
  List<T> _parseJsonList<T>(
      dynamic jsonData,
      T Function(Map<String, dynamic>) fromJson,
      String listKey,
      ) {
    final List<T> result = [];

    try {
      if (jsonData != null && jsonData[listKey] != null && jsonData[listKey] is List) {
        for (var item in jsonData[listKey]) {
          if (item is Map<String, dynamic>) {
            try {
              result.add(fromJson(item));
            } catch (e) {
              print('Error parsing item: $e');
            }
          }
        }
      }
    } catch (e) {
      print('Error parsing JSON list: $e');
    }

    return result;
  }

  // ========== DOCUMENT CATEGORIES METHODS ==========

  // Fetch all document categories
  Future<void> fetchDocumentCategories() async {
    state = state.setLoading();

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return;

      final response = await NetworkService.getWithRetry(
        '$baseUrl/user/document-categories',
        headers,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<DocumentCategory> categories = _parseJsonList(
          jsonData,
          DocumentCategory.fromJson,
          'data',
        );

        state = state.setSuccess(categories: categories);
      } else {
        _handleHttpError(response.statusCode, 'fetch document categories',
            responseBody: response.body);
      }
    } catch (e) {
      _handleNetworkError(e, 'fetch document categories');
    }
  }

  // Add new document category (main category or subcategory)
  Future<bool> addDocumentCategory({
    required String categoryName,
    int? parentCategoryId,
  }) async {
    state = state.clearError();

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false;

      // Validate input
      if (categoryName.trim().isEmpty) {
        state = state.setError('Category name cannot be empty');
        return false;
      }

      final subtypeValue = parentCategoryId ?? 0;

      final requestBody = {
        'documentCategory': categoryName.trim(),
        'Subtype': subtypeValue,
      };

      final response = await NetworkService.postWithTimeout(
        '$baseUrl/admin/document-category',
        headers,
        json.encode(requestBody),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchAllData();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'add document category',
            responseBody: response.body);
        return false;
      }
    } catch (e) {
      _handleNetworkError(e, 'add document category');
      return false;
    }
  }

  // Update document category
  Future<bool> updateDocumentCategory({
    required int id,
    required String categoryName,
    int? parentCategoryId,
  }) async {
    state = state.clearError();

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false;

      // Validate input
      if (id <= 0) {
        state = state.setError('Invalid category ID');
        return false;
      }

      if (categoryName.trim().isEmpty) {
        state = state.setError('Category name cannot be empty');
        return false;
      }

      final subtypeValue = parentCategoryId ?? 0;

      final requestBody = {
        'documentCategory': categoryName.trim(),
        'Subtype': subtypeValue,
      };

      final response = await NetworkService.putWithTimeout(
        '$baseUrl/admin/document-category/$id',
        headers,
        json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        await fetchAllData();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'update document category',
            responseBody: response.body);
        return false;
      }
    } catch (e) {
      _handleNetworkError(e, 'update document category');
      return false;
    }
  }

  // Delete document category
  Future<bool> deleteDocumentCategory(int id) async {
    state = state.clearError();

    try {
      // Validate input
      if (id <= 0) {
        state = state.setError('Invalid category ID');
        return false;
      }

      // Check if this category has subcategories
      final hasSubcategories = state.getSubCategories(id).isNotEmpty;
      if (hasSubcategories) {
        state = state.setError('Cannot delete category with subcategories. Please delete subcategories first.');
        return false;
      }

      // Check if this category has document types
      final hasDocumentTypes = state.categoryHasTypes(id);
      if (hasDocumentTypes) {
        state = state.setError('Cannot delete category with document types. Please delete document types first.');
        return false;
      }

      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false;

      final response = await NetworkService.deleteWithTimeout(
        '$baseUrl/admin/document-category/$id',
        headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchAllData();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'delete document category',
            responseBody: response.body);
        return false;
      }
    } catch (e) {
      _handleNetworkError(e, 'delete document category');
      return false;
    }
  }

  // ========== DOCUMENT TYPES METHODS ==========

  // Fetch all document types and available categories
  Future<void> fetchDocumentTypes() async {
    state = state.setLoading();

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return;

      // Fetch document types and categories concurrently
      final results = await Future.wait([
        NetworkService.getWithRetry('$baseUrl/user/document-types', headers),
        NetworkService.getWithRetry('$baseUrl/user/document-categories', headers),
      ]);

      final typesResponse = results[0];
      final categoriesResponse = results[1];

      // Check for successful responses
      if (typesResponse.statusCode != 200) {
        _handleHttpError(typesResponse.statusCode, 'fetch document types',
            responseBody: typesResponse.body);
        return;
      }

      if (categoriesResponse.statusCode != 200) {
        _handleHttpError(categoriesResponse.statusCode, 'fetch document categories',
            responseBody: categoriesResponse.body);
        return;
      }

      // Parse responses safely
      final typesJson = json.decode(typesResponse.body);
      final categoriesJson = json.decode(categoriesResponse.body);

      final List<DocumentType> documentTypes = _parseJsonList(
        typesJson,
        DocumentType.fromJson,
        'data',
      );

      final List<DocumentCategory> categories = _parseJsonList(
        categoriesJson,
        DocumentCategory.fromJson,
        'data',
      );

      state = state.setSuccess(
        documentTypes: documentTypes,
        categories: categories,
      );

    } catch (e) {
      _handleNetworkError(e, 'fetch document types');
    }
  }

  // Add new document type
  Future<bool> addDocumentType({
    required String name,
    required int docCategoryId,
  }) async {
    state = state.clearError();

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false;

      // Validate input
      if (name.trim().isEmpty) {
        state = state.setError('Document type name cannot be empty');
        return false;
      }

      if (docCategoryId <= 0) {
        state = state.setError('Please select a valid document category');
        return false;
      }

      // Check if name already exists
      if (state.isDocumentTypeNameExists(name)) {
        state = state.setError('Document type with this name already exists');
        return false;
      }

      final requestBody = {
        'name': name.trim(),
        'docCategory_id': docCategoryId,
      };

      final response = await NetworkService.postWithTimeout(
        '$baseUrl/admin/document-type',
        headers,
        json.encode(requestBody),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        await fetchAllData();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'add document type',
            responseBody: response.body);
        return false;
      }

    } catch (e) {
      _handleNetworkError(e, 'add document type');
      return false;
    }
  }

  // Update document type
  Future<bool> updateDocumentType({
    required int id,
    required String name,
    required int docCategoryId,
  }) async {
    state = state.clearError();

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false;

      // Validate input
      if (id <= 0) {
        state = state.setError('Invalid document type ID');
        return false;
      }

      if (name.trim().isEmpty) {
        state = state.setError('Document type name cannot be empty');
        return false;
      }

      if (docCategoryId <= 0) {
        state = state.setError('Please select a valid document category');
        return false;
      }

      // Check if name already exists (excluding current item)
      if (state.isDocumentTypeNameExists(name, excludeId: id)) {
        state = state.setError('Document type with this name already exists');
        return false;
      }

      final requestBody = {
        'name': name.trim(),
        'docCategory_id': docCategoryId,
      };

      final response = await NetworkService.putWithTimeout(
        '$baseUrl/admin/document-type/$id',
        headers,
        json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        await fetchAllData();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'update document type',
            responseBody: response.body);
        return false;
      }

    } catch (e) {
      _handleNetworkError(e, 'update document type');
      return false;
    }
  }

  // Delete document type
  Future<bool> deleteDocumentType(int id) async {
    state = state.clearError();

    try {
      final headers = await _getAuthenticatedHeaders();
      if (headers == null) return false;

      // Validate input
      if (id <= 0) {
        state = state.setError('Invalid document type ID');
        return false;
      }

      final response = await NetworkService.deleteWithTimeout(
        '$baseUrl/admin/document-type/$id',
        headers,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        await fetchAllData();
        return true;
      } else {
        _handleHttpError(response.statusCode, 'delete document type',
            responseBody: response.body);
        return false;
      }

    } catch (e) {
      _handleNetworkError(e, 'delete document type');
      return false;
    }
  }

  // ========== UTILITY METHODS ==========

  // Fetch all data (categories and types)
  Future<void> fetchAllData() async {
    await fetchDocumentTypes(); // This fetches both types and categories
  }

  // Get available parent categories (main categories only)
  List<DocumentCategory> getAvailableParentCategories({int? excludeCategoryId}) {
    return state.mainCategories.where((category) {
      return excludeCategoryId == null || category.id != excludeCategoryId;
    }).toList();
  }

  // Check if a category can be deleted
  bool canDeleteCategory(int categoryId) {
    return state.getSubCategories(categoryId).isEmpty &&
        !state.categoryHasTypes(categoryId);
  }

  // Get document type by ID
  DocumentType? getDocumentTypeById(int id) {
    return state.getDocumentTypeById(id);
  }

  // Get category by ID
  DocumentCategory? getCategoryById(int id) {
    return state.getCategoryById(id);
  }

  // Search document types
  List<DocumentType> searchDocumentTypes(String query) {
    return state.searchDocumentTypes(query);
  }

  // Search categories
  List<DocumentCategory> searchCategories(String query) {
    return state.searchCategories(query);
  }

  // Get document types by category
  List<DocumentType> getDocumentTypesByCategory(int categoryId) {
    return state.getTypesForCategory(categoryId);
  }

  // Get document types count by category
  Map<int, int> getDocumentTypesCountByCategory() {
    return state.getDocumentTypesCountByCategory();
  }

  // Clear error
  void clearError() {
    state = state.clearError();
  }

  // Handle authentication failures
  void handleAuthenticationFailure() {
    state = state.setError('Session expired. Please login again.');
  }

  // Refresh data
  Future<void> refresh() async {
    await fetchAllData();
  }

  // Reset state
  void reset() {
    state = const DocumentManagementState();
  }
}

// ========== PROVIDERS ==========

// Main provider
final documentManagementProvider = StateNotifierProvider<DocumentManagementNotifier, DocumentManagementState>((ref) {
  return DocumentManagementNotifier();
});

// Search providers
final categorySearchProvider = StateProvider<String>((ref) => '');
final documentTypeSearchProvider = StateProvider<String>((ref) => '');

// Filtered providers
final filteredCategoriesProvider = Provider<List<DocumentCategory>>((ref) {
  final searchQuery = ref.watch(categorySearchProvider);
  final notifier = ref.watch(documentManagementProvider.notifier);
  return notifier.searchCategories(searchQuery);
});

final filteredDocumentTypesProvider = Provider<List<DocumentType>>((ref) {
  final searchQuery = ref.watch(documentTypeSearchProvider);
  final notifier = ref.watch(documentManagementProvider.notifier);
  return notifier.searchDocumentTypes(searchQuery);
});

// Specific data providers
final mainCategoriesProvider = Provider<List<DocumentCategory>>((ref) {
  final state = ref.watch(documentManagementProvider);
  return state.mainCategories;
});

final availableCategoriesProvider = Provider<List<DocumentCategory>>((ref) {
  final state = ref.watch(documentManagementProvider);
  return state.categories;
});

final documentTypesCountByCategoryProvider = Provider<Map<int, int>>((ref) {
  final notifier = ref.watch(documentManagementProvider.notifier);
  return notifier.getDocumentTypesCountByCategory();
});

// State status providers
final isDocumentManagementLoadingProvider = Provider<bool>((ref) {
  final state = ref.watch(documentManagementProvider);
  return state.isLoading;
});

final documentManagementErrorProvider = Provider<String?>((ref) {
  final state = ref.watch(documentManagementProvider);
  return state.error;
});

final hasDocumentManagementDataProvider = Provider<bool>((ref) {
  final state = ref.watch(documentManagementProvider);
  return state.hasData;
});

final hasCategoriesProvider = Provider<bool>((ref) {
  final state = ref.watch(documentManagementProvider);
  return state.hasCategories;
});

final hasDocumentTypesProvider = Provider<bool>((ref) {
  final state = ref.watch(documentManagementProvider);
  return state.hasDocumentTypes;
});