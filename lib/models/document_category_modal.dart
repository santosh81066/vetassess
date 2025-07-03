// models/document_models.dart
import 'package:equatable/equatable.dart';

// Document Category Model with Hierarchical Support
class DocumentCategory extends Equatable {
  final int id;
  final String documentCategory;
  final int subtype; // If this equals another category's ID, it's a subcategory
  final DateTime updatedAt;
  final DateTime createdAt;
  final ParentCategory? parentCategory; // Present if this is a subcategory

  const DocumentCategory({
    required this.id,
    required this.documentCategory,
    required this.subtype,
    required this.updatedAt,
    required this.createdAt,
    this.parentCategory,
  });

  // Check if this category is a main category (no parent)
  bool get isMainCategory => parentCategory == null && subtype == 0;

  // Check if this category is a subcategory (has parent)
  bool get isSubCategory => parentCategory != null && subtype > 0;

  // Get parent category name if it's a subcategory
  String get parentCategoryName => parentCategory?.documentCategory ?? '';

  // Get full category path (Parent > Child)
  String get fullCategoryPath {
    if (isSubCategory) {
      return '${parentCategoryName} > ${documentCategory}';
    }
    return documentCategory;
  }

  // Get formatted creation date
  String get formattedCreatedDate {
    return '${createdAt.day.toString().padLeft(2, '0')}/'
        '${createdAt.month.toString().padLeft(2, '0')}/'
        '${createdAt.year}';
  }

  // Check if the category was created recently (within the last 30 days)
  bool get isRecentlyCreated {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inDays <= 30;
  }

