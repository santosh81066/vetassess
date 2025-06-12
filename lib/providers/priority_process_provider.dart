// providers/priority_process_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/priority_process_model.dart';
import '../utils/vetassess_api.dart';
import 'login_provider.dart'; // Import your login provider

// API services
class PriorityProcessService {
  final url = VetassessApi.form_priorityprocess;
  final Ref ref;

  PriorityProcessService(this.ref);

  Future<PriorityProcessResponse> submitPriorityProcess(
    PriorityProcessRequest request,
  ) async {
    try {
      // Get the access token from login provider
      final loginNotifier = ref.read(loginProvider.notifier);
      final accessToken = await loginNotifier.getAccessToken();

      // Prepare headers
      final headers = <String, String>{'Content-Type': 'application/json'};

      // Add Authorization header if token exists
      if (accessToken != null && accessToken.isNotEmpty) {
        headers['Authorization'] = 'Bearer $accessToken';
      }

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return PriorityProcessResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        // Token might be expired, try to refresh
        final isLoggedIn = await loginNotifier.isLoggedIn();
        if (isLoggedIn) {
          // Token was refreshed, retry the request
          return await submitPriorityProcess(request);
        } else {
          throw Exception('Authentication failed. Please login again.');
        }
      } else {
        throw Exception(
          'Failed to submit priority process: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}

// Updated services Provider - now passes ref to services
final priorityProcessServiceProvider = Provider<PriorityProcessService>((ref) {
  return PriorityProcessService(ref);
});

// Async Provider for submitting priority process
final submitPriorityProcessProvider =
    FutureProvider.family<PriorityProcessResponse, PriorityProcessRequest>((
      ref,
      request,
    ) async {
      final service = ref.read(priorityProcessServiceProvider);
      return service.submitPriorityProcess(request);
    });

// State provider for submission status
enum SubmissionStatus { idle, loading, success, error }

class PriorityProcessState {
  final SubmissionStatus status;
  final PriorityProcessResponse? response;
  final String? error;

  PriorityProcessState({required this.status, this.response, this.error});

  PriorityProcessState copyWith({
    SubmissionStatus? status,
    PriorityProcessResponse? response,
    String? error,
  }) {
    return PriorityProcessState(
      status: status ?? this.status,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }
}

// StateNotifier for managing submission
class PriorityProcessNotifier extends StateNotifier<PriorityProcessState> {
  final PriorityProcessService _service;

  PriorityProcessNotifier(this._service)
    : super(PriorityProcessState(status: SubmissionStatus.idle));

  Future<void> submitPriorityProcess(PriorityProcessRequest request) async {
    state = state.copyWith(status: SubmissionStatus.loading);

    try {
      final response = await _service.submitPriorityProcess(request);
      state = state.copyWith(
        status: SubmissionStatus.success,
        response: response,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: SubmissionStatus.error,
        error: e.toString(),
      );
    }
  }

  void resetState() {
    state = PriorityProcessState(status: SubmissionStatus.idle);
  }
}

// StateNotifier Provider
final priorityProcessNotifierProvider =
    StateNotifierProvider<PriorityProcessNotifier, PriorityProcessState>((ref) {
      final service = ref.read(priorityProcessServiceProvider);
      return PriorityProcessNotifier(service);
    });
