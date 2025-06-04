// models/priority_subtype_model.dart

class PrioritySubtype {
  final int id;
  final String prioritySubtype;

  PrioritySubtype({required this.id, required this.prioritySubtype});

  factory PrioritySubtype.fromJson(Map<String, dynamic> json) {
    return PrioritySubtype(
      id: json['id'] as int,
      prioritySubtype: json['prioritySubtype'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'prioritySubtype': prioritySubtype};
  }
}

class PrioritySubtypeResponse {
  final String message;
  final List<PrioritySubtype> data;

  PrioritySubtypeResponse({required this.message, required this.data});

  factory PrioritySubtypeResponse.fromJson(Map<String, dynamic> json) {
    return PrioritySubtypeResponse(
      message: json['message'] as String,
      data:
          (json['data'] as List<dynamic>)
              .map(
                (item) =>
                    PrioritySubtype.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
