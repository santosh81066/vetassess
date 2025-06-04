// models/tertiary_qualification_model.dart

class TertiaryQualificationRequest {
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
  final String? entryBasis;
  final String courseLengthYearsOrSemesters;
  final String semesterLengthWeeksOrMonths;
  final String courseStartDate;
  final String courseEndDate;
  final String? qualificationAwardedDate;
  final String studyMode;
  final int hoursPerWeek;
  final int? internshipWeeks;
  final int? thesisWeeks;
  final int? majorProjectWeeks;
  final String? activityDetails;

  TertiaryQualificationRequest({
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
    this.entryBasis,
    required this.courseLengthYearsOrSemesters,
    required this.semesterLengthWeeksOrMonths,
    required this.courseStartDate,
    required this.courseEndDate,
    this.qualificationAwardedDate,
    required this.studyMode,
    required this.hoursPerWeek,
    this.internshipWeeks,
    this.thesisWeeks,
    this.majorProjectWeeks,
    this.activityDetails,
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

class TertiaryQualificationData {
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
  final String? entryBasis;
  final String courseLengthYearsOrSemesters;
  final String semesterLengthWeeksOrMonths;
  final String courseStartDate;
  final String courseEndDate;
  final String? qualificationAwardedDate;
  final String studyMode;
  final int hoursPerWeek;
  final int? internshipWeeks;
  final int? thesisWeeks;
  final int? majorProjectWeeks;
  final String? activityDetails;

  TertiaryQualificationData({
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
    this.entryBasis,
    required this.courseLengthYearsOrSemesters,
    required this.semesterLengthWeeksOrMonths,
    required this.courseStartDate,
    required this.courseEndDate,
    this.qualificationAwardedDate,
    required this.studyMode,
    required this.hoursPerWeek,
    this.internshipWeeks,
    this.thesisWeeks,
    this.majorProjectWeeks,
    this.activityDetails,
  });

  factory TertiaryQualificationData.fromJson(Map<String, dynamic> json) {
    return TertiaryQualificationData(
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

class TertiaryQualificationResponse {
  final String message;
  final TertiaryQualificationData qualification;

  TertiaryQualificationResponse({
    required this.message,
    required this.qualification,
  });

  factory TertiaryQualificationResponse.fromJson(Map<String, dynamic> json) {
    return TertiaryQualificationResponse(
      message: json['message'],
      qualification: TertiaryQualificationData.fromJson(json['qualification']),
    );
  }
}

class TertiaryQualificationState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final TertiaryQualificationResponse? response;

  TertiaryQualificationState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.response,
  });

  TertiaryQualificationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    TertiaryQualificationResponse? response,
  }) {
    return TertiaryQualificationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      response: response ?? this.response,
    );
  }
}
