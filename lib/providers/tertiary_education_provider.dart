// providers/tertiary_education_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/tertiary_education_model.dart';

class TertiaryEducationNotifier extends StateNotifier<TertiaryEducationState> {
  TertiaryEducationNotifier() : super(TertiaryEducationState());

  static const String baseUrl = 'http://103.98.12.226:5100';

  Future<void> submitTertiaryEducation(TertiaryEducationRequest request) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final url = Uri.parse('$baseUrl/user/tertiary-qualification');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // Add authentication headers if needed
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final tertiaryEducationResponse = TertiaryEducationResponse.fromJson(
          responseData,
        );

        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          response: tertiaryEducationResponse,
          error: null,
        );
      } else {
        final errorData = jsonDecode(response.body);
        state = state.copyWith(
          isLoading: false,
          isSuccess: false,
          error: errorData['message'] ?? 'Failed to submit tertiary education',
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

  void resetState() {
    state = TertiaryEducationState();
  }
}

// Form data notifier for managing form state
class TertiaryEducationFormNotifier
    extends StateNotifier<TertiaryEducationFormData> {
  TertiaryEducationFormNotifier() : super(TertiaryEducationFormData());

  void updateStudentRegistrationNumber(String? value) {
    state = state.copyWith(studentRegistrationNumber: value ?? '');
  }

  void updateQualificationName(String? value) {
    state = state.copyWith(qualificationName: value ?? '');
  }

  void updateMajorField(String? value) {
    state = state.copyWith(majorField: value ?? '');
  }

  void updateAwardingBodyName(String? value) {
    state = state.copyWith(awardingBodyName: value ?? '');
  }

  void updateAwardingBodyCountry(String? value) {
    state = state.copyWith(awardingBodyCountry: value ?? '');
  }

  void updateCampusAttended(String? value) {
    state = state.copyWith(campusAttended: value ?? '');
  }

  void updateInstitutionName(String? value) {
    state = state.copyWith(institutionName: value ?? '');
  }

  void updateStreetAddress1(String? value) {
    state = state.copyWith(streetAddress1: value ?? '');
  }

  void updateStreetAddress2(String? value) {
    state = state.copyWith(streetAddress2: value ?? '');
  }

  void updateSuburbCity(String? value) {
    state = state.copyWith(suburbCity: value ?? '');
  }

  void updateState(String? value) {
    state = state.copyWith(state: value ?? '');
  }

  void updatePostCode(String? value) {
    state = state.copyWith(postCode: value ?? '');
  }

  void updateInstitutionCountry(String? value) {
    state = state.copyWith(institutionCountry: value ?? '');
  }

  void updateNormalEntryRequirement(String? value) {
    state = state.copyWith(normalEntryRequirement: value ?? '');
  }

  void updateEntryBasis(String? value) {
    state = state.copyWith(entryBasis: value ?? '');
  }

  void updateCourseLengthYears(String? value) {
    state = state.copyWith(courseLengthYears: value ?? '');
  }

  void updateCourseLengthSemesters(String? value) {
    state = state.copyWith(courseLengthSemesters: value ?? '');
  }

  void updateSemesterLengthWeeksOrMonths(String? value) {
    state = state.copyWith(semesterLengthWeeksOrMonths: value ?? '');
  }

  void updateCourseStartDate(String? value) {
    state = state.copyWith(courseStartDate: value ?? '');
  }

  void updateCourseEndDate(String? value) {
    state = state.copyWith(courseEndDate: value ?? '');
  }

  void updateQualificationAwardedDate(String? value) {
    state = state.copyWith(qualificationAwardedDate: value ?? '');
  }

  void updateStudyMode(String? value) {
    state = state.copyWith(studyMode: value ?? '');
  }

  void updateHoursPerWeek(String? value) {
    state = state.copyWith(hoursPerWeek: value ?? '');
  }

  void updateHasInternship(bool value) {
    state = state.copyWith(
      hasInternship: value,
      internshipWeeks: value ? state.internshipWeeks : '0',
    );
  }

  void updateHasThesis(bool value) {
    state = state.copyWith(
      hasThesis: value,
      thesisWeeks: value ? state.thesisWeeks : '0',
    );
  }

  void updateHasMajorProject(bool value) {
    state = state.copyWith(
      hasMajorProject: value,
      majorProjectWeeks: value ? state.majorProjectWeeks : '0',
    );
  }

  void updateInternshipWeeks(String? value) {
    state = state.copyWith(internshipWeeks: value ?? '');
  }

  void updateThesisWeeks(String? value) {
    state = state.copyWith(thesisWeeks: value ?? '');
  }

  void updateMajorProjectWeeks(String? value) {
    state = state.copyWith(majorProjectWeeks: value ?? '');
  }

  // Helper method to convert form data to request
  TertiaryEducationRequest toRequest(int userId) {
    // Determine course length based on which field is filled
    String courseLengthYearsOrSemesters = '';
    if (state.courseLengthYears.isNotEmpty) {
      courseLengthYearsOrSemesters = '${state.courseLengthYears} years';
    } else if (state.courseLengthSemesters.isNotEmpty) {
      courseLengthYearsOrSemesters = '${state.courseLengthSemesters} semesters';
    }

    // Build activity details
    List<String> activities = [];
    if (state.hasInternship) {
      activities.add('Completed a ${state.internshipWeeks}-week internship');
    }
    if (state.hasThesis) {
      activities.add('Completed a ${state.thesisWeeks}-week thesis project');
    }
    if (state.hasMajorProject) {
      activities.add(
        'Completed a ${state.majorProjectWeeks}-week major project',
      );
    }

    String activityDetails =
        activities.isEmpty
            ? 'No additional requirements completed'
            : activities.join(' and ') + ' as part of the degree.';

    return TertiaryEducationRequest(
      userId: userId,
      studentRegistrationNumber:
          state.studentRegistrationNumber?.isEmpty == true
              ? null
              : state.studentRegistrationNumber,
      qualificationName: state.qualificationName,
      majorField: state.majorField,
      awardingBodyName: state.awardingBodyName,
      awardingBodyCountry: state.awardingBodyCountry,
      campusAttended:
          state.campusAttended?.isEmpty == true ? null : state.campusAttended,
      institutionName: state.institutionName,
      streetAddress1: state.streetAddress1,
      streetAddress2:
          state.streetAddress2?.isEmpty == true ? null : state.streetAddress2,
      suburbCity: state.suburbCity,
      state: state.state?.isEmpty == true ? null : state.state,
      postCode: state.postCode?.isEmpty == true ? null : state.postCode,
      institutionCountry: state.institutionCountry,
      normalEntryRequirement: state.normalEntryRequirement,
      entryBasis: state.entryBasis,
      courseLengthYearsOrSemesters: courseLengthYearsOrSemesters,
      semesterLengthWeeksOrMonths: state.semesterLengthWeeksOrMonths,
      courseStartDate: state.courseStartDate,
      courseEndDate: state.courseEndDate,
      qualificationAwardedDate: state.qualificationAwardedDate,
      studyMode: state.studyMode,
      hoursPerWeek: int.tryParse(state.hoursPerWeek) ?? 0,
      internshipWeeks: int.tryParse(state.internshipWeeks) ?? 0,
      thesisWeeks: int.tryParse(state.thesisWeeks) ?? 0,
      majorProjectWeeks: int.tryParse(state.majorProjectWeeks) ?? 0,
      activityDetails: activityDetails,
    );
  }

  // Validation method
  Map<String, String> validateForm() {
    Map<String, String> errors = {};

    if (state.qualificationName.isEmpty) {
      errors['qualificationName'] = 'Qualification name is required';
    }
    if (state.majorField.isEmpty) {
      errors['majorField'] = 'Major field is required';
    }
    if (state.awardingBodyName.isEmpty) {
      errors['awardingBodyName'] = 'Awarding body name is required';
    }
    if (state.awardingBodyCountry.isEmpty) {
      errors['awardingBodyCountry'] = 'Awarding body country is required';
    }
    if (state.streetAddress1.isEmpty) {
      errors['streetAddress1'] = 'Street address is required';
    }
    if (state.suburbCity.isEmpty) {
      errors['suburbCity'] = 'Suburb/City is required';
    }
    if (state.institutionCountry.isEmpty) {
      errors['institutionCountry'] = 'Institution country is required';
    }
    if (state.normalEntryRequirement.isEmpty) {
      errors['normalEntryRequirement'] = 'Normal entry requirement is required';
    }
    if (state.courseLengthYears.isEmpty &&
        state.courseLengthSemesters.isEmpty) {
      errors['courseLength'] = 'Course length (years or semesters) is required';
    }
    if (state.courseStartDate.isEmpty) {
      errors['courseStartDate'] = 'Course start date is required';
    }
    if (state.courseEndDate.isEmpty) {
      errors['courseEndDate'] = 'Course end date is required';
    }
    if (state.studyMode.isEmpty) {
      errors['studyMode'] = 'Study mode is required';
    }
    if (state.hoursPerWeek.isEmpty) {
      errors['hoursPerWeek'] = 'Hours per week is required';
    }

    return errors;
  }

  void resetForm() {
    state = TertiaryEducationFormData();
  }
}

// Providers
final tertiaryEducationProvider =
    StateNotifierProvider<TertiaryEducationNotifier, TertiaryEducationState>(
      (ref) => TertiaryEducationNotifier(),
    );

final tertiaryEducationFormProvider = StateNotifierProvider<
  TertiaryEducationFormNotifier,
  TertiaryEducationFormData
>((ref) => TertiaryEducationFormNotifier());

// Constants for dropdown options
final studyModeOptions = ['Full-time', 'Part-time', 'Other'];

final countryOptions = [
  'India',
  'Australia',
  'United States',
  'United Kingdom',
  'Canada',
  'New Zealand',
  // Add more countries as needed
];
