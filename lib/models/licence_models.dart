// models/licence_models.dart

class LicenceRequest {
  final int categoryId;
  final int countryId;
  final String nameofIssuingBody;
  final String typeOfLicence;
  final String registrationNumber;
  final String? dateOfExpiry;
  final String currentStatus;
  final String? currentStatusDetail;

  LicenceRequest({
    required this.categoryId,
    required this.countryId,
    required this.nameofIssuingBody,
    required this.typeOfLicence,
    required this.registrationNumber,
    this.dateOfExpiry,
    required this.currentStatus,
    this.currentStatusDetail,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'countryId': countryId,
      'nameofIssuingBody': nameofIssuingBody,
      'typeOfLicence': typeOfLicence,
      'registrationNumber': registrationNumber,
      'dateOfExpiry': dateOfExpiry,
      'currentStatus': currentStatus,
      'currentStatusDetail': currentStatusDetail ?? 'null',
    };
  }
}

class LicenceData {
  final int id;
  final int categoryId;
  final int countryId;
  final String nameofIssuingBody;
  final String typeOfLicence;
  final String registrationNumber;
  final String dateOfExpiry;
  final String currentStatus;
  final String currentStatusDetail;
  final String updatedAt;
  final String createdAt;

  LicenceData({
    required this.id,
    required this.categoryId,
    required this.countryId,
    required this.nameofIssuingBody,
    required this.typeOfLicence,
    required this.registrationNumber,
    required this.dateOfExpiry,
    required this.currentStatus,
    required this.currentStatusDetail,
    required this.updatedAt,
    required this.createdAt,
  });

  factory LicenceData.fromJson(Map<String, dynamic> json) {
    return LicenceData(
      id: json['id'],
      categoryId: json['categoryId'],
      countryId: json['countryId'],
      nameofIssuingBody: json['nameofIssuingBody'],
      typeOfLicence: json['typeOfLicence'],
      registrationNumber: json['registrationNumber'],
      dateOfExpiry: json['dateOfExpiry'],
      currentStatus: json['currentStatus'],
      currentStatusDetail: json['currentStatusDetail'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }
}

class LicenceResponse {
  final bool success;
  final String message;
  final LicenceData data;

  LicenceResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LicenceResponse.fromJson(Map<String, dynamic> json) {
    return LicenceResponse(
      success: json['success'],
      message: json['message'],
      data: LicenceData.fromJson(json['data']),
    );
  }
}

class LicenceState {
  final bool isLoading;
  final String? error;
  final LicenceResponse? response;

  LicenceState({this.isLoading = false, this.error, this.response});

  LicenceState copyWith({
    bool? isLoading,
    String? error,
    LicenceResponse? response,
  }) {
    return LicenceState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      response: response ?? this.response,
    );
  }
}
