// models/document_category_modal.dart
import 'package:equatable/equatable.dart'; // Add equatable dependency for better state comparison

// Document Category Model
class DocumentCategory extends Equatable {
  final int id;
  final String documentCategory;
  final int subtype;
  final DateTime updatedAt;
  final DateTime createdAt;

  const DocumentCategory({
    required this.id,
    required this.documentCategory,
    required this.subtype,
    required this.updatedAt,
    required this.createdAt,
  });

  factory DocumentCategory.fromJson(Map<String, dynamic> json) {
    return DocumentCategory(
      id: _parseIntSafely(json['id']),
      documentCategory: json['documentCategory']?.toString() ?? '',
      subtype: _parseIntSafely(json['subtype']),
      updatedAt: _parseDateTimeSafely(json['updatedAt']),
      createdAt: _parseDateTimeSafely(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentCategory': documentCategory,
      'subtype': subtype,
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Helper method to safely parse integers
  static int _parseIntSafely(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // Helper method to safely parse DateTime
  static DateTime _parseDateTimeSafely(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  // Create a copy with new values
  DocumentCategory copyWith({
    int? id,
    String? documentCategory,
    int? subtype,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return DocumentCategory(
      id: id ?? this.id,
      documentCategory: documentCategory ?? this.documentCategory,
      subtype: subtype ?? this.subtype,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, documentCategory, subtype, updatedAt, createdAt];

  @override
  String toString() {
    return 'DocumentCategory(id: $id, documentCategory: $documentCategory, subtype: $subtype, updatedAt: $updatedAt, createdAt: $createdAt)';
  }
}

// State class for document categories
class DocumentCategoryState extends Equatable {
  final List<DocumentCategory> categories;
  final bool isLoading;
  final String? error;
  final bool hasData;

  const DocumentCategoryState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
  }) : hasData = false; // Set to false by default for const constructor

  // Private constructor for non-const instances
  const DocumentCategoryState._({
    required this.categories,
    required this.isLoading,
    required this.error,
    required this.hasData,
  });

  DocumentCategoryState copyWith({
    List<DocumentCategory>? categories,
    bool? isLoading,
    String? error,
  }) {
    final newCategories = categories ?? this.categories;
    return DocumentCategoryState._(
      categories: newCategories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasData: newCategories.isNotEmpty,
    );
  }

  // Helper method to clear error and set loading to false
  DocumentCategoryState clearError() {
    return copyWith(error: null);
  }

  // Helper method to set loading state
  DocumentCategoryState setLoading() {
    return copyWith(isLoading: true, error: null);
  }

  // Helper method to set error state
  DocumentCategoryState setError(String errorMessage) {
    return copyWith(isLoading: false, error: errorMessage);
  }

  // Helper method to set success state
  DocumentCategoryState setSuccess(List<DocumentCategory> newCategories) {
    return copyWith(
      categories: newCategories,
      isLoading: false,
      error: null,
    );
  }

  @override
  List<Object?> get props => [categories, isLoading, error];

  @override
  String toString() {
    return 'DocumentCategoryState(categories: ${categories.length}, isLoading: $isLoading, error: $error, hasData: $hasData)';
  }
}