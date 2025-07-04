class UserDocDownload {
  String? message;
  List<Documents>? documents;

  UserDocDownload({this.message, this.documents});

  UserDocDownload.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // ✅ copyWith method
  UserDocDownload copyWith({
    String? message,
    List<Documents>? documents,
  }) {
    return UserDocDownload(
      message: message ?? this.message,
      documents: documents ?? this.documents,
    );
  }

  // ✅ initial method
  factory UserDocDownload.initial() {
    return UserDocDownload(
      message: '',
      documents: [],
    );
  }
}

class Documents {
  int? id;
  int? userId;
  DocCategory? docCategory;
  DocCategory? docType;
  String? description;
  String? filename;
  bool? exists;
  String? filePath;

  Documents({
    this.id,
    this.userId,
    this.docCategory,
    this.docType,
    this.description,
    this.filename,
    this.exists,
    this.filePath,
  });

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    docCategory = json['docCategory'] != null
        ? DocCategory.fromJson(json['docCategory'])
        : null;
    docType = json['docType'] != null
        ? DocCategory.fromJson(json['docType'])
        : null;
    description = json['description'];
    filename = json['filename'];
    exists = json['exists'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userId'] = userId;
    if (docCategory != null) {
      data['docCategory'] = docCategory!.toJson();
    }
    if (docType != null) {
      data['docType'] = docType!.toJson();
    }
    data['description'] = description;
    data['filename'] = filename;
    data['exists'] = exists;
    data['filePath'] = filePath;
    return data;
  }

  // ✅ copyWith method
  Documents copyWith({
    int? id,
    int? userId,
    DocCategory? docCategory,
    DocCategory? docType,
    String? description,
    String? filename,
    bool? exists,
    String? filePath,
  }) {
    return Documents(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      docCategory: docCategory ?? this.docCategory,
      docType: docType ?? this.docType,
      description: description ?? this.description,
      filename: filename ?? this.filename,
      exists: exists ?? this.exists,
      filePath: filePath ?? this.filePath,
    );
  }

  // ✅ initial method
  factory Documents.initial() {
    return Documents(
      id: 0,
      userId: 0,
      docCategory: DocCategory.initial(),
      docType: DocCategory.initial(),
      description: '',
      filename: '',
      exists: false,
      filePath: '',
    );
  }
}

class DocCategory {
  int? id;
  String? name;

  DocCategory({this.id, this.name});

  DocCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  // ✅ copyWith method
  DocCategory copyWith({
    int? id,
    String? name,
  }) {
    return DocCategory(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  // ✅ initial method
  factory DocCategory.initial() {
    return DocCategory(
      id: 0,
      name: '',
    );
  }
}
