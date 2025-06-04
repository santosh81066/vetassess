// models/category_country_models.dart

class Category {
  final int id;
  final String category;

  Category({required this.id, required this.category});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      category: json['Category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'Category': category};
  }
}

class Country {
  final int id;
  final String country;

  Country({required this.id, required this.country});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(id: json['id'] as int, country: json['country'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'country': country};
  }
}

class CategoriesResponse {
  final bool success;
  final int count;
  final List<Category> data;

  CategoriesResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      success: json['success'] as bool,
      count: json['count'] as int,
      data:
          (json['data'] as List<dynamic>)
              .map((item) => Category.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}

class CountriesResponse {
  final bool success;
  final int count;
  final List<Country> data;

  CountriesResponse({
    required this.success,
    required this.count,
    required this.data,
  });

  factory CountriesResponse.fromJson(Map<String, dynamic> json) {
    return CountriesResponse(
      success: json['success'] as bool,
      count: json['count'] as int,
      data:
          (json['data'] as List<dynamic>)
              .map((item) => Country.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}

// State classes for managing loading and error states
class CategoriesState {
  final List<Category> categories;
  final bool isLoading;
  final String? error;

  CategoriesState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  CategoriesState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? error,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class CountriesState {
  final List<Country> countries;
  final bool isLoading;
  final String? error;

  CountriesState({
    this.countries = const [],
    this.isLoading = false,
    this.error,
  });

  CountriesState copyWith({
    List<Country>? countries,
    bool? isLoading,
    String? error,
  }) {
    return CountriesState(
      countries: countries ?? this.countries,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
