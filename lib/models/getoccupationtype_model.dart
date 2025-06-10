class OccupationTypeModel {
  List<Occupations>? occupations;

  OccupationTypeModel({this.occupations});

  // Initial constructor
  factory OccupationTypeModel.initial() {
    return OccupationTypeModel(occupations: []);
  }

  // copyWith method
  OccupationTypeModel copyWith({List<Occupations>? occupations}) {
    return OccupationTypeModel(
      occupations: occupations ?? this.occupations,
    );
  }

  OccupationTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['occupations'] != null) {
      occupations = <Occupations>[];
      json['occupations'].forEach((v) {
        occupations!.add(Occupations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (occupations != null) {
      data['occupations'] = occupations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Occupations {
  int? id;
  String? occupationName;
  String? anzscoCode;
  String? skillsRequirement;

  Occupations({
    this.id,
    this.occupationName,
    this.anzscoCode,
    this.skillsRequirement,
  });

  // Initial constructor
  factory Occupations.initial() {
    return Occupations(
      id: 0,
      occupationName: '',
      anzscoCode: '',
      skillsRequirement: '',
    );
  }

  // copyWith method
  Occupations copyWith({
    int? id,
    String? occupationName,
    String? anzscoCode,
    String? skillsRequirement,
  }) {
    return Occupations(
      id: id ?? this.id,
      occupationName: occupationName ?? this.occupationName,
      anzscoCode: anzscoCode ?? this.anzscoCode,
      skillsRequirement: skillsRequirement ?? this.skillsRequirement,
    );
  }

  Occupations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    occupationName = json['occupationName'];
    anzscoCode = json['anzscoCode'];
    skillsRequirement = json['SkillsRequirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['occupationName'] = occupationName;
    data['anzscoCode'] = anzscoCode;
    data['SkillsRequirement'] = skillsRequirement;
    return data;
  }
}
