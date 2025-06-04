class OccupationTypeModel {
  List<Occupations>? occupations;

  OccupationTypeModel({this.occupations});

  OccupationTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['occupations'] != null) {
      occupations = <Occupations>[];
      json['occupations'].forEach((v) {
        occupations!.add(Occupations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (occupations != null) {
      data['occupations'] = occupations!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// `copyWith` method
  OccupationTypeModel copyWith({List<Occupations>? occupations}) {
    return OccupationTypeModel(
      occupations: occupations ?? this.occupations,
    );
  }

  /// `initial` method
  static OccupationTypeModel initial() {
    return OccupationTypeModel(occupations: []);
  }
}

class Occupations {
  String? occupationName;
  String? anzscoCode;
  String? skillsRequirement;

  Occupations({this.occupationName, this.anzscoCode, this.skillsRequirement});

  Occupations.fromJson(Map<String, dynamic> json) {
    occupationName = json['occupationName'];
    anzscoCode = json['anzscoCode'];
    skillsRequirement = json['SkillsRequirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['occupationName'] = occupationName;
    data['anzscoCode'] = anzscoCode;
    data['SkillsRequirement'] = skillsRequirement;
    return data;
  }

  /// `copyWith` method
  Occupations copyWith({
    String? occupationName,
    String? anzscoCode,
    String? skillsRequirement,
  }) {
    return Occupations(
      occupationName: occupationName ?? this.occupationName,
      anzscoCode: anzscoCode ?? this.anzscoCode,
      skillsRequirement: skillsRequirement ?? this.skillsRequirement,
    );
  }

  /// `initial` method
  static Occupations initial() {
    return Occupations(
      occupationName: '',
      anzscoCode: '',
      skillsRequirement: '',
    );
  }
}
