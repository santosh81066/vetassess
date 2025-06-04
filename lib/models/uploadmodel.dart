
// UploadModel class
class UploadModel {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? uploadResponse;
  final bool isSuccess;

  UploadModel({
    required this.isLoading,
    this.error,
    this.uploadResponse,
    required this.isSuccess,
  });

  factory UploadModel.initial() {
    return UploadModel(
      isLoading: false,
      error: null,
      uploadResponse: null,
      isSuccess: false,
    );
  }

  UploadModel copyWith({
    bool? isLoading,
    String? error,
    Map<String, dynamic>? uploadResponse,
    bool? isSuccess,
  }) {
    return UploadModel(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      uploadResponse: uploadResponse ?? this.uploadResponse,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}