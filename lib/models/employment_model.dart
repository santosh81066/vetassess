class EmploymentModel {
  final String businessName;
  final String alternateBusinsessname;
  final String streetaddress;
  final String suburbCity;
  final String state;
  final String postCode;
  final String country;
  final String nameofemployer;
  final String daytimePHno;
  final String faxnumber;
  final String mobileNo;
  final String emailaddress;
  final String webaddress;
  final String positionJobTitle;
  final String dateofemploymentstarted;
  final bool isapplicantemployed;
  final String dateofemploymentended;
  final String totallengthofUnpaidLeave;
  final String normalrequiredWorkinghours;
  final List<String> tasks;
  final bool isLoading;
  final String? error;

  EmploymentModel({
    required this.businessName,
    required this.alternateBusinsessname,
    required this.streetaddress,
    required this.suburbCity,
    required this.state,
    required this.postCode,
    required this.country,
    required this.nameofemployer,
    required this.daytimePHno,
    required this.faxnumber,
    required this.mobileNo,
    required this.emailaddress,
    required this.webaddress,
    required this.positionJobTitle,
    required this.dateofemploymentstarted,
    required this.isapplicantemployed,
    required this.dateofemploymentended,
    required this.totallengthofUnpaidLeave,
    required this.normalrequiredWorkinghours,
    required this.tasks,
    this.isLoading = false,
    this.error,
  });

  factory EmploymentModel.initial() {
    return EmploymentModel(
      businessName: '',
      alternateBusinsessname: '',
      streetaddress: '',
      suburbCity: '',
      state: '',
      postCode: '',
      country: '',
      nameofemployer: '',
      daytimePHno: '',
      faxnumber: '',
      mobileNo: '',
      emailaddress: '',
      webaddress: '',
      positionJobTitle: '',
      dateofemploymentstarted: '',
      isapplicantemployed: false,
      dateofemploymentended: '',
      totallengthofUnpaidLeave: '',
      normalrequiredWorkinghours: '',
      tasks: ['', '', '', '', ''], // Initialize with 5 empty tasks
      isLoading: false,
      error: null,
    );
  }

  EmploymentModel copyWith({
    String? businessName,
    String? alternateBusinsessname,
    String? streetaddress,
    String? suburbCity,
    String? state,
    String? postCode,
    String? country,
    String? nameofemployer,
    String? daytimePHno,
    String? faxnumber,
    String? mobileNo,
    String? emailaddress,
    String? webaddress,
    String? positionJobTitle,
    String? dateofemploymentstarted,
    bool? isapplicantemployed,
    String? dateofemploymentended,
    String? totallengthofUnpaidLeave,
    String? normalrequiredWorkinghours,
    List<String>? tasks,
    bool? isLoading,
    String? error,
  }) {
    return EmploymentModel(
      businessName: businessName ?? this.businessName,
      alternateBusinsessname: alternateBusinsessname ?? this.alternateBusinsessname,
      streetaddress: streetaddress ?? this.streetaddress,
      suburbCity: suburbCity ?? this.suburbCity,
      state: state ?? this.state,
      postCode: postCode ?? this.postCode,
      country: country ?? this.country,
      nameofemployer: nameofemployer ?? this.nameofemployer,
      daytimePHno: daytimePHno ?? this.daytimePHno,
      faxnumber: faxnumber ?? this.faxnumber,
      mobileNo: mobileNo ?? this.mobileNo,
      emailaddress: emailaddress ?? this.emailaddress,
      webaddress: webaddress ?? this.webaddress,
      positionJobTitle: positionJobTitle ?? this.positionJobTitle,
      dateofemploymentstarted: dateofemploymentstarted ?? this.dateofemploymentstarted,
      isapplicantemployed: isapplicantemployed ?? this.isapplicantemployed,
      dateofemploymentended: dateofemploymentended ?? this.dateofemploymentended,
      totallengthofUnpaidLeave: totallengthofUnpaidLeave ?? this.totallengthofUnpaidLeave,
      normalrequiredWorkinghours: normalrequiredWorkinghours ?? this.normalrequiredWorkinghours,
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'businessName': businessName,
      'alternateBusinsessname': alternateBusinsessname,
      'streetaddress': streetaddress,
      'suburbCity': suburbCity,
      'state': state,
      'PostCode': postCode,
      'Country': country,
      'Nameofemployer': nameofemployer,
      'datytimePHno': int.tryParse(daytimePHno) ?? 0,
      'faxnumber': int.tryParse(faxnumber) ?? 0,
      'mobileNo': int.tryParse(mobileNo) ?? 0,
      'emailaddress': emailaddress,
      'webaddress': webaddress,
      'positionJobTitle': positionJobTitle,
      'dateofemploymentstarted': dateofemploymentstarted,
      'isapplicantemployed': isapplicantemployed,
      'dateofemploymentended': dateofemploymentended,
      'totallengthofUnpaidLeave': int.tryParse(totallengthofUnpaidLeave) ?? 0,
      'normalrequiredWorkinghours': int.tryParse(normalrequiredWorkinghours) ?? 0,
    };

    // Add tasks dynamically
    for (int i = 0; i < tasks.length; i++) {
      if (i < 5) {
        json['task${i + 1}'] = tasks[i];
      }
    }

    return json;
  }
}