// providers/tertiary_qualification_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/tertiary_education_model.dart';
import '../providers/login_provider.dart';

class TertiaryQualificationNotifier
    extends StateNotifier<TertiaryQualificationState> {
  final LoginNotifier loginNotifier;
  TertiaryQualificationNotifier(this.loginNotifier)
    : super(TertiaryQualificationState());
  static const String baseUrl = 'http://103.98.12.226:5100';
  Future<void> saveTertiaryQualification(
    TertiaryQualificationRequest request,
  ) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Get access token from login provider
      final accessToken = await loginNotifier.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: 'Authentication token not found. Please log in again.',
        );
        return;
      }
      final response = await http.post(
        Uri.parse('$baseUrl/user/tertiary-qualification'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(request.toJson()),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final tertiaryResponse = TertiaryQualificationResponse.fromJson(
          responseData,
        );
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          response: tertiaryResponse,
          error: null,
        );
      } else if (response.statusCode == 401) {
        // Token might be expired, try to refresh
        final isLoggedIn = await loginNotifier.isLoggedIn();
        if (isLoggedIn) {
          // Retry the request with refreshed token
          await saveTertiaryQualification(request);
          return;
        } else {
          state = state.copyWith(
            isLoading: false,
            isSuccess: false,
            error: 'Session expired. Please log in again.',
          );
        }
      } else {
        // Handle different status codes
        String errorMessage;
        try {
          final errorData = jsonDecode(response.body);
          errorMessage =
              errorData['message'] ?? 'Failed to save tertiary qualification';
        } catch (e) {
          errorMessage =
              'Failed to save tertiary qualification. Status: ${response.statusCode}';
        }
        state = state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: errorMessage,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: 'Network error: ${e.toString()}',
      );
    }
  }

  // Method to reset state
  void resetState() {
    state = TertiaryQualificationState();
  }

  // Method to clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Provider
final tertiaryQualificationProvider = StateNotifierProvider<
  TertiaryQualificationNotifier,
  TertiaryQualificationState
>((ref) {
  final loginNotifier = ref.read(loginProvider.notifier);
  return TertiaryQualificationNotifier(loginNotifier);
});
