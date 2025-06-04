// providers/category_country_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/category_country_models.dart';
import 'login_provider.dart'; // Import your existing login provider

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final Ref ref;

  CategoriesNotifier(this.ref) : super(CategoriesState());

  static const String baseUrl = 'http://103.98.12.226:5100';

  Future<void> fetchCategories() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Get access token from login provider
      final loginNotifier = ref.read(loginProvider.notifier);
      final accessToken = await loginNotifier.getAccessToken();

      if (accessToken == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Access token not found. Please login again.',
        );
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/categories'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final categoriesResponse = CategoriesResponse.fromJson(responseData);

        state = state.copyWith(
          isLoading: false,
          categories: categoriesResponse.data,
          error: null,
        );
      } else if (response.statusCode == 401) {
        // Token might be expired, try to refresh
        final isLoggedIn = await loginNotifier.isLoggedIn();
        if (isLoggedIn) {
          // Token was refreshed, retry the request
          await fetchCategories();
        } else {
          state = state.copyWith(
            isLoading: false,
            error: 'Authentication failed. Please login again.',
          );
        }
      } else {
        String errorMessage;
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? 'Failed to fetch categories';
        } catch (e) {
          errorMessage =
              'Failed to fetch categories. Status: ${response.statusCode}';
        }

        state = state.copyWith(isLoading: false, error: errorMessage);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Network error: ${e.toString()}',
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void resetState() {
    state = CategoriesState();
  }
}

class CountriesNotifier extends StateNotifier<CountriesState> {
  final Ref ref;

  CountriesNotifier(this.ref) : super(CountriesState());

  static const String baseUrl = 'http://103.98.12.226:5100';

  Future<void> fetchCountries() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Get access token from login provider
      final loginNotifier = ref.read(loginProvider.notifier);
      final accessToken = await loginNotifier.getAccessToken();

      if (accessToken == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Access token not found. Please login again.',
        );
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/countries'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final countriesResponse = CountriesResponse.fromJson(responseData);

        state = state.copyWith(
          isLoading: false,
          countries: countriesResponse.data,
          error: null,
        );
      } else if (response.statusCode == 401) {
        // Token might be expired, try to refresh
        final isLoggedIn = await loginNotifier.isLoggedIn();
        if (isLoggedIn) {
          // Token was refreshed, retry the request
          await fetchCountries();
        } else {
          state = state.copyWith(
            isLoading: false,
            error: 'Authentication failed. Please login again.',
          );
        }
      } else {
        String errorMessage;
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? 'Failed to fetch countries';
        } catch (e) {
          errorMessage =
              'Failed to fetch countries. Status: ${response.statusCode}';
        }

        state = state.copyWith(isLoading: false, error: errorMessage);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Network error: ${e.toString()}',
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void resetState() {
    state = CountriesState();
  }
}

// Providers
final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
      return CategoriesNotifier(ref);
    });

final countriesProvider =
    StateNotifierProvider<CountriesNotifier, CountriesState>((ref) {
      return CountriesNotifier(ref);
    });

// Convenience providers for easier access to data
final categoriesListProvider = Provider<List<Category>>((ref) {
  return ref.watch(categoriesProvider).categories;
});

final countriesListProvider = Provider<List<Country>>((ref) {
  return ref.watch(countriesProvider).countries;
});

// Auto-fetch providers that automatically fetch data when first accessed
final autoFetchCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final notifier = ref.read(categoriesProvider.notifier);
  await notifier.fetchCategories();
  return ref.read(categoriesProvider).categories;
});

final autoFetchCountriesProvider = FutureProvider<List<Country>>((ref) async {
  final notifier = ref.read(countriesProvider.notifier);
  await notifier.fetchCountries();
  return ref.read(countriesProvider).countries;
});
