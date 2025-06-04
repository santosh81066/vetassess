import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/Service/auth_service.dart';
import 'package:vetassess/models/employment_model.dart';

// Employment Service Class
class EmploymentService {
  static const String baseUrl = 'http://103.98.12.226:5100';
  static const String employmentEndpoint = '/user/employment';

  Future<Map<String, dynamic>> submitEmployment(EmploymentModel employment) async {
    try {
      final url = Uri.parse('$baseUrl$employmentEndpoint');
      

      final headers = await AuthService.getAuthHeaders();
      
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(employment.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
          'message': 'Employment data submitted successfully',
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to submit employment data. Status: ${response.statusCode}',
          'message': response.body,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: ${e.toString()}',
        'message': 'Please check your internet connection and try again.',
      };
    }
  }
}

// Employment Provider Class
class EmploymentProvider extends StateNotifier<EmploymentModel> {
  final EmploymentService _employmentService = EmploymentService();

  EmploymentProvider() : super(EmploymentModel.initial());

  // Update individual fields
  void updateBusinessName(String value) {
    state = state.copyWith(businessName: value);
  }

  void updateAlternateBusinsessname(String value) {
    state = state.copyWith(alternateBusinsessname: value);
  }

  void updateStreetaddress(String value) {
    state = state.copyWith(streetaddress: value);
  }

  void updateSuburbCity(String value) {
    state = state.copyWith(suburbCity: value);
  }

  void updateState(String value) {
    state = state.copyWith(state: value);
  }

  void updatePostCode(String value) {
    state = state.copyWith(postCode: value);
  }

  void updateCountry(String value) {
    state = state.copyWith(country: value);
  }

  void updateNameofemployer(String value) {
    state = state.copyWith(nameofemployer: value);
  }

  void updateDaytimePHno(String value) {
    state = state.copyWith(daytimePHno: value);
  }

  void updateFaxnumber(String value) {
    state = state.copyWith(faxnumber: value);
  }

  void updateMobileNo(String value) {
    state = state.copyWith(mobileNo: value);
  }

  void updateEmailaddress(String value) {
    state = state.copyWith(emailaddress: value);
  }

  void updateWebaddress(String value) {
    state = state.copyWith(webaddress: value);
  }

  void updatePositionJobTitle(String value) {
    state = state.copyWith(positionJobTitle: value);
  }

  void updateDateofemploymentstarted(String value) {
    state = state.copyWith(dateofemploymentstarted: value);
  }

  void updateIsapplicantemployed(bool value) {
    state = state.copyWith(isapplicantemployed: value);
  }

  void updateDateofemploymentended(String value) {
    state = state.copyWith(dateofemploymentended: value);
  }

  void updateTotallengthofUnpaidLeave(String value) {
    state = state.copyWith(totallengthofUnpaidLeave: value);
  }

  void updateNormalrequiredWorkinghours(String value) {
    state = state.copyWith(normalrequiredWorkinghours: value);
  }

  void updateTask(int index, String value) {
    List<String> updatedTasks = List.from(state.tasks);
    if (index < updatedTasks.length) {
      updatedTasks[index] = value;
      state = state.copyWith(tasks: updatedTasks);
    }
  }

  void addTask() {
    List<String> updatedTasks = List.from(state.tasks);
    updatedTasks.add('');
    state = state.copyWith(tasks: updatedTasks);
  }

  void removeTask(int index) {
    if (state.tasks.length > 1) {
      List<String> updatedTasks = List.from(state.tasks);
      updatedTasks.removeAt(index);
      state = state.copyWith(tasks: updatedTasks);
    }
  }

  Future<bool> submitEmployment() async {
    // Set loading state
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _employmentService.submitEmployment(state);
      
      if (result['success']) {
        state = state.copyWith(isLoading: false, error: null);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false, 
          error: result['error'] ?? 'Failed to submit employment data'
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        error: 'An unexpected error occurred: ${e.toString()}'
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void resetForm() {
    state = EmploymentModel.initial();
  }
}

// Provider Instance
final employmentProvider = StateNotifierProvider<EmploymentProvider, EmploymentModel>((ref) {
  return EmploymentProvider();
});