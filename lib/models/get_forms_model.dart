class GetAllFormsModel {
  List<Users>? users;

  GetAllFormsModel({this.users});
  GetAllFormsModel.initial() : users = [];

  GetAllFormsModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? userId;
  String? givenNames;
  String? surname;
  String? dateOfBirth;
  String? businessName; // Changed from Null? to String?
  String? registrationStatus; // Changed from Null? to String?
  String? registrationNumber; // Changed from Null? to String?
  String? email;
  String? password;
  String? role;
  bool? isAgreedToReceiveNews;
  String? applicationStatus;
  String? certificate;
  List<PersonalDetails>? personalDetails;
  List<EducationQualifications>? educationQualifications;
  List<Educations>? educations;
  List<Employments>? employments;
  List<UploadedDocuments>? uploadedDocuments;
  List<UserVisas>? userVisas;
  List<UserOccupations>? userOccupations;
  List<Licences>? licences;
  List<PriorityProcess>? priorityProcess;

  Users({
    this.userId,
    this.givenNames,
    this.surname,
    this.dateOfBirth,
    this.businessName,
    this.registrationStatus,
    this.registrationNumber,
    this.email,
    this.password,
    this.role,
    this.isAgreedToReceiveNews,
    this.applicationStatus,
    this.certificate,
    this.personalDetails,
    this.educationQualifications,
    this.educations,
    this.employments,
    this.uploadedDocuments,
    this.userVisas,
    this.userOccupations,
    this.licences,
    this.priorityProcess,
  });

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    givenNames = json['givenNames'];
    surname = json['surname'];
    dateOfBirth = json['dateOfBirth'];
    businessName = json['businessName'];
    registrationStatus = json['registrationStatus'];
    registrationNumber = json['registrationNumber'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    isAgreedToReceiveNews = json['isAgreedToReceiveNews'];
    applicationStatus = json['application_status'];
    certificate = json['certificate'];
    if (json['PersonalDetails'] != null) {
      personalDetails = <PersonalDetails>[];
      json['PersonalDetails'].forEach((v) {
        personalDetails!.add(new PersonalDetails.fromJson(v));
      });
    }
    if (json['EducationQualifications'] != null) {
      educationQualifications = <EducationQualifications>[];
      json['EducationQualifications'].forEach((v) {
        educationQualifications!.add(new EducationQualifications.fromJson(v));
      });
    }
    if (json['Educations'] != null) {
      educations = <Educations>[];
      json['Educations'].forEach((v) {
        educations!.add(new Educations.fromJson(v));
      });
    }
    if (json['Employments'] != null) {
      employments = <Employments>[];
      json['Employments'].forEach((v) {
        employments!.add(new Employments.fromJson(v));
      });
    }
    if (json['uploadedDocuments'] != null) {
      uploadedDocuments = <UploadedDocuments>[];
      json['uploadedDocuments'].forEach((v) {
        uploadedDocuments!.add(new UploadedDocuments.fromJson(v));
      });
    }
    if (json['user_Visas'] != null) {
      userVisas = <UserVisas>[];
      json['user_Visas'].forEach((v) {
        userVisas!.add(new UserVisas.fromJson(v));
      });
    }
    if (json['UserOccupations'] != null) {
      userOccupations = <UserOccupations>[];
      json['UserOccupations'].forEach((v) {
        userOccupations!.add(new UserOccupations.fromJson(v));
      });
    }
    if (json['Licences'] != null) {
      licences = <Licences>[];
      json['Licences'].forEach((v) {
        licences!.add(new Licences.fromJson(v));
      });
    }
    if (json['priorityProcess'] != null) {
      priorityProcess = <PriorityProcess>[];
      json['priorityProcess'].forEach((v) {
        priorityProcess!.add(new PriorityProcess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['givenNames'] = this.givenNames;
    data['surname'] = this.surname;
    data['dateOfBirth'] = this.dateOfBirth;
    data['businessName'] = this.businessName;
    data['registrationStatus'] = this.registrationStatus;
    data['registrationNumber'] = this.registrationNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['isAgreedToReceiveNews'] = this.isAgreedToReceiveNews;
    data['application_status'] = this.applicationStatus;
    data['certificate'] = this.certificate;
    if (this.personalDetails != null) {
      data['PersonalDetails'] =
          this.personalDetails!.map((v) => v.toJson()).toList();
    }
    if (this.educationQualifications != null) {
      data['EducationQualifications'] =
          this.educationQualifications!.map((v) => v.toJson()).toList();
    }
    if (this.educations != null) {
      data['Educations'] = this.educations!.map((v) => v.toJson()).toList();
    }
    if (this.employments != null) {
      data['Employments'] = this.employments!.map((v) => v.toJson()).toList();
    }
    if (this.uploadedDocuments != null) {
      data['uploadedDocuments'] =
          this.uploadedDocuments!.map((v) => v.toJson()).toList();
    }
    if (this.userVisas != null) {
      data['user_Visas'] = this.userVisas!.map((v) => v.toJson()).toList();
    }
    if (this.userOccupations != null) {
      data['UserOccupations'] =
          this.userOccupations!.map((v) => v.toJson()).toList();
    }
    if (this.licences != null) {
      data['Licences'] = this.licences!.map((v) => v.toJson()).toList();
    }
    if (this.priorityProcess != null) {
      data['priorityProcess'] =
          this.priorityProcess!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  copyWith({required List<PersonalDetails> personalDetails}) {
    return Users(
      userId: userId,
      personalDetails: personalDetails ?? this.personalDetails,
      //educationQualifications: educationQualifications ?? this.educationQualifications,
      // ... other properties
    );
  }
}

class PersonalDetails {
  int? personalDetailsId;
  int? userId;
  String? status;
  String? preferredTitle;
  String? surname;
  String? givenNames;
  String? gender;
  String? previousSurname;
  String? previousGivenNames;
  String? dateOfBirth;
  String? countryOfBirth;
  String? countryOfCurrentResidency;
  String? citizenshipCountry;
  String? currentPassportNumber;
  String? datePassportIssued;
  String? otherCitizenshipCountry;
  String? otherPassportNumber;
  String? otherDatePassportIssued;
  String? emailAddress;
  String? daytimeTelephoneNumber;
  String? faxNumber;
  String? mobileNumber;
  String? postalStreetAddress;
  String? postalStreetAddressLine2;
  String? postalStreetAddressLine3;
  String? postalStreetAddressLine4;
  String? postalSuburbCity;
  String? postalState;
  String? postalPostCode;
  String? postalCountry;
  String? homeStreetAddress;
  String? homeStreetAddressLine2;
  String? homeStreetAddressLine3;
  String? homeStreetAddressLine4;
  String? homeSuburbCity;
  String? homeState;
  String? homePostCode;
  String? homeCountry;
  bool? isAgentAuthorized;
  String? agentSurname;
  String? agentGivenNames;
  String? agentCompanyName;
  String? agentMaraNumber;
  String? agentEmailAddress;
  String? agentDaytimeTelephoneNumber;
  String? agentFaxNumber;
  String? agentMobileNumber;
  String? agentStreetAddress;
  String? agentStreetAddressLine2;
  String? agentStreetAddressLine3;
  String? agentStreetAddressLine4;
  String? agentSuburbCity;
  String? agentState;
  String? agentPostCode;
  String? agentCountry;
  String? createdAt;
  String? updatedAt;

  PersonalDetails({
    this.personalDetailsId,
    this.userId,
    this.status,
    this.preferredTitle,
    this.surname,
    this.givenNames,
    this.gender,
    this.previousSurname,
    this.previousGivenNames,
    this.dateOfBirth,
    this.countryOfBirth,
    this.countryOfCurrentResidency,
    this.citizenshipCountry,
    this.currentPassportNumber,
    this.datePassportIssued,
    this.otherCitizenshipCountry,
    this.otherPassportNumber,
    this.otherDatePassportIssued,
    this.emailAddress,
    this.daytimeTelephoneNumber,
    this.faxNumber,
    this.mobileNumber,
    this.postalStreetAddress,
    this.postalStreetAddressLine2,
    this.postalStreetAddressLine3,
    this.postalStreetAddressLine4,
    this.postalSuburbCity,
    this.postalState,
    this.postalPostCode,
    this.postalCountry,
    this.homeStreetAddress,
    this.homeStreetAddressLine2,
    this.homeStreetAddressLine3,
    this.homeStreetAddressLine4,
    this.homeSuburbCity,
    this.homeState,
    this.homePostCode,
    this.homeCountry,
    this.isAgentAuthorized,
    this.agentSurname,
    this.agentGivenNames,
    this.agentCompanyName,
    this.agentMaraNumber,
    this.agentEmailAddress,
    this.agentDaytimeTelephoneNumber,
    this.agentFaxNumber,
    this.agentMobileNumber,
    this.agentStreetAddress,
    this.agentStreetAddressLine2,
    this.agentStreetAddressLine3,
    this.agentStreetAddressLine4,
    this.agentSuburbCity,
    this.agentState,
    this.agentPostCode,
    this.agentCountry,
    this.createdAt,
    this.updatedAt,
  });

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    personalDetailsId = json['personalDetailsId'];
    userId = json['userId'];
    status = json['status'];
    preferredTitle = json['preferredTitle'];
    surname = json['surname'];
    givenNames = json['givenNames'];
    gender = json['gender'];
    previousSurname = json['previousSurname'];
    previousGivenNames = json['previousGivenNames'];
    dateOfBirth = json['dateOfBirth'];
    countryOfBirth = json['countryOfBirth'];
    countryOfCurrentResidency = json['countryOfCurrentResidency'];
    citizenshipCountry = json['citizenshipCountry'];
    currentPassportNumber = json['currentPassportNumber'];
    datePassportIssued = json['datePassportIssued'];
    otherCitizenshipCountry = json['otherCitizenshipCountry'];
    otherPassportNumber = json['otherPassportNumber'];
    otherDatePassportIssued = json['otherDatePassportIssued'];
    emailAddress = json['emailAddress'];
    daytimeTelephoneNumber = json['daytimeTelephoneNumber'];
    faxNumber = json['faxNumber'];
    mobileNumber = json['mobileNumber'];
    postalStreetAddress = json['postalStreetAddress'];
    postalStreetAddressLine2 = json['postalStreetAddressLine2'];
    postalStreetAddressLine3 = json['postalStreetAddressLine3'];
    postalStreetAddressLine4 = json['postalStreetAddressLine4'];
    postalSuburbCity = json['postalSuburbCity'];
    postalState = json['postalState'];
    postalPostCode = json['postalPostCode'];
    postalCountry = json['postalCountry'];
    homeStreetAddress = json['homeStreetAddress'];
    homeStreetAddressLine2 = json['homeStreetAddressLine2'];
    homeStreetAddressLine3 = json['homeStreetAddressLine3'];
    homeStreetAddressLine4 = json['homeStreetAddressLine4'];
    homeSuburbCity = json['homeSuburbCity'];
    homeState = json['homeState'];
    homePostCode = json['homePostCode'];
    homeCountry = json['homeCountry'];
    isAgentAuthorized = json['isAgentAuthorized'];
    agentSurname = json['agentSurname'];
    agentGivenNames = json['agentGivenNames'];
    agentCompanyName = json['agentCompanyName'];
    agentMaraNumber = json['agentMaraNumber'];
    agentEmailAddress = json['agentEmailAddress'];
    agentDaytimeTelephoneNumber = json['agentDaytimeTelephoneNumber'];
    agentFaxNumber = json['agentFaxNumber'];
    agentMobileNumber = json['agentMobileNumber'];
    agentStreetAddress = json['agentStreetAddress'];
    agentStreetAddressLine2 = json['agentStreetAddressLine2'];
    agentStreetAddressLine3 = json['agentStreetAddressLine3'];
    agentStreetAddressLine4 = json['agentStreetAddressLine4'];
    agentSuburbCity = json['agentSuburbCity'];
    agentState = json['agentState'];
    agentPostCode = json['agentPostCode'];
    agentCountry = json['agentCountry'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personalDetailsId'] = this.personalDetailsId;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['preferredTitle'] = this.preferredTitle;
    data['surname'] = this.surname;
    data['givenNames'] = this.givenNames;
    data['gender'] = this.gender;
    data['previousSurname'] = this.previousSurname;
    data['previousGivenNames'] = this.previousGivenNames;
    data['dateOfBirth'] = this.dateOfBirth;
    data['countryOfBirth'] = this.countryOfBirth;
    data['countryOfCurrentResidency'] = this.countryOfCurrentResidency;
    data['citizenshipCountry'] = this.citizenshipCountry;
    data['currentPassportNumber'] = this.currentPassportNumber;
    data['datePassportIssued'] = this.datePassportIssued;
    data['otherCitizenshipCountry'] = this.otherCitizenshipCountry;
    data['otherPassportNumber'] = this.otherPassportNumber;
    data['otherDatePassportIssued'] = this.otherDatePassportIssued;
    data['emailAddress'] = this.emailAddress;
    data['daytimeTelephoneNumber'] = this.daytimeTelephoneNumber;
    data['faxNumber'] = this.faxNumber;
    data['mobileNumber'] = this.mobileNumber;
    data['postalStreetAddress'] = this.postalStreetAddress;
    data['postalStreetAddressLine2'] = this.postalStreetAddressLine2;
    data['postalStreetAddressLine3'] = this.postalStreetAddressLine3;
    data['postalStreetAddressLine4'] = this.postalStreetAddressLine4;
    data['postalSuburbCity'] = this.postalSuburbCity;
    data['postalState'] = this.postalState;
    data['postalPostCode'] = this.postalPostCode;
    data['postalCountry'] = this.postalCountry;
    data['homeStreetAddress'] = this.homeStreetAddress;
    data['homeStreetAddressLine2'] = this.homeStreetAddressLine2;
    data['homeStreetAddressLine3'] = this.homeStreetAddressLine3;
    data['homeStreetAddressLine4'] = this.homeStreetAddressLine4;
    data['homeSuburbCity'] = this.homeSuburbCity;
    data['homeState'] = this.homeState;
    data['homePostCode'] = this.homePostCode;
    data['homeCountry'] = this.homeCountry;
    data['isAgentAuthorized'] = this.isAgentAuthorized;
    data['agentSurname'] = this.agentSurname;
    data['agentGivenNames'] = this.agentGivenNames;
    data['agentCompanyName'] = this.agentCompanyName;
    data['agentMaraNumber'] = this.agentMaraNumber;
    data['agentEmailAddress'] = this.agentEmailAddress;
    data['agentDaytimeTelephoneNumber'] = this.agentDaytimeTelephoneNumber;
    data['agentFaxNumber'] = this.agentFaxNumber;
    data['agentMobileNumber'] = this.agentMobileNumber;
    data['agentStreetAddress'] = this.agentStreetAddress;
    data['agentStreetAddressLine2'] = this.agentStreetAddressLine2;
    data['agentStreetAddressLine3'] = this.agentStreetAddressLine3;
    data['agentStreetAddressLine4'] = this.agentStreetAddressLine4;
    data['agentSuburbCity'] = this.agentSuburbCity;
    data['agentState'] = this.agentState;
    data['agentPostCode'] = this.agentPostCode;
    data['agentCountry'] = this.agentCountry;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class EducationQualifications {
  int? educationId;
  int? userId;
  String? studentRegistrationNumber;
  String? qualificationName;
  String? majorField;
  String? awardingBodyName;
  String? awardingBodyCountry;
  String? campusAttended;
  String? institutionName;
  String? streetAddress1;
  String? streetAddress2;
  String? suburbCity;
  String? state;
  String? postCode;
  String? institutionCountry;
  String? normalEntryRequirement;
  String? entryBasis;
  String? courseLengthYearsOrSemesters;
  String? semesterLengthWeeksOrMonths;
  String? courseStartDate;
  String? courseEndDate;
  String? qualificationAwardedDate;
  String? studyMode;
  int? hoursPerWeek;
  int? internshipWeeks;
  int? thesisWeeks;
  int? majorProjectWeeks;
  String? activityDetails;

  EducationQualifications({
    this.educationId,
    this.userId,
    this.studentRegistrationNumber,
    this.qualificationName,
    this.majorField,
    this.awardingBodyName,
    this.awardingBodyCountry,
    this.campusAttended,
    this.institutionName,
    this.streetAddress1,
    this.streetAddress2,
    this.suburbCity,
    this.state,
    this.postCode,
    this.institutionCountry,
    this.normalEntryRequirement,
    this.entryBasis,
    this.courseLengthYearsOrSemesters,
    this.semesterLengthWeeksOrMonths,
    this.courseStartDate,
    this.courseEndDate,
    this.qualificationAwardedDate,
    this.studyMode,
    this.hoursPerWeek,
    this.internshipWeeks,
    this.thesisWeeks,
    this.majorProjectWeeks,
    this.activityDetails,
  });

  EducationQualifications.fromJson(Map<String, dynamic> json) {
    educationId = json['educationId'];
    userId = json['userId'];
    studentRegistrationNumber = json['studentRegistrationNumber'];
    qualificationName = json['qualificationName'];
    majorField = json['majorField'];
    awardingBodyName = json['awardingBodyName'];
    awardingBodyCountry = json['awardingBodyCountry'];
    campusAttended = json['campusAttended'];
    institutionName = json['institutionName'];
    streetAddress1 = json['streetAddress1'];
    streetAddress2 = json['streetAddress2'];
    suburbCity = json['suburbCity'];
    state = json['state'];
    postCode = json['postCode'];
    institutionCountry = json['institutionCountry'];
    normalEntryRequirement = json['normalEntryRequirement'];
    entryBasis = json['entryBasis'];
    courseLengthYearsOrSemesters = json['courseLengthYearsOrSemesters'];
    semesterLengthWeeksOrMonths = json['semesterLengthWeeksOrMonths'];
    courseStartDate = json['courseStartDate'];
    courseEndDate = json['courseEndDate'];
    qualificationAwardedDate = json['qualificationAwardedDate'];
    studyMode = json['studyMode'];
    hoursPerWeek = json['hoursPerWeek'];
    internshipWeeks = json['internshipWeeks'];
    thesisWeeks = json['thesisWeeks'];
    majorProjectWeeks = json['majorProjectWeeks'];
    activityDetails = json['activityDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['educationId'] = this.educationId;
    data['userId'] = this.userId;
    data['studentRegistrationNumber'] = this.studentRegistrationNumber;
    data['qualificationName'] = this.qualificationName;
    data['majorField'] = this.majorField;
    data['awardingBodyName'] = this.awardingBodyName;
    data['awardingBodyCountry'] = this.awardingBodyCountry;
    data['campusAttended'] = this.campusAttended;
    data['institutionName'] = this.institutionName;
    data['streetAddress1'] = this.streetAddress1;
    data['streetAddress2'] = this.streetAddress2;
    data['suburbCity'] = this.suburbCity;
    data['state'] = this.state;
    data['postCode'] = this.postCode;
    data['institutionCountry'] = this.institutionCountry;
    data['normalEntryRequirement'] = this.normalEntryRequirement;
    data['entryBasis'] = this.entryBasis;
    data['courseLengthYearsOrSemesters'] = this.courseLengthYearsOrSemesters;
    data['semesterLengthWeeksOrMonths'] = this.semesterLengthWeeksOrMonths;
    data['courseStartDate'] = this.courseStartDate;
    data['courseEndDate'] = this.courseEndDate;
    data['qualificationAwardedDate'] = this.qualificationAwardedDate;
    data['studyMode'] = this.studyMode;
    data['hoursPerWeek'] = this.hoursPerWeek;
    data['internshipWeeks'] = this.internshipWeeks;
    data['thesisWeeks'] = this.thesisWeeks;
    data['majorProjectWeeks'] = this.majorProjectWeeks;
    data['activityDetails'] = this.activityDetails;
    return data;
  }
}

class Educations {
  int? educationId;
  int? userId;
  int? level;
  String? dateStarted;
  String? dateFinished;
  int? numberOfYears;
  String? country;
  String? yearCompleted;
  String? certificateDetails;

  Educations({
    this.educationId,
    this.userId,
    this.level,
    this.dateStarted,
    this.dateFinished,
    this.numberOfYears,
    this.country,
    this.yearCompleted,
    this.certificateDetails,
  });

  Educations.fromJson(Map<String, dynamic> json) {
    educationId = json['educationId'];
    userId = json['userId'];
    level = json['level'];
    dateStarted = json['dateStarted'];
    dateFinished = json['dateFinished'];
    numberOfYears = json['numberOfYears'];
    country = json['country'];
    yearCompleted = json['yearCompleted'];
    certificateDetails = json['certificateDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['educationId'] = this.educationId;
    data['userId'] = this.userId;
    data['level'] = this.level;
    data['dateStarted'] = this.dateStarted;
    data['dateFinished'] = this.dateFinished;
    data['numberOfYears'] = this.numberOfYears;
    data['country'] = this.country;
    data['yearCompleted'] = this.yearCompleted;
    data['certificateDetails'] = this.certificateDetails;
    return data;
  }
}

class Employments {
  int? id;
  int? userId;
  String? businessName;
  String? alternateBusinsessname;
  String? streetaddress;
  String? suburbCity;
  String? state;
  String? postCode;
  String? country;
  String? nameofemployer;
  int? datytimePHno;
  int? faxnumber;
  int? mobileNo;
  String? emailaddress;
  String? webaddress;
  String? positionJobTitle;
  String? dateofemploymentstarted;
  bool? isapplicantemployed;
  String? dateofemploymentended;
  int? totallengthofUnpaidLeave;
  int? normalrequiredWorkinghours;
  String? task1;
  String? task2;
  String? task3;
  String? task4;
  String? task5;
  String? createdAt;
  String? updatedAt;

  Employments({
    this.id,
    this.userId,
    this.businessName,
    this.alternateBusinsessname,
    this.streetaddress,
    this.suburbCity,
    this.state,
    this.postCode,
    this.country,
    this.nameofemployer,
    this.datytimePHno,
    this.faxnumber,
    this.mobileNo,
    this.emailaddress,
    this.webaddress,
    this.positionJobTitle,
    this.dateofemploymentstarted,
    this.isapplicantemployed,
    this.dateofemploymentended,
    this.totallengthofUnpaidLeave,
    this.normalrequiredWorkinghours,
    this.task1,
    this.task2,
    this.task3,
    this.task4,
    this.task5,
    this.createdAt,
    this.updatedAt,
  });

  Employments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    businessName = json['businessName'];
    alternateBusinsessname = json['alternateBusinsessname'];
    streetaddress = json['streetaddress'];
    suburbCity = json['suburbCity'];
    state = json['state'];
    postCode = json['PostCode'];
    country = json['Country'];
    nameofemployer = json['Nameofemployer'];
    datytimePHno = json['datytimePHno'];
    faxnumber = json['faxnumber'];
    mobileNo = json['mobileNo'];
    emailaddress = json['emailaddress'];
    webaddress = json['webaddress'];
    positionJobTitle = json['positionJobTitle'];
    dateofemploymentstarted = json['dateofemploymentstarted'];
    isapplicantemployed = json['isapplicantemployed'];
    dateofemploymentended = json['dateofemploymentended'];
    totallengthofUnpaidLeave = json['totallengthofUnpaidLeave'];
    normalrequiredWorkinghours = json['normalrequiredWorkinghours'];
    task1 = json['task1'];
    task2 = json['task2'];
    task3 = json['task3'];
    task4 = json['task4'];
    task5 = json['task5'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['businessName'] = this.businessName;
    data['alternateBusinsessname'] = this.alternateBusinsessname;
    data['streetaddress'] = this.streetaddress;
    data['suburbCity'] = this.suburbCity;
    data['state'] = this.state;
    data['PostCode'] = this.postCode;
    data['Country'] = this.country;
    data['Nameofemployer'] = this.nameofemployer;
    data['datytimePHno'] = this.datytimePHno;
    data['faxnumber'] = this.faxnumber;
    data['mobileNo'] = this.mobileNo;
    data['emailaddress'] = this.emailaddress;
    data['webaddress'] = this.webaddress;
    data['positionJobTitle'] = this.positionJobTitle;
    data['dateofemploymentstarted'] = this.dateofemploymentstarted;
    data['isapplicantemployed'] = this.isapplicantemployed;
    data['dateofemploymentended'] = this.dateofemploymentended;
    data['totallengthofUnpaidLeave'] = this.totallengthofUnpaidLeave;
    data['normalrequiredWorkinghours'] = this.normalrequiredWorkinghours;
    data['task1'] = this.task1;
    data['task2'] = this.task2;
    data['task3'] = this.task3;
    data['task4'] = this.task4;
    data['task5'] = this.task5;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class UploadedDocuments {
  int? id;
  int? docCategoryid;
  int? docTypeid;
  int? userId;
  String? description;
  String? uploadfile;
  Categorys? categorys;
  Type? type;

  UploadedDocuments({
    this.id,
    this.docCategoryid,
    this.docTypeid,
    this.userId,
    this.description,
    this.uploadfile,
    this.categorys,
    this.type,
  });

  UploadedDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docCategoryid = json['docCategoryid'];
    docTypeid = json['docTypeid'];
    userId = json['userId'];
    description = json['description'];
    uploadfile = json['uploadfile'];
    categorys =
        json['category'] != null
            ? new Categorys.fromJson(json['category'])
            : null;
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['docCategoryid'] = this.docCategoryid;
    data['docTypeid'] = this.docTypeid;
    data['userId'] = this.userId;
    data['description'] = this.description;
    data['uploadfile'] = this.uploadfile;
    if (this.categorys != null) {
      data['category'] = this.categorys!.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    return data;
  }
}

class Categorys {
  int? id;
  String? documentCategory;
  dynamic subtype;
  String? createdAt;
  String? updatedAt;

  Categorys({
    this.id,
    this.documentCategory,
    this.subtype,
    this.createdAt,
    this.updatedAt,
  });

  Categorys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentCategory = json['documentCategory'];
    subtype = json['Subtype'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['documentCategory'] = this.documentCategory;
    data['Subtype'] = this.subtype;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Type {
  int? id;
  String? name;
  int? docCategoryId;

  Type({this.id, this.name, this.docCategoryId});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    docCategoryId = json['docCategory_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['docCategory_id'] = this.docCategoryId;
    return data;
  }
}

class UserVisas {
  int? id;
  int? visaId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Visa? visa;

  UserVisas({
    this.id,
    this.visaId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.visa,
  });

  UserVisas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visaId = json['visa_id'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    visa = json['Visa'] != null ? new Visa.fromJson(json['Visa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['visa_id'] = this.visaId;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.visa != null) {
      data['Visa'] = this.visa!.toJson();
    }
    return data;
  }
}

class Visa {
  int? id;
  String? visaName;
  String? category;
  int? assessmentType;
  String? createdAt;
  String? updatedAt;

  Visa({
    this.id,
    this.visaName,
    this.category,
    this.assessmentType,
    this.createdAt,
    this.updatedAt,
  });

  Visa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visaName = json['visaName'];
    category = json['category'];
    assessmentType = json['assessmentType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['visaName'] = this.visaName;
    data['category'] = this.category;
    data['assessmentType'] = this.assessmentType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class UserOccupations {
  int? id;
  int? occupationId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Occupation? occupation;

  UserOccupations({
    this.id,
    this.occupationId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.occupation,
  });

  UserOccupations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    occupationId = json['occupation_id'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    occupation =
        json['Occupation'] != null
            ? new Occupation.fromJson(json['Occupation'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['occupation_id'] = this.occupationId;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.occupation != null) {
      data['Occupation'] = this.occupation!.toJson();
    }
    return data;
  }
}

class Occupation {
  int? id;
  String? occupationName;
  String? anzscoCode;
  int? assessmentType;
  String? skillsRequirement;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Occupation({
    this.id,
    this.occupationName,
    this.anzscoCode,
    this.assessmentType,
    this.skillsRequirement,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Occupation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    occupationName = json['occupationName'];
    anzscoCode = json['anzscoCode'];
    assessmentType = json['assessmentType'];
    skillsRequirement = json['SkillsRequirement'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['occupationName'] = this.occupationName;
    data['anzscoCode'] = this.anzscoCode;
    data['assessmentType'] = this.assessmentType;
    data['SkillsRequirement'] = this.skillsRequirement;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Licences {
  int? id;
  int? userId;
  int? categoryId;
  int? countryId;
  String? nameofIssuingBody;
  String? typeOfLicence;
  String? registrationNumber;
  String? dateOfExpiry;
  String? currentStatus;
  String? currentStatusDetail;
  String? createdAt;
  String? updatedAt;
  Category? category;
  Country? country;

  Licences({
    this.id,
    this.userId,
    this.categoryId,
    this.countryId,
    this.nameofIssuingBody,
    this.typeOfLicence,
    this.registrationNumber,
    this.dateOfExpiry,
    this.currentStatus,
    this.currentStatusDetail,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.country,
  });

  Licences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    countryId = json['countryId'];
    nameofIssuingBody = json['nameofIssuingBody'];
    typeOfLicence = json['typeOfLicence'];
    registrationNumber = json['registrationNumber'];
    dateOfExpiry = json['dateOfExpiry'];
    currentStatus = json['currentStatus'];
    currentStatusDetail = json['currentStatusDetail'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category =
        json['Category'] != null
            ? new Category.fromJson(json['Category'])
            : null;
    country =
        json['Country'] != null ? new Country.fromJson(json['Country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['countryId'] = this.countryId;
    data['nameofIssuingBody'] = this.nameofIssuingBody;
    data['typeOfLicence'] = this.typeOfLicence;
    data['registrationNumber'] = this.registrationNumber;
    data['dateOfExpiry'] = this.dateOfExpiry;
    data['currentStatus'] = this.currentStatus;
    data['currentStatusDetail'] = this.currentStatusDetail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.category != null) {
      data['Category'] = this.category!.toJson();
    }
    if (this.country != null) {
      data['Country'] = this.country!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? category;
  String? createdAt;
  String? updatedAt;

  Category({this.id, this.category, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['Category'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Category'] = this.category;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Country {
  int? id;
  String? country;
  String? createdAt;
  String? updatedAt;

  Country({this.id, this.country, this.createdAt, this.updatedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class PriorityProcess {
  int? id;
  int? userId;
  String? standardApplication;
  String? priorityProcessing;
  String? otherDescription;
  String? createdAt;
  String? updatedAt;
  dynamic priorityOption;

  PriorityProcess({
    this.id,
    this.userId,
    this.standardApplication,
    this.priorityProcessing,
    this.otherDescription,
    this.createdAt,
    this.updatedAt,
    this.priorityOption,
  });

  PriorityProcess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    standardApplication = json['standardApplication'];
    priorityProcessing = json['priorityProcessing'];
    otherDescription = json['otherDescription'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    priorityOption = json['PriorityOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['standardApplication'] = this.standardApplication;
    data['priorityProcessing'] = this.priorityProcessing;
    data['otherDescription'] = this.otherDescription;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['PriorityOption'] = this.priorityOption;
    return data;
  }
}
