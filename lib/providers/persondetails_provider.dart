import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vetassess/Service/auth_service.dart';
import 'package:vetassess/models/personaldetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class PersondetailsProvider extends StateNotifier<PersonalDetails> {
  PersondetailsProvider() : super(PersonalDetails());

  // Update individual fields
  void updatePreferredTitle(String? title) {
    state = state.copyWith(preferredTitle: title);
  }

  void updateSurname(String surname) {
    state = state.copyWith(surname: surname);
  }

  void updateGivenNames(String givenNames) {
    state = state.copyWith(givenNames: givenNames);
  }

  void updateGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void updateDateOfBirth(String dateOfBirth) {
    state = state.copyWith(dateOfBirth: dateOfBirth);
  }

  void updateCountryOfBirth(String? country) {
    state = state.copyWith(countryOfBirth: country);
  }

  void updateCitizenshipCountry(String? country) {
    state = state.copyWith(citizenshipCountry: country);
  }

  void updateCountryOfCurrentResidency(String? country) {
    state = state.copyWith(countryOfCurrentResidency: country);
  }

  void updateCurrentPassportNumber(String passportNumber) {
    state = state.copyWith(currentPassportNumber: passportNumber);
  }

  void updateDatePassportIssued(String date) {
    state = state.copyWith(datePassportIssued: date);
  }

  void updateEmailAddress(String email) {
    state = state.copyWith(emailAddress: email);
  }

  void updateDaytimeTelephoneNumber(String phone) {
    state = state.copyWith(daytimeTelephoneNumber: phone);
  }

  void updatePostalStreetAddress(String address) {
    state = state.copyWith(postalStreetAddress: address);
  }

  void updatePostalSuburbCity(String suburb) {
    state = state.copyWith(postalSuburbCity: suburb);
  }

  void updatePostalCountry(String? country) {
    state = state.copyWith(postalCountry: country);
  }

  void updateHomeStreetAddress(String address) {
    state = state.copyWith(homeStreetAddress: address);
  }

  void updateHomeSuburbCity(String suburb) {
    state = state.copyWith(homeSuburbCity: suburb);
  }

  void updateHomeCountry(String? country) {
    state = state.copyWith(homeCountry: country);
  }

  void updateIsAgentAuthorized(bool isAuthorized) {
    state = state.copyWith(isAgentAuthorized: isAuthorized);
  }

  // Copy postal address to home address
  void copyPostalToHome() {
    state = state.copyWith(
      homeStreetAddress: state.postalStreetAddress,
      homeSuburbCity: state.postalSuburbCity,
      homeCountry: state.postalCountry,
    );
  }

  // Submit personal details to API
  Future<bool> submitPersonalDetails({required int userId}) async {
    try {
      print('personaldetails....$userId');
      const String apiUrl = 'http://103.98.12.226:5100';
      
      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "action": "submit",
        "preferredTitle": state.preferredTitle,
        "surname": state.surname,
        "givenNames": state.givenNames,
        "gender": state.gender,
        "dateOfBirth": state.dateOfBirth,
        "countryOfBirth": state.countryOfBirth,
        "citizenshipCountry": state.citizenshipCountry,
        "countryOfCurrentResidency": state.countryOfCurrentResidency,
        "currentPassportNumber": state.currentPassportNumber,
        "datePassportIssued": state.datePassportIssued,
        "emailAddress": state.emailAddress,
        "daytimeTelephoneNumber": state.daytimeTelephoneNumber,
        "postalStreetAddress": state.postalStreetAddress,
        "postalSuburbCity": state.postalSuburbCity,
        "postalCountry": state.postalCountry,
        "homeStreetAddress": state.homeStreetAddress,
        "homeSuburbCity": state.homeSuburbCity,
        "homeCountry": state.homeCountry,
        "isAgentAuthorized": state.isAgentAuthorized,
      };

      // Get headers with authentication token
      final headers = await AuthService.getAuthHeaders();

      final response = await http.post(
        Uri.parse('$apiUrl/personal-details/'),
        headers: headers,
        body: json.encode(requestBody),
      );
      
      print('personaldetails....$requestBody');
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        return true;
      } else {
        // Handle error
        print('Error submitting personal details: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception occurred while submitting personal details: $e');
      return false;
    }
  }

  // Save as draft (optional)
  Future<bool> saveAsDraft({required int userId}) async {
    try {
      const String apiUrl = 'http://103.98.12.226:5100';
      
      final Map<String, dynamic> requestBody = {
        "userId": userId,
        "action": "draft",
        "preferredTitle": state.preferredTitle,
        "surname": state.surname,
        "givenNames": state.givenNames,
        "gender": state.gender,
        "dateOfBirth": state.dateOfBirth,
        "countryOfBirth": state.countryOfBirth,
        "citizenshipCountry": state.citizenshipCountry,
        "countryOfCurrentResidency": state.countryOfCurrentResidency,
        "currentPassportNumber": state.currentPassportNumber,
        "datePassportIssued": state.datePassportIssued,
        "emailAddress": state.emailAddress,
        "daytimeTelephoneNumber": state.daytimeTelephoneNumber,
        "postalStreetAddress": state.postalStreetAddress,
        "postalSuburbCity": state.postalSuburbCity,
        "postalCountry": state.postalCountry,
        "homeStreetAddress": state.homeStreetAddress,
        "homeSuburbCity": state.homeSuburbCity,
        "homeCountry": state.homeCountry,
        "isAgentAuthorized": state.isAgentAuthorized,
      };

      // Get headers with authentication token
      final headers = await AuthService.getAuthHeaders();

      final response = await http.post(
        Uri.parse('$apiUrl/personal-details/'), // Fixed: added endpoint path
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Error saving draft: ${response.statusCode}');
        print('Response body: ${response.body}'); // Added response body for debugging
        return false;
      }
    } catch (e) {
      print('Exception occurred while saving draft: $e');
      return false;
    }
  }
}

final personalDetailsProvider = StateNotifierProvider<PersondetailsProvider, PersonalDetails>((ref) {
  return PersondetailsProvider();
});