class DocumentType {
  List<Data>? data;

  DocumentType({this.data});

  // CopyWith method
  DocumentType copyWith({List<Data>? data}) {
    return DocumentType(
      data: data ?? this.data,
    );
  }

  // Initial factory constructor
  factory DocumentType.initial() {
    return DocumentType(
      data: [],
    );
  }

  DocumentType.fromJson(Map<String, dynamic> json) {
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
}

class Data {
  int? id;
  String? name;
  int? docDocumentTypeId;

  Data({this.id, this.name, this.docDocumentTypeId});

  // CopyWith method
  Data copyWith({
    int? id,
    String? name,
    int? docDocumentTypeId,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      docDocumentTypeId: docDocumentTypeId ?? this.docDocumentTypeId,
    );
  }

  // Initial factory constructor
  factory Data.initial() {
    return Data(
      id: 0,
      name: '',
      docDocumentTypeId: 0,
    );
  }

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    docDocumentTypeId = json['docDocumentType_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['docDocumentType_id'] = this.docDocumentTypeId;
    return data;
  }
}
