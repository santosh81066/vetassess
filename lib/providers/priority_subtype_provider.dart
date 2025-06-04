// providers/priority_subtype_provider.dart

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/models/priority_subtype_model.dart';
import 'package:vetassess/providers/login_provider.dart';

// Service class for API calls
class PrioritySubtypeService {
  static const String baseUrl = 'http://103.98.12.226:5100';
  final Ref ref;

  PrioritySubtypeService(this.ref);

  Future<PrioritySubtypeResponse> fetchPrioritySubtypes() async {
    try {
      // Get the access token from login provider
      final loginNotifier = ref.read(loginProvider.notifier);
      final accessToken = await loginNotifier.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('No access token available. Please login again.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user/priority-subtypes'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return PrioritySubtypeResponse.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        // Token might be expired, try to refresh
        final isLoggedIn = await loginNotifier.isLoggedIn();
        if (isLoggedIn) {
          // Token was refreshed, retry the request
          final newAccessToken = await loginNotifier.getAccessToken();
          final retryResponse = await http.get(
            Uri.parse('$baseUrl/user/priority-subtypes'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $newAccessToken',
            },
          );

          if (retryResponse.statusCode == 200) {
            final jsonData = json.decode(retryResponse.body);
            return PrioritySubtypeResponse.fromJson(jsonData);
          } else {
            throw Exception(
              'Failed to fetch priority subtypes after token refresh: ${retryResponse.statusCode}',
            );
          }
        } else {
          throw Exception('Authentication failed. Please login again.');
        }
      } else {
        throw Exception(
          'Failed to fetch priority subtypes: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching priority subtypes: $e');
    }
  }

  // Optional: Create a helper method for making authenticated requests
  Future<http.Response> _makeAuthenticatedRequest(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
  }) async {
    final loginNotifier = ref.read(loginProvider.notifier);
    final accessToken = await loginNotifier.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('No access token available. Please login again.');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    final uri = Uri.parse('$baseUrl$endpoint');

    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(uri, headers: headers);
      case 'POST':
        return await http.post(
          uri,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      case 'PUT':
        return await http.put(
          uri,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      case 'DELETE':
        return await http.delete(uri, headers: headers);
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }
}

// Provider for the service - now passes ref to the service
final prioritySubtypeServiceProvider = Provider<PrioritySubtypeService>((ref) {
  return PrioritySubtypeService(ref);
});

// FutureProvider for fetching priority subtypes
final prioritySubtypesProvider = FutureProvider<List<PrioritySubtype>>((
  ref,
) async {
  final service = ref.read(prioritySubtypeServiceProvider);
  final response = await service.fetchPrioritySubtypes();
  return response.data;
});

// StateProvider for selected checkboxes
final selectedSubtypesProvider = StateProvider<Map<int, bool>>((ref) {
  return {};
});

// StateProvider for the "Other" text field
final otherTextProvider = StateProvider<String>((ref) {
  return '';
});

// StateProvider for selected processing option
final selectedProcessingOptionProvider = StateProvider<String>((ref) {
  return 'Priority Processing';
});
