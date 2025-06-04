// models/priority_process_model.dart
class PriorityProcessRequest {
  final String? standardApplication;
  final List<int>? prioritySubtypeId;
  final String? otherDescription;

  PriorityProcessRequest({
    this.standardApplication,
    this.prioritySubtypeId,
    this.otherDescription,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (standardApplication != null) {
      data['standardApplication'] = standardApplication;
    }

    if (prioritySubtypeId != null) {
      data['prioritySubtypeId'] = prioritySubtypeId;
    }

    if (otherDescription != null && otherDescription!.isNotEmpty) {
      data['otherDescription'] = otherDescription;
    }

    return data;
  }
}

class PriorityProcessData {
  final int id;
  final int userId;
  final String? standardApplication;
  final String? priorityProcessing;
  final String? otherDescription;
  final String updatedAt;
  final String createdAt;

  PriorityProcessData({
    required this.id,
    required this.userId,
    this.standardApplication,
    this.priorityProcessing,
    this.otherDescription,
    required this.updatedAt,
    required this.createdAt,
  });

  factory PriorityProcessData.fromJson(Map<String, dynamic> json) {
    return PriorityProcessData(
      id: json['id'],
      userId: json['userId'],
      standardApplication: json['standardApplication'],
      priorityProcessing: json['priorityProcessing'],
      otherDescription: json['otherDescription'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }
}

class PriorityProcessResponse {
  final String message;
  final PriorityProcessData data;

  PriorityProcessResponse({required this.message, required this.data});

  factory PriorityProcessResponse.fromJson(Map<String, dynamic> json) {
    return PriorityProcessResponse(
      message: json['message'],
      data: PriorityProcessData.fromJson(json['data']),
    );
  }
}