  factory DocumentCategory.fromJson(Map<String, dynamic> json) {
    return DocumentCategory(
      id: _parseIntSafely(json['id']),
      documentCategory: json['documentCategory']?.toString() ?? '',
      subtype: _parseIntSafely(json['Subtype'] ?? json['subtype']),
      updatedAt: _parseDateTimeSafely(json['updatedAt']),
      createdAt: _parseDateTimeSafely(json['createdAt']),
      parentCategory: json['ParentCategory'] != null
          ? ParentCategory.fromJson(json['ParentCategory'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentCategory': documentCategory,
      'Subtype': subtype,
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      if (parentCategory != null)
        'ParentCategory': parentCategory!.toJson(),
    };
  }

  // Create JSON for API requests
  Map<String, dynamic> toApiJson() {
    return {
      'documentCategory': documentCategory,
      'Subtype': subtype,
    };
  }

  // Helper method to safely parse integers
  static int _parseIntSafely(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
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
    if (value is DateTime) return value;
    return DateTime.now();
  }

  // Create a copy with new values
  DocumentCategory copyWith({
    int? id,
    String? documentCategory,
    int? subtype,
    DateTime? updatedAt,
    DateTime? createdAt,
    ParentCategory? parentCategory,
  }) {
    return DocumentCategory(
      id: id ?? this.id,
      documentCategory: documentCategory ?? this.documentCategory,
      subtype: subtype ?? this.subtype,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      parentCategory: parentCategory ?? this.parentCategory,
    );
  }

  @override
  List<Object?> get props => [id, documentCategory, subtype, updatedAt, createdAt, parentCategory];

  @override
  String toString() {
    return 'DocumentCategory(id: $id, documentCategory: $documentCategory, subtype: $subtype, parentCategory: $parentCategory)';
  }
}

// ParentCategory model
class ParentCategory extends Equatable {
  final int id;
  final String documentCategory;

  const ParentCategory({
    required this.id,
    required this.documentCategory,
  });

  factory ParentCategory.fromJson(Map<String, dynamic> json) {
    return ParentCategory(
      id: json['id'] ?? 0,
      documentCategory: json['documentCategory']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentCategory': documentCategory,
    };
  }

  @override
  List<Object?> get props => [id, documentCategory];

  @override
  String toString() {
    return 'ParentCategory(id: $id, documentCategory: $documentCategory)';
  }
}

// Document Type Model
class DocumentType extends Equatable {
  final int id;
  final String name;
  final int docCategoryId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final DocumentCategory? documentCategory; // Reference to the parent category

  const DocumentType({
    required this.id,
    required this.name,
    required this.docCategoryId,
    required this.updatedAt,
    required this.createdAt,
    this.documentCategory,
  });

  // Get category name if available
  String get categoryName => documentCategory?.documentCategory ?? 'Unknown Category';

  // Get full type path (Category > Type)
  String get fullTypePath => '${categoryName} > ${name}';

  // Check if document type has a valid category
  bool get hasValidCategory => documentCategory != null && docCategoryId > 0;

  // Check if the document type was created recently (within the last 7 days)
  bool get isRecentlyCreated {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inDays <= 7;
  }

  // Check if the document type was updated recently (within the last 7 days)
  bool get isRecentlyUpdated {
    final now = DateTime.now();
    final difference = now.difference(updatedAt);
    return difference.inDays <= 7;
  }

  // Get formatted creation date
  String get formattedCreatedDate {
    return '${createdAt.day.toString().padLeft(2, '0')}/'
        '${createdAt.month.toString().padLeft(2, '0')}/'
        '${createdAt.year}';
  }

  // Get formatted update date
  String get formattedUpdatedDate {
    return '${updatedAt.day.toString().padLeft(2, '0')}/'
        '${updatedAt.month.toString().padLeft(2, '0')}/'
        '${updatedAt.year}';
  }

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      id: DocumentCategory._parseIntSafely(json['id']),
      name: json['name']?.toString().trim() ?? '',
      docCategoryId: DocumentCategory._parseIntSafely(json['docCategory_id']),
      updatedAt: DocumentCategory._parseDateTimeSafely(json['updatedAt']),
      createdAt: DocumentCategory._parseDateTimeSafely(json['createdAt']),
      documentCategory: json['DocumentCategory'] != null
          ? DocumentCategory.fromJson(json['DocumentCategory'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'docCategory_id': docCategoryId,
      'updatedAt': updatedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      if (documentCategory != null)
        'DocumentCategory': documentCategory!.toJson(),
    };
  }

  // Create JSON for API requests (only the fields needed for create/update)
  Map<String, dynamic> toApiJson() {
    return {
      'name': name.trim(),
      'docCategory_id': docCategoryId,
    };
  }

  // Create a copy with new values
  DocumentType copyWith({
    int? id,
    String? name,
    int? docCategoryId,
    DateTime? updatedAt,
    DateTime? createdAt,
    DocumentCategory? documentCategory,
  }) {
    return DocumentType(
      id: id ?? this.id,
      name: name ?? this.name,
      docCategoryId: docCategoryId ?? this.docCategoryId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      documentCategory: documentCategory ?? this.documentCategory,
    );
  }

  // Update with category information
  DocumentType withCategory(DocumentCategory category) {
    return copyWith(
      docCategoryId: category.id,
      documentCategory: category,
    );
  }

  @override
  List<Object?> get props => [id, name, docCategoryId, updatedAt, createdAt];

  @override
  String toString() {
    return 'DocumentType(id: $id, name: $name, docCategoryId: $docCategoryId, categoryName: $categoryName)';
  }
}

// Combined State class for document management
class DocumentManagementState extends Equatable {
  final List<DocumentCategory> categories;
  final List<DocumentType> documentTypes;
  final bool isLoading;
  final String? error;

  const DocumentManagementState({
    this.categories = const [],
    this.documentTypes = const [],
    this.isLoading = false,
    this.error,
  });

  // Calculate hasData as a getter
  bool get hasData => categories.isNotEmpty || documentTypes.isNotEmpty;
  bool get hasCategories => categories.isNotEmpty;
  bool get hasDocumentTypes => documentTypes.isNotEmpty;
  bool get hasError => error != null;

  // Get only main categories (for parent dropdown)
  List<DocumentCategory> get mainCategories {
    return categories.where((category) => category.isMainCategory).toList();
  }

  // Get subcategories for a specific parent
  List<DocumentCategory> getSubCategories(int parentId) {
    return categories.where((category) =>
    category.isSubCategory && category.subtype == parentId
    ).toList();
  }

  // Get all categories organized by hierarchy
  Map<DocumentCategory, List<DocumentCategory>> get categoriesHierarchy {
    final Map<DocumentCategory, List<DocumentCategory>> hierarchy = {};

    // First, add all main categories
    for (final category in mainCategories) {
      hierarchy[category] = getSubCategories(category.id);
    }

    return hierarchy;
  }

  // Get document types for a specific category
  List<DocumentType> getTypesForCategory(int categoryId) {
    return documentTypes
        .where((type) => type.docCategoryId == categoryId)
        .toList();
  }

  // Group document types by category
  Map<DocumentCategory, List<DocumentType>> get typesByCategory {
    final Map<DocumentCategory, List<DocumentType>> grouped = {};

    for (final category in categories) {
      final types = getTypesForCategory(category.id);
      if (types.isNotEmpty) {
        grouped[category] = types;
      }
    }

    return grouped;
  }

  // Get category by ID
  DocumentCategory? getCategoryById(int categoryId) {
    try {
      return categories.firstWhere((cat) => cat.id == categoryId);
    } catch (e) {
      return null;
    }
  }

  // Get document type by ID
  DocumentType? getDocumentTypeById(int typeId) {
    try {
      return documentTypes.firstWhere((type) => type.id == typeId);
    } catch (e) {
      return null;
    }
  }

  // Check if a category has any document types
  bool categoryHasTypes(int categoryId) {
    return documentTypes.any((type) => type.docCategoryId == categoryId);
  }

  // Search functionality for categories
  List<DocumentCategory> searchCategories(String query) {
    if (query.trim().isEmpty) return categories;

    final searchQuery = query.toLowerCase();
    return categories.where((category) {
      return category.documentCategory.toLowerCase().contains(searchQuery) ||
          category.fullCategoryPath.toLowerCase().contains(searchQuery) ||
          category.subtype.toString().contains(query);
    }).toList();
  }

  // Search functionality for document types
  List<DocumentType> searchDocumentTypes(String query) {
    if (query.trim().isEmpty) return documentTypes;

    final searchQuery = query.trim().toLowerCase();
    return documentTypes.where((type) {
      final nameMatch = type.name.toLowerCase().contains(searchQuery);
      final categoryMatch = type.categoryName.toLowerCase().contains(searchQuery);
      final fullPathMatch = type.fullTypePath.toLowerCase().contains(searchQuery);

      return nameMatch || categoryMatch || fullPathMatch;
    }).toList();
  }

  // Validation methods
  bool isValidCategoryId(int categoryId) {
    return categories.any((cat) => cat.id == categoryId);
  }

  bool isValidDocumentTypeName(String name) {
    return name.trim().isNotEmpty && name.trim().length >= 2;
  }

  bool isDocumentTypeNameExists(String name, {int? excludeId}) {
    final trimmedName = name.trim().toLowerCase();
    return documentTypes.any((type) =>
    type.name.toLowerCase() == trimmedName &&
        (excludeId == null || type.id != excludeId));
  }

  // Get document types count by category
  Map<int, int> getDocumentTypesCountByCategory() {
    final Map<int, int> counts = {};
    for (final type in documentTypes) {
      counts[type.docCategoryId] = (counts[type.docCategoryId] ?? 0) + 1;
    }
    return counts;
  }

  DocumentManagementState copyWith({
    List<DocumentCategory>? categories,
    List<DocumentType>? documentTypes,
    bool? isLoading,
    String? error,
  }) {
    return DocumentManagementState(
      categories: categories ?? this.categories,
      documentTypes: documentTypes ?? this.documentTypes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  // Helper methods for state management
  DocumentManagementState clearError() => copyWith(error: null);
  DocumentManagementState setLoading() => copyWith(isLoading: true, error: null);
  DocumentManagementState setError(String errorMessage) => copyWith(isLoading: false, error: errorMessage);

  DocumentManagementState setSuccess({
    List<DocumentCategory>? categories,
    List<DocumentType>? documentTypes,
  }) => copyWith(
    categories: categories ?? this.categories,
    documentTypes: documentTypes ?? this.documentTypes,
    isLoading: false,
    error: null,
  );

  @override
  List<Object?> get props => [categories, documentTypes, isLoading, error];

  @override
  String toString() {
    return 'DocumentManagementState(categories: ${categories.length}, '
        'mainCategories: ${mainCategories.length}, '
        'documentTypes: ${documentTypes.length}, '
        'isLoading: $isLoading, '
        'hasError: $hasError)';
  }
}