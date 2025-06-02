// models/tertiary_education_model.dart
class TertiaryEducationRequest {
  final int userId;
  final String? studentRegistrationNumber;
  final String qualificationName;
  final String majorField;
  final String awardingBodyName;
  final String awardingBodyCountry;
  final String? campusAttended;
  final String institutionName;
  final String streetAddress1;
  final String? streetAddress2;
  final String suburbCity;
  final String? state;
  final String? postCode;
  final String institutionCountry;
  final String normalEntryRequirement;
  final String entryBasis;
  final String courseLengthYearsOrSemesters;
  final String semesterLengthWeeksOrMonths;
  final String courseStartDate;
  final String courseEndDate;
  final String qualificationAwardedDate;
  final String studyMode;
  final int hoursPerWeek;
  final int internshipWeeks;
  final int thesisWeeks;
  final int majorProjectWeeks;
  final String activityDetails;

  TertiaryEducationRequest({
    required this.userId,
    this.studentRegistrationNumber,
    required this.qualificationName,
    required this.majorField,
    required this.awardingBodyName,
    required this.awardingBodyCountry,
    this.campusAttended,
    required this.institutionName,
    required this.streetAddress1,
    this.streetAddress2,
    required this.suburbCity,
    this.state,
    this.postCode,
    required this.institutionCountry,
    required this.normalEntryRequirement,
    required this.entryBasis,
    required this.courseLengthYearsOrSemesters,
    required this.semesterLengthWeeksOrMonths,
    required this.courseStartDate,
    required this.courseEndDate,
    required this.qualificationAwardedDate,
    required this.studyMode,
    required this.hoursPerWeek,
    required this.internshipWeeks,
    required this.thesisWeeks,
    required this.majorProjectWeeks,
    required this.activityDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'studentRegistrationNumber': studentRegistrationNumber,
      'qualificationName': qualificationName,
      'majorField': majorField,
      'awardingBodyName': awardingBodyName,
      'awardingBodyCountry': awardingBodyCountry,
      'campusAttended': campusAttended,
      'institutionName': institutionName,
      'streetAddress1': streetAddress1,
      'streetAddress2': streetAddress2,
      'suburbCity': suburbCity,
      'state': state,
      'postCode': postCode,
      'institutionCountry': institutionCountry,
      'normalEntryRequirement': normalEntryRequirement,
      'entryBasis': entryBasis,
      'courseLengthYearsOrSemesters': courseLengthYearsOrSemesters,
      'semesterLengthWeeksOrMonths': semesterLengthWeeksOrMonths,
      'courseStartDate': courseStartDate,
      'courseEndDate': courseEndDate,
      'qualificationAwardedDate': qualificationAwardedDate,
      'studyMode': studyMode,
      'hoursPerWeek': hoursPerWeek,
      'internshipWeeks': internshipWeeks,
      'thesisWeeks': thesisWeeks,
      'majorProjectWeeks': majorProjectWeeks,
      'activityDetails': activityDetails,
    };
  }
}

class TertiaryEducationQualification {
  final int educationId;
  final int userId;
  final String? studentRegistrationNumber;
  final String qualificationName;
  final String majorField;
  final String awardingBodyName;
  final String awardingBodyCountry;
  final String? campusAttended;
  final String institutionName;
  final String streetAddress1;
  final String? streetAddress2;
  final String suburbCity;
  final String? state;
  final String? postCode;
  final String institutionCountry;
  final String normalEntryRequirement;
  final String entryBasis;
  final String courseLengthYearsOrSemesters;
  final String semesterLengthWeeksOrMonths;
  final String courseStartDate;
  final String courseEndDate;
  final String qualificationAwardedDate;
  final String studyMode;
  final int hoursPerWeek;
  final int internshipWeeks;
  final int thesisWeeks;
  final int majorProjectWeeks;
  final String activityDetails;

