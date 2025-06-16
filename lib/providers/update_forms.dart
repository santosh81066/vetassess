import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/utils/vetassess_api.dart';

import 'login_provider.dart';

class UpdateForms {
  final String baseUrl = VetassessApi.baseUrl;
  final Ref ref;

  UpdateForms(this.ref);

  Future<void> updateUserForms(Map<String, dynamic> data) async {
    final loginNotifier = ref.read(loginProvider.notifier);
    final token = await loginNotifier.getAccessToken();
    final response = await http.put(
      Uri.parse('$baseUrl/user/update-forms'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to update forms: ${response.statusCode}');
    }
  }
}
