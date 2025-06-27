// providers/licence_provider.dart

import 'dart:convert';
import 'dart:async';
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
    print('🚀 Starting addLicence API call');
    state = state.copyWith(isLoading: true, error: null, response: null);

    try {
      // Get access token from login provider
      print('📱 Getting access token...');
      final loginNotifier = ref.read(loginProvider.notifier);
      final accessToken = await loginNotifier.getAccessToken();

      if (accessToken == null) {
        print('❌ No access token found');
        state = state.copyWith(
          isLoading: false,
          error: 'Access token not found. Please login again.',
        );
        return;
      }

      print('✅ Access token obtained');
      print('🌐 Making API call to: $url');
      print('📤 Request payload: ${jsonEncode(request.toJson())}');

      final response = await http
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
            body: jsonEncode(request.toJson()),
          )
          .timeout(
            const Duration(seconds: 30), // 30 second timeout
            onTimeout: () {
              print('⏰ Request timed out');
              throw TimeoutException(
                'Request timed out',
                const Duration(seconds: 30),
              );
            },
          );

      print('📥 Response received - Status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final jsonResponse = jsonDecode(response.body);
          final licenceResponse = LicenceResponse.fromJson(jsonResponse);

          print('✅ Success! Setting response state');
          state = state.copyWith(
            isLoading: false,
            response: licenceResponse,
            error: null,
          );
          print('✅ State updated successfully');
        } catch (parseError) {
          print('❌ JSON parsing error: $parseError');
          state = state.copyWith(
            isLoading: false,
            error: 'Invalid response format from server',
          );
        }
      } else {
        // Handle error response
        print('❌ HTTP Error - Status: ${response.statusCode}');
        String errorMessage;

        try {
          final errorBody = jsonDecode(response.body);
          errorMessage = errorBody['message'] ?? 'Failed to add licence';
        } catch (e) {
          errorMessage =
              'HTTP ${response.statusCode}: ${response.reasonPhrase ?? 'Unknown error'}';
        }

        print('❌ Error message: $errorMessage');
        state = state.copyWith(isLoading: false, error: errorMessage);
      }
    } on TimeoutException catch (e) {
      print('⏰ Timeout error: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Request timed out. Please check your connection and try again.',
      );
    } on FormatException catch (e) {
      print('❌ Format error: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Invalid data format. Please check your input.',
      );
    } catch (e) {
      print('❌ Unexpected error: $e');
      String errorMessage;

      if (e.toString().contains('SocketException') ||
          e.toString().contains('NetworkException')) {
        errorMessage = 'No internet connection. Please check your network.';
      } else {
        errorMessage = 'Network error: ${e.toString()}';
      }

      state = state.copyWith(isLoading: false, error: errorMessage);
    }

    print(
      '🏁 addLicence completed. Final state: isLoading=${state.isLoading}, hasError=${state.error != null}, hasResponse=${state.response != null}',
    );
  }

  void clearError() {
    print('🧹 Clearing error');
    state = state.copyWith(error: null);
  }

  void clearResponse() {
    print('🧹 Clearing response');
    state = state.copyWith(response: null);
  }

  void reset() {
    print('🔄 Resetting licence provider state');
    state = LicenceState();
  }
}

// Provider
final licenceProvider = StateNotifierProvider<LicenceNotifier, LicenceState>(
  (ref) => LicenceNotifier(ref),
);
