class DocumentType {
  List<Data>? data;

  DocumentType({this.data});

  DocumentType.fromJson(Map<String, dynamic> json) {
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

  DocumentType copyWith({List<Data>? data}) {
    return DocumentType(
      data: data ?? this.data,
    );
  }

  factory DocumentType.initial() {
    return DocumentType(data: []);
  }
}

class Data {
  int? id;
  String? name;
  int? docCategoryId;

  Data({this.id, this.name, this.docCategoryId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    docCategoryId = json['docCategory_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    jsonData['id'] = this.id;
    jsonData['name'] = this.name;
    jsonData['docCategory_id'] = this.docCategoryId;
    return jsonData;
  }

  Data copyWith({
    int? id,
    String? name,
    int? docCategoryId,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      docCategoryId: docCategoryId ?? this.docCategoryId,
    );
  }

  factory Data.initial() {
    return Data(
      id: 0,
      name: '',
      docCategoryId: 0,
    );
  }
}
