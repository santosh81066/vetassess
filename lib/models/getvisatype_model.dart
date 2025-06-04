class VisaTypeModel {
  int? id;
  String? visaName;
  String? category;

  VisaTypeModel({this.id, this.visaName, this.category});

  // From JSON
  VisaTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visaName = json['visaName'];
    category = json['category'];
  }

  // To JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['visaName'] = visaName;
    data['category'] = category;
    return data;
  }

  // copyWith method
  VisaTypeModel copyWith({
    int? id,
    String? visaName,
    String? category,
  }) {
    return VisaTypeModel(
      id: id ?? this.id,
      visaName: visaName ?? this.visaName,
      category: category ?? this.category,
    );
  }

  // initial factory constructor
  factory VisaTypeModel.initial() {
    return VisaTypeModel(
      id: 0,
      visaName: '',
      category: '',
    );
  }
}
class VisaTypeState {
  final List<VisaTypeModel> visaTypes;
  final bool isLoading;
  final String? error;
  final VisaTypeModel? selectedVisaType;
  final String? currentCategory;

  VisaTypeState({
    this.visaTypes = const [],
    this.isLoading = false,
    this.error,
    this.selectedVisaType,
    this.currentCategory,
  });

  VisaTypeState copyWith({
    List<VisaTypeModel>? visaTypes,
    bool? isLoading,
    String? error,
    VisaTypeModel? selectedVisaType,
    String? currentCategory,
  }) {
    return VisaTypeState(
      visaTypes: visaTypes ?? this.visaTypes,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedVisaType: selectedVisaType ?? this.selectedVisaType,
      currentCategory: currentCategory ?? this.currentCategory,
    );
  }
}