  TertiaryEducationQualification({
    required this.educationId,
    required this.userId,
    this.studentRegistrationNumber,
    required this.qualificationName,
    required this.majorField,
    required this.awardingBodyName,
    required this.awardingBodyCountry,
    this.campusAttended,
    required this.institutionName,
    required this.streetAddress1,
    this.streetAddress2,
    required this.suburbCity,
    this.state,
    this.postCode,
    required this.institutionCountry,
    required this.normalEntryRequirement,
    required this.entryBasis,
    required this.courseLengthYearsOrSemesters,
    required this.semesterLengthWeeksOrMonths,
    required this.courseStartDate,
    required this.courseEndDate,
    required this.qualificationAwardedDate,
    required this.studyMode,
    required this.hoursPerWeek,
    required this.internshipWeeks,
    required this.thesisWeeks,
    required this.majorProjectWeeks,
    required this.activityDetails,
  });

  factory TertiaryEducationQualification.fromJson(Map<String, dynamic> json) {
    return TertiaryEducationQualification(
      educationId: json['educationId'],
      userId: json['userId'],
      studentRegistrationNumber: json['studentRegistrationNumber'],
      qualificationName: json['qualificationName'],
      majorField: json['majorField'],
      awardingBodyName: json['awardingBodyName'],
      awardingBodyCountry: json['awardingBodyCountry'],
      campusAttended: json['campusAttended'],
      institutionName: json['institutionName'],
      streetAddress1: json['streetAddress1'],
      streetAddress2: json['streetAddress2'],
      suburbCity: json['suburbCity'],
      state: json['state'],
      postCode: json['postCode'],
      institutionCountry: json['institutionCountry'],
      normalEntryRequirement: json['normalEntryRequirement'],
      entryBasis: json['entryBasis'],
      courseLengthYearsOrSemesters: json['courseLengthYearsOrSemesters'],
      semesterLengthWeeksOrMonths: json['semesterLengthWeeksOrMonths'],
      courseStartDate: json['courseStartDate'],
      courseEndDate: json['courseEndDate'],
      qualificationAwardedDate: json['qualificationAwardedDate'],
      studyMode: json['studyMode'],
      hoursPerWeek: json['hoursPerWeek'],
      internshipWeeks: json['internshipWeeks'],
      thesisWeeks: json['thesisWeeks'],
      majorProjectWeeks: json['majorProjectWeeks'],
      activityDetails: json['activityDetails'],
    );
  }
}

class TertiaryEducationResponse {
  final String message;
  final TertiaryEducationQualification qualification;

  TertiaryEducationResponse({
    required this.message,
    required this.qualification,
  });

  factory TertiaryEducationResponse.fromJson(Map<String, dynamic> json) {
    return TertiaryEducationResponse(
      message: json['message'],
      qualification: TertiaryEducationQualification.fromJson(
        json['qualification'],
      ),
    );
  }
}

class TertiaryEducationState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final TertiaryEducationResponse? response;

  TertiaryEducationState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.response,
  });

  TertiaryEducationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    TertiaryEducationResponse? response,
  }) {
    return TertiaryEducationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      response: response ?? this.response,
    );
  }
}

// Form field state management
class TertiaryEducationFormData {
  final String? studentRegistrationNumber;
  final String qualificationName;
  final String majorField;
  final String awardingBodyName;
  final String awardingBodyCountry;
  final String? campusAttended;
  final String institutionName;
  final String streetAddress1;
  final String? streetAddress2;
  final String suburbCity;
  final String? state;
  final String? postCode;
  final String institutionCountry;
  final String normalEntryRequirement;
  final String entryBasis;
  final String courseLengthYears;
  final String courseLengthSemesters;
  final String semesterLengthWeeksOrMonths;
  final String courseStartDate;
  final String courseEndDate;
  final String qualificationAwardedDate;
  final String studyMode;
  final String hoursPerWeek;
  final bool hasInternship;
  final bool hasThesis;
  final bool hasMajorProject;
  final String internshipWeeks;
  final String thesisWeeks;
  final String majorProjectWeeks;

