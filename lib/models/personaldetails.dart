class PersonalDetails {
  final String? preferredTitle;
  final String? surname;
  final String? givenNames;
  final String? gender;
  final String? dateOfBirth;
  final String? countryOfBirth;
  final String? citizenshipCountry;
  final String? countryOfCurrentResidency;
  final String? currentPassportNumber;
  final String? datePassportIssued;
  final String? emailAddress;
  final String? daytimeTelephoneNumber;
  final String? postalStreetAddress;
  final String? postalSuburbCity;
  final String? postalCountry;
  final String? homeStreetAddress;
  final String? homeSuburbCity;
  final String? homeCountry;
  final bool? isAgentAuthorized;

  PersonalDetails({
    this.preferredTitle,
    this.surname,
    this.givenNames,
    this.gender = 'Male',
    this.dateOfBirth,
    this.countryOfBirth,
    this.citizenshipCountry,
    this.countryOfCurrentResidency,
    this.currentPassportNumber,
    this.datePassportIssued,
    this.emailAddress,
    this.daytimeTelephoneNumber,
    this.postalStreetAddress,
    this.postalSuburbCity,
    this.postalCountry,
    this.homeStreetAddress,
    this.homeSuburbCity,
    this.homeCountry,
    this.isAgentAuthorized = false,
  });

  PersonalDetails copyWith({
    String? preferredTitle,
    String? surname,
    String? givenNames,
    String? gender,
    String? dateOfBirth,
    String? countryOfBirth,
    String? citizenshipCountry,
    String? countryOfCurrentResidency,
    String? currentPassportNumber,
    String? datePassportIssued,
    String? emailAddress,
    String? daytimeTelephoneNumber,
    String? postalStreetAddress,
    String? postalSuburbCity,
    String? postalCountry,
    String? homeStreetAddress,
    String? homeSuburbCity,
    String? homeCountry,
    bool? isAgentAuthorized,
  }) {
    return PersonalDetails(
      preferredTitle: preferredTitle ?? this.preferredTitle,
      surname: surname ?? this.surname,
      givenNames: givenNames ?? this.givenNames,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      countryOfBirth: countryOfBirth ?? this.countryOfBirth,
      citizenshipCountry: citizenshipCountry ?? this.citizenshipCountry,
      countryOfCurrentResidency: countryOfCurrentResidency ?? this.countryOfCurrentResidency,
      currentPassportNumber: currentPassportNumber ?? this.currentPassportNumber,
      datePassportIssued: datePassportIssued ?? this.datePassportIssued,
      emailAddress: emailAddress ?? this.emailAddress,
      daytimeTelephoneNumber: daytimeTelephoneNumber ?? this.daytimeTelephoneNumber,
      postalStreetAddress: postalStreetAddress ?? this.postalStreetAddress,
      postalSuburbCity: postalSuburbCity ?? this.postalSuburbCity,
      postalCountry: postalCountry ?? this.postalCountry,
      homeStreetAddress: homeStreetAddress ?? this.homeStreetAddress,
      homeSuburbCity: homeSuburbCity ?? this.homeSuburbCity,
      homeCountry: homeCountry ?? this.homeCountry,
      isAgentAuthorized: isAgentAuthorized ?? this.isAgentAuthorized,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preferredTitle': preferredTitle,
      'surname': surname,
      'givenNames': givenNames,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'countryOfBirth': countryOfBirth,
      'citizenshipCountry': citizenshipCountry,
      'countryOfCurrentResidency': countryOfCurrentResidency,
      'currentPassportNumber': currentPassportNumber,
      'datePassportIssued': datePassportIssued,
      'emailAddress': emailAddress,
      'daytimeTelephoneNumber': daytimeTelephoneNumber,
      'postalStreetAddress': postalStreetAddress,
      'postalSuburbCity': postalSuburbCity,
      'postalCountry': postalCountry,
      'homeStreetAddress': homeStreetAddress,
      'homeSuburbCity': homeSuburbCity,
      'homeCountry': homeCountry,
      'isAgentAuthorized': isAgentAuthorized,
    };
  }

  factory PersonalDetails.fromJson(Map<String, dynamic> json) {
    return PersonalDetails(
      preferredTitle: json['preferredTitle'],
      surname: json['surname'],
      givenNames: json['givenNames'],
      gender: json['gender'] ?? 'Male',
      dateOfBirth: json['dateOfBirth'],
      countryOfBirth: json['countryOfBirth'],
      citizenshipCountry: json['citizenshipCountry'],
      countryOfCurrentResidency: json['countryOfCurrentResidency'],
      currentPassportNumber: json['currentPassportNumber'],
      datePassportIssued: json['datePassportIssued'],
      emailAddress: json['emailAddress'],
      daytimeTelephoneNumber: json['daytimeTelephoneNumber'],
      postalStreetAddress: json['postalStreetAddress'],
      postalSuburbCity: json['postalSuburbCity'],
      postalCountry: json['postalCountry'],
      homeStreetAddress: json['homeStreetAddress'],
      homeSuburbCity: json['homeSuburbCity'],
      homeCountry: json['homeCountry'],
      isAgentAuthorized: json['isAgentAuthorized'] ?? false,
    );
  }

  @override
  String toString() {
    return 'PersonalDetails(preferredTitle: $preferredTitle, surname: $surname, givenNames: $givenNames, gender: $gender, dateOfBirth: $dateOfBirth, countryOfBirth: $countryOfBirth, citizenshipCountry: $citizenshipCountry, countryOfCurrentResidency: $countryOfCurrentResidency, currentPassportNumber: $currentPassportNumber, datePassportIssued: $datePassportIssued, emailAddress: $emailAddress, daytimeTelephoneNumber: $daytimeTelephoneNumber, postalStreetAddress: $postalStreetAddress, postalSuburbCity: $postalSuburbCity, postalCountry: $postalCountry, homeStreetAddress: $homeStreetAddress, homeSuburbCity: $homeSuburbCity, homeCountry: $homeCountry, isAgentAuthorized: $isAgentAuthorized)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PersonalDetails &&
      other.preferredTitle == preferredTitle &&
      other.surname == surname &&
      other.givenNames == givenNames &&
      other.gender == gender &&
      other.dateOfBirth == dateOfBirth &&
      other.countryOfBirth == countryOfBirth &&
      other.citizenshipCountry == citizenshipCountry &&
      other.countryOfCurrentResidency == countryOfCurrentResidency &&
      other.currentPassportNumber == currentPassportNumber &&
      other.datePassportIssued == datePassportIssued &&
      other.emailAddress == emailAddress &&
      other.daytimeTelephoneNumber == daytimeTelephoneNumber &&
      other.postalStreetAddress == postalStreetAddress &&
      other.postalSuburbCity == postalSuburbCity &&
      other.postalCountry == postalCountry &&
      other.homeStreetAddress == homeStreetAddress &&
      other.homeSuburbCity == homeSuburbCity &&
      other.homeCountry == homeCountry &&
      other.isAgentAuthorized == isAgentAuthorized;
  }

  @override
  int get hashCode {
    return preferredTitle.hashCode ^
      surname.hashCode ^
      givenNames.hashCode ^
      gender.hashCode ^
      dateOfBirth.hashCode ^
      countryOfBirth.hashCode ^
      citizenshipCountry.hashCode ^
      countryOfCurrentResidency.hashCode ^
      currentPassportNumber.hashCode ^
      datePassportIssued.hashCode ^
      emailAddress.hashCode ^
      daytimeTelephoneNumber.hashCode ^
      postalStreetAddress.hashCode ^
      postalSuburbCity.hashCode ^
      postalCountry.hashCode ^
      homeStreetAddress.hashCode ^
      homeSuburbCity.hashCode ^
      homeCountry.hashCode ^
      isAgentAuthorized.hashCode;
  }
}
// Create a result class to hold both success status and error message
class SubmissionResult {
  final bool success;
  final String? errorMessage;
  final Map<String, dynamic>? errorDetails;

  SubmissionResult({
    required this.success,
    this.errorMessage,
    this.errorDetails,
  });
}