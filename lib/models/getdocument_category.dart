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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// copyWith method
  DocumentCategory copyWith({List<Data>? data}) {
    return DocumentCategory(
      data: data ?? this.data,
    );
  }

  /// initial factory method
  factory DocumentCategory.initial() {
    return DocumentCategory(data: []);
  }
}
class Data {
  int? id;
  String? documentCategory;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.documentCategory, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    documentCategory = json['documentCategory'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['documentCategory'] = this.documentCategory;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  /// copyWith method
  Data copyWith({
    int? id,
    String? documentCategory,
    String? createdAt,
    String? updatedAt,
  }) {
    return Data(
      id: id ?? this.id,
      documentCategory: documentCategory ?? this.documentCategory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// initial factory method
  factory Data.initial() {
    return Data(
      id: 0,
      documentCategory: '',
      createdAt: '',
      updatedAt: '',
    );
  }
}
