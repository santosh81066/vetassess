// providers/licence_provider.dart

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/utils/vetassess_api.dart';
import '../models/licence_models.dart';
import 'login_provider.dart';

class LicenceNotifier extends StateNotifier<LicenceState> {
  final Ref ref;

  LicenceNotifier(this.ref) : super(LicenceState());

  static const String url = VetassessApi.formadd_licence;

  Future<void> addLicence(LicenceRequest request) async {
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

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final licenceResponse = LicenceResponse.fromJson(jsonResponse);

        state = state.copyWith(isLoading: false, response: licenceResponse);
      } else {
        // Handle error response
        final errorBody = jsonDecode(response.body);
        final errorMessage = errorBody['message'] ?? 'Failed to add licence';

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

  void clearResponse() {
    state = state.copyWith(response: null);
  }

  void reset() {
    state = LicenceState();
  }
}

// Provider
final licenceProvider = StateNotifierProvider<LicenceNotifier, LicenceState>(
  (ref) => LicenceNotifier(ref),
);
