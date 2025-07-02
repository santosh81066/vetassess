// lib/models/visa_occupation_models.dart (Fixed version)

class VisaTypeRequest {
  final String category;
  final int assessmentType;
  final List<String> visaNames;

  VisaTypeRequest({
    required this.category,
    required this.assessmentType,
    required this.visaNames,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'assessmentType': assessmentType,
      'visaNames': visaNames,
    };
  }
}

class VisaTypeResult {
  final String visaName;
  final String status;
  final int assessmentType;

  VisaTypeResult({
    required this.visaName,
    required this.status,
    required this.assessmentType,
  });

  factory VisaTypeResult.fromJson(Map<String, dynamic> json) {
    return VisaTypeResult(
      visaName: json['visaName'] ?? '',
      status: json['status'] ?? '',
      assessmentType: _parseToInt(json['assessmentType']) ?? 0,
    );
  }

  // Helper method to safely parse values to int
  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value);
    }
    if (value is double) return value.toInt();
    return null;
  }
}

class VisaTypeResponse {
  final String message;
  final List<VisaTypeResult> results;

  VisaTypeResponse({
    required this.message,
    required this.results,
  });

  factory VisaTypeResponse.fromJson(Map<String, dynamic> json) {
    return VisaTypeResponse(
      message: json['message'] ?? '',
      results: (json['results'] as List<dynamic>?)
          ?.map((item) => VisaTypeResult.fromJson(item))
          .toList() ?? [],
    );
  }
}

// FIXED: Updated VisaType class with better type handling
class VisaType {
  final String? id;
  final String name;
  final String category;
  final int assessmentType; // Changed from int? to int with default
  final String status;
  final bool isActive;
  final DateTime? createdAt;

  VisaType({
    this.id,
    required this.name,
    required this.category,
    this.assessmentType = 0, // Default value instead of required
    required this.status,
    this.isActive = true,
    this.createdAt,
  });

  // FIXED: Enhanced fromJson with better field name handling
  factory VisaType.fromJson(Map<String, dynamic> json) {
    return VisaType(
      id: json['id']?.toString(),
      name: json['name'] ?? json['Name'] ?? '',
      category: json['category'] ?? json['Category'] ?? '',
      assessmentType: _parseToInt(json['assessmentType'] ??
          json['AssessmentType'] ??
          json['assessment_type']) ?? 0,
      status: json['status'] ?? json['Status'] ?? 'active',
      isActive: _parseToBool(json['isActive'] ??
          json['IsActive'] ??
          json['is_active']) ?? true,
      createdAt: _parseToDateTime(json['createdAt'] ??
          json['CreatedAt'] ??
          json['created_at']),
    );
  }

  factory VisaType.fromResult(VisaTypeResult result, String category) {
    return VisaType(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: result.visaName,
      category: category,
      assessmentType: result.assessmentType,
      status: result.status,
      isActive: result.status == 'created',
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'assessmentType': assessmentType,
      'status': status,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  VisaType copyWith({
    String? id,
    String? name,
    String? category,
    int? assessmentType,
    String? status,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return VisaType(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      assessmentType: assessmentType ?? this.assessmentType,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Helper methods for type conversion
  static int? _parseToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value);
    }
    if (value is double) return value.toInt();
    return null;
  }

  static bool? _parseToBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }
    if (value is int) return value == 1;
    return null;
  }

  static DateTime? _parseToDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
// FIXED: Updated OccupationItem with correct field names for PHP backend
class OccupationItem {
  final String occupationName;
  final String anzscoCode;
  final String skillsRequirement;

  OccupationItem({
    required this.occupationName,
    required this.anzscoCode,
    required this.skillsRequirement,
  });

  // FIXED: Updated toJson() to match PHP backend expectations
  Map<String, dynamic> toJson() {
    return {
      'occupationName': occupationName,     // PascalCase to match database
      'anzscoCode': anzscoCode,             // PascalCase to match database
      'SkillsRequirement': skillsRequirement, // PascalCase to match database
    };
  }

  factory OccupationItem.fromJson(Map<String, dynamic> json) {
    return OccupationItem(
      occupationName: json['occupationName'] ?? json['occupationName'] ?? '',
      anzscoCode: json['AnzscoCode'] ?? json['anzscoCode'] ?? '',
      skillsRequirement: json['SkillsRequirement'] ?? json['skillsRequirement'] ?? '',
    );
  }
}

class OccupationRequest {
  final List<OccupationItem> occupations;

  OccupationRequest({
    required this.occupations,
  });

  Map<String, dynamic> toJson() {
    return {
      'occupations': occupations.map((e) => e.toJson()).toList(),
    };
  }
}

class OccupationResponse {
  final String message;

  OccupationResponse({
    required this.message,
  });

  factory OccupationResponse.fromJson(Map<String, dynamic> json) {
    return OccupationResponse(
      message: json['message'] ?? '',
    );
  }
}

// For displaying occupations in the UI
class Occupation {
  final String? id;
  final String occupationName;
  final String anzscoCode;
  final String skillsRequirement;
  final bool isActive;
  final DateTime? createdAt;

  Occupation({
    this.id,
    required this.occupationName,
    required this.anzscoCode,
    required this.skillsRequirement,
    this.isActive = true,
    this.createdAt,
  });

  factory Occupation.fromItem(item) {
    return Occupation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      occupationName: item.occupationName,
      anzscoCode: item.anzscoCode,
      skillsRequirement: item.skillsRequirement,
      isActive: true,
      createdAt: DateTime.now(),
    );
  }

  // FIXED: Updated fromJson to handle both PascalCase and camelCase
  factory Occupation.fromJson(Map<String, dynamic> json) {
    return Occupation(
      id: json['id']?.toString(),
      occupationName: json['occupationName'] ?? json['occupationName'] ?? '',
      anzscoCode: json['AnzscoCode'] ?? json['anzscoCode'] ?? '',
      skillsRequirement: json['SkillsRequirement'] ?? json['skillsRequirement'] ?? '',
      isActive: json['IsActive'] ?? json['isActive'] ?? true,
      createdAt: json['CreatedAt'] != null || json['createdAt'] != null
          ? DateTime.parse(json['CreatedAt'] ?? json['createdAt'])
          : null,
    );
  }

  OccupationItem toItem() {
    return OccupationItem(
      occupationName: occupationName,
      anzscoCode: anzscoCode,
      skillsRequirement: skillsRequirement,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'occupationName': occupationName,
      'AnzscoCode': anzscoCode,
      'SkillsRequirement': skillsRequirement,
      'IsActive': isActive,
      'CreatedAt': createdAt?.toIso8601String(),
    };
  }

  Occupation copyWith({
    String? id,
    String? occupationName,
    String? anzscoCode,
    String? skillsRequirement,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Occupation(
      id: id ?? this.id,
      occupationName: occupationName ?? this.occupationName,
      anzscoCode: anzscoCode ?? this.anzscoCode,
      skillsRequirement: skillsRequirement ?? this.skillsRequirement,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}