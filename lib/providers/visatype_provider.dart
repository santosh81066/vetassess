import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/Service/auth_service.dart';
import 'dart:convert';
import 'package:vetassess/models/getvisatype_model.dart';

// State class to hold visa types and loading state


class VisatypeProvider extends StateNotifier<VisaTypeState> {
  VisatypeProvider() : super(VisaTypeState());

  static const String baseUrl = 'http://103.98.12.226:5100';

  Future<void> fetchVisaTypes(String category) async {
    // Don't fetch if we're already loading the same category
    if (state.isLoading && state.currentCategory == category) {
      return;
    }

    state = state.copyWith(
      isLoading: true, 
      error: null,
      currentCategory: category,
      // Clear selected visa type when changing categories
      selectedVisaType: null,
    );

    try {
      final headers = await AuthService.getAuthHeaders();
      
      // URL encode the category parameter to handle spaces properly
      final encodedCategory = Uri.encodeComponent(category);
      final url = '$baseUrl/admin/visa-types?category=$encodedCategory';
      
      print('Fetching visa types for category: $category');
      print('Request URL: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        
        // Parse and filter visa types
        List<VisaTypeModel> allVisaTypes = jsonData
            .map((json) => VisaTypeModel.fromJson(json))
            .toList();

        // Additional client-side filtering to ensure we only get the requested category
        List<VisaTypeModel> filteredVisaTypes = allVisaTypes
            .where((visaType) => visaType.category?.trim() == category.trim())
            .toList();

        print('Total visa types received: ${allVisaTypes.length}');
        print('Filtered visa types for "$category": ${filteredVisaTypes.length}');

        // Log the categories we received for debugging
        final receivedCategories = allVisaTypes
            .map((v) => v.category)
            .toSet()
            .toList();
        print('Received categories: $receivedCategories');

        state = state.copyWith(
          visaTypes: filteredVisaTypes,
          isLoading: false,
          selectedVisaType: filteredVisaTypes.isNotEmpty ? filteredVisaTypes.first : null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to fetch visa types: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching visa types: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Error fetching visa types: $e',
      );
    }
  }

  // Method to get visa types for a specific category from current state
  List<VisaTypeModel> getVisaTypesByCategory(String category) {
    return state.visaTypes
        .where((visaType) => visaType.category?.trim() == category.trim())
        .toList();
  }

  void selectVisaType(VisaTypeModel visaType) {
    state = state.copyWith(selectedVisaType: visaType);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSelection() {
    state = state.copyWith(selectedVisaType: null);
  }

  // Method to check if a category has visa types
  bool hasCategoryData(String category) {
    return state.visaTypes.any((visaType) => visaType.category?.trim() == category.trim());
  }
}

final visatypeProvider = StateNotifierProvider<VisatypeProvider, VisaTypeState>((ref) {
  return VisatypeProvider();
});

