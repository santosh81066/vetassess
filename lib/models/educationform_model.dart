// models/education_model.dart
class PrimarySchool {
  final String? dateStarted;
  final String? dateFinished;
  final int numberOfYears;
  final String country;
  final int? yearCompleted;

  PrimarySchool({
    this.dateStarted,
    this.dateFinished,
    required this.numberOfYears,
    required this.country,
    this.yearCompleted,
  });

  // Convert to new API format for primary school (levelId: 1)
  Map<String, dynamic> toApiJson() {
    return {
      'levelId': 1,
      'dateStarted': dateStarted,
      'dateFinished': dateFinished,
      'numberOfYears': numberOfYears > 0 ? numberOfYears : null,
      'country': country.isNotEmpty ? country : null,
      'yearCompleted': yearCompleted?.toString(),
      'certificateDetails': null,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'dateStarted': dateStarted,
      'dateFinished': dateFinished,
      'numberOfYears': numberOfYears,
      'country': country,
      'yearCompleted': yearCompleted ?? 0,
    };
  }

  factory PrimarySchool.fromJson(Map<String, dynamic> json) {
    return PrimarySchool(
      dateStarted: json['dateStarted'],
      dateFinished: json['dateFinished'],
      numberOfYears: json['numberOfYears'] ?? 0,
      country: json['country'] ?? '',
      yearCompleted: json['yearCompleted'],
    );
  }

  PrimarySchool copyWith({
    String? dateStarted,
    String? dateFinished,
    int? numberOfYears,
    String? country,
    int? yearCompleted,
  }) {
    return PrimarySchool(
      dateStarted: dateStarted ?? this.dateStarted,
      dateFinished: dateFinished ?? this.dateFinished,
      numberOfYears: numberOfYears ?? this.numberOfYears,
      country: country ?? this.country,
      yearCompleted: yearCompleted ?? this.yearCompleted,
    );
  }
}

class SecondarySchool {
  final String? dateStarted;
  final String? dateFinished;
  final int numberOfYears;
  final String country;

  SecondarySchool({
    this.dateStarted,
    this.dateFinished,
    required this.numberOfYears,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      'dateStarted': dateStarted,
      'dateFinished': dateFinished,
      'numberOfYears': numberOfYears,
      'country': country,
    };
  }

  factory SecondarySchool.fromJson(Map<String, dynamic> json) {
    return SecondarySchool(
      dateStarted: json['dateStarted'],
      dateFinished: json['dateFinished'],
      numberOfYears: json['numberOfYears'] ?? 0,
      country: json['country'] ?? '',
    );
  }

  SecondarySchool copyWith({
    String? dateStarted,
    String? dateFinished,
    int? numberOfYears,
    String? country,
  }) {
    return SecondarySchool(
      dateStarted: dateStarted ?? this.dateStarted,
      dateFinished: dateFinished ?? this.dateFinished,
      numberOfYears: numberOfYears ?? this.numberOfYears,
      country: country ?? this.country,
    );
  }
}

class HighestSchoolingCertificate {
  final String certificateDetails;
  final int yearObtained;

  HighestSchoolingCertificate({
    required this.certificateDetails,
    required this.yearObtained,
  });

  Map<String, dynamic> toJson() {
    return {
      'certificateDetails': certificateDetails,
      'yearObtained': yearObtained,
    };
  }

  factory HighestSchoolingCertificate.fromJson(Map<String, dynamic> json) {
    return HighestSchoolingCertificate(
      certificateDetails: json['certificateDetails'] ?? '',
      yearObtained: json['yearObtained'] ?? 0,
    );
  }

  HighestSchoolingCertificate copyWith({
    String? certificateDetails,
    int? yearObtained,
  }) {
    return HighestSchoolingCertificate(
      certificateDetails: certificateDetails ?? this.certificateDetails,
      yearObtained: yearObtained ?? this.yearObtained,
    );
  }
}

class EducationFormData {
  final PrimarySchool primarySchool;
  final SecondarySchool secondarySchool;
  final HighestSchoolingCertificate highestSchoolingCertificate;
  final bool isLoading;
  final String? errorMessage;

  EducationFormData({
    required this.primarySchool,
    required this.secondarySchool,
    required this.highestSchoolingCertificate,
    this.isLoading = false,
    this.errorMessage,
  });

  // Convert to new API format with educations array
  Map<String, dynamic> toApiJson(int userId) {
    List<Map<String, dynamic>> educations = [];
    
    // Primary School (levelId: 1)
    educations.add({
      "levelId": 1,
      "dateStarted": primarySchool.dateStarted,
      "dateFinished": primarySchool.dateFinished,
      "numberOfYears": primarySchool.numberOfYears > 0 ? primarySchool.numberOfYears : null,
      "country": primarySchool.country.isNotEmpty ? primarySchool.country : null,
      "yearCompleted": primarySchool.yearCompleted?.toString(),
      "certificateDetails": null
    });

    // Secondary School (levelId: 2)
    educations.add({
      "levelId": 2,
      "dateStarted": secondarySchool.dateStarted,
      "dateFinished": secondarySchool.dateFinished,
      "numberOfYears": secondarySchool.numberOfYears > 0 ? secondarySchool.numberOfYears : null,
      "country": secondarySchool.country.isNotEmpty ? secondarySchool.country : null,
      "yearCompleted": highestSchoolingCertificate.yearObtained > 0 ? highestSchoolingCertificate.yearObtained.toString() : null,
      "certificateDetails": highestSchoolingCertificate.certificateDetails.isNotEmpty ? highestSchoolingCertificate.certificateDetails : null
    });

    return {
      'userId': userId,
      'educations': educations,
    };
  }

  // Keep the old format for backward compatibility
  Map<String, dynamic> toJson(int userId) {
    return {
      'userId': userId,
      'primarySchool': primarySchool.toJson(),
      'secondarySchool': secondarySchool.toJson(),
      'highestSchoolingCertificate': highestSchoolingCertificate.toJson(),
    };
  }

  factory EducationFormData.empty() {
    return EducationFormData(
      primarySchool: PrimarySchool(numberOfYears: 0, country: ''),
      secondarySchool: SecondarySchool(numberOfYears: 0, country: ''),
      highestSchoolingCertificate: HighestSchoolingCertificate(certificateDetails: '', yearObtained: 0),
    );
  }

  EducationFormData copyWith({
    PrimarySchool? primarySchool,
    SecondarySchool? secondarySchool,
    HighestSchoolingCertificate? highestSchoolingCertificate,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EducationFormData(
      primarySchool: primarySchool ?? this.primarySchool,
      secondarySchool: secondarySchool ?? this.secondarySchool,
      highestSchoolingCertificate: highestSchoolingCertificate ?? this.highestSchoolingCertificate,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}