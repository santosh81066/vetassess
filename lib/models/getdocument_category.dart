class DocumentCategory {
  List<Data>? data;

  DocumentCategory({this.data});

  DocumentCategory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    if (this.data != null) {
      jsonData['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return jsonData;
  }

  DocumentCategory copyWith({List<Data>? data}) {
    return DocumentCategory(
      data: data ?? this.data,
    );
  }

  factory DocumentCategory.initial() {
    return DocumentCategory(data: []);
  }
}

class Data {
  int? id;
  String? documentCategory;
  int? subtype;
  String? createdAt;
  String? updatedAt;
  ParentCategory? parentCategory;

  Data({
    this.id,
    this.documentCategory,
    this.subtype,
    this.createdAt,
    this.updatedAt,
    this.parentCategory,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentCategory = json['documentCategory'];
    subtype = json['Subtype'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    parentCategory = json['ParentCategory'] != null
        ? ParentCategory.fromJson(json['ParentCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = this.id;
    jsonData['documentCategory'] = this.documentCategory;
    jsonData['Subtype'] = this.subtype;
    jsonData['createdAt'] = this.createdAt;
    jsonData['updatedAt'] = this.updatedAt;
    if (this.parentCategory != null) {
      jsonData['ParentCategory'] = this.parentCategory!.toJson();
    }
    return jsonData;
  }

  Data copyWith({
    int? id,
    String? documentCategory,
    int? subtype,
    String? createdAt,
    String? updatedAt,
    ParentCategory? parentCategory,
  }) {
    return Data(
      id: id ?? this.id,
      documentCategory: documentCategory ?? this.documentCategory,
      subtype: subtype ?? this.subtype,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      parentCategory: parentCategory ?? this.parentCategory,
    );
  }

  factory Data.initial() {
    return Data(
      id: 0,
      documentCategory: '',
      subtype: 0,
      createdAt: '',
      updatedAt: '',
      parentCategory: ParentCategory.initial(),
    );
  }
}

class ParentCategory {
  int? id;
  String? documentCategory;

  ParentCategory({this.id, this.documentCategory});

  ParentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentCategory = json['documentCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = this.id;
    jsonData['documentCategory'] = this.documentCategory;
    return jsonData;
  }

  ParentCategory copyWith({
    int? id,
    String? documentCategory,
  }) {
    return ParentCategory(
      id: id ?? this.id,
      documentCategory: documentCategory ?? this.documentCategory,
    );
  }

  factory ParentCategory.initial() {
    return ParentCategory(
      id: 0,
      documentCategory: '',
    );
  }
}