  TertiaryEducationFormData({
    this.studentRegistrationNumber = '',
    this.qualificationName = '',
    this.majorField = '',
    this.awardingBodyName = '',
    this.awardingBodyCountry = '',
    this.campusAttended = '',
    this.institutionName = '',
    this.streetAddress1 = '',
    this.streetAddress2 = '',
    this.suburbCity = '',
    this.state = '',
    this.postCode = '',
    this.institutionCountry = '',
    this.normalEntryRequirement = '',
    this.entryBasis = '',
    this.courseLengthYears = '',
    this.courseLengthSemesters = '',
    this.semesterLengthWeeksOrMonths = '',
    this.courseStartDate = '',
    this.courseEndDate = '',
    this.qualificationAwardedDate = '',
    this.studyMode = '',
    this.hoursPerWeek = '',
    this.hasInternship = false,
    this.hasThesis = false,
    this.hasMajorProject = false,
    this.internshipWeeks = '0',
    this.thesisWeeks = '0',
    this.majorProjectWeeks = '0',
  });

  TertiaryEducationFormData copyWith({
    String? studentRegistrationNumber,
    String? qualificationName,
    String? majorField,
    String? awardingBodyName,
    String? awardingBodyCountry,
    String? campusAttended,
    String? institutionName,
    String? streetAddress1,
    String? streetAddress2,
    String? suburbCity,
    String? state,
    String? postCode,
    String? institutionCountry,
    String? normalEntryRequirement,
    String? entryBasis,
    String? courseLengthYears,
    String? courseLengthSemesters,
    String? semesterLengthWeeksOrMonths,
    String? courseStartDate,
    String? courseEndDate,
    String? qualificationAwardedDate,
    String? studyMode,
    String? hoursPerWeek,
    bool? hasInternship,
    bool? hasThesis,
    bool? hasMajorProject,
    String? internshipWeeks,
    String? thesisWeeks,
    String? majorProjectWeeks,
  }) {
    return TertiaryEducationFormData(
      studentRegistrationNumber:
          studentRegistrationNumber ?? this.studentRegistrationNumber,
      qualificationName: qualificationName ?? this.qualificationName,
      majorField: majorField ?? this.majorField,
      awardingBodyName: awardingBodyName ?? this.awardingBodyName,
      awardingBodyCountry: awardingBodyCountry ?? this.awardingBodyCountry,
      campusAttended: campusAttended ?? this.campusAttended,
      institutionName: institutionName ?? this.institutionName,
      streetAddress1: streetAddress1 ?? this.streetAddress1,
      streetAddress2: streetAddress2 ?? this.streetAddress2,
      suburbCity: suburbCity ?? this.suburbCity,
      state: state ?? this.state,
      postCode: postCode ?? this.postCode,
      institutionCountry: institutionCountry ?? this.institutionCountry,
      normalEntryRequirement:
          normalEntryRequirement ?? this.normalEntryRequirement,
      entryBasis: entryBasis ?? this.entryBasis,
      courseLengthYears: courseLengthYears ?? this.courseLengthYears,
      courseLengthSemesters:
          courseLengthSemesters ?? this.courseLengthSemesters,
      semesterLengthWeeksOrMonths:
          semesterLengthWeeksOrMonths ?? this.semesterLengthWeeksOrMonths,
      courseStartDate: courseStartDate ?? this.courseStartDate,
      courseEndDate: courseEndDate ?? this.courseEndDate,
      qualificationAwardedDate:
          qualificationAwardedDate ?? this.qualificationAwardedDate,
      studyMode: studyMode ?? this.studyMode,
      hoursPerWeek: hoursPerWeek ?? this.hoursPerWeek,
      hasInternship: hasInternship ?? this.hasInternship,
      hasThesis: hasThesis ?? this.hasThesis,
      hasMajorProject: hasMajorProject ?? this.hasMajorProject,
      internshipWeeks: internshipWeeks ?? this.internshipWeeks,
      thesisWeeks: thesisWeeks ?? this.thesisWeeks,
      majorProjectWeeks: majorProjectWeeks ?? this.majorProjectWeeks,
    );
  }
}
