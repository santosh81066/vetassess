class TertiaryEducationState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final Map<String, dynamic>? responseData;

  const TertiaryEducationState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.responseData,
  });

  TertiaryEducationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Map<String, dynamic>? responseData,
  }) {
    return TertiaryEducationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      responseData: responseData ?? this.responseData,
    );
  }
}