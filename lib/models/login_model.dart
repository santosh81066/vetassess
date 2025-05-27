// models/login_model.dart
class LoginRequest {
  final String email;
  final String password;
  final String captchaInput;
  final String captchaOriginal;
  final String role;

  LoginRequest({
    required this.email,
    required this.password,
    required this.captchaInput,
    required this.captchaOriginal,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'captchaInput': captchaInput,
      'captchaOriginal': captchaOriginal,
      'role': role,
    };
  }
}

class LoginResponse {
  final String message;
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}

class CaptchaResponse {
  final String captcha;

  CaptchaResponse({required this.captcha});

  factory CaptchaResponse.fromJson(Map<String, dynamic> json) {
    return CaptchaResponse(captcha: json['captcha'] ?? '');
  }
}

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final LoginResponse? response;
  final String? captcha;
  final bool isLoadingCaptcha;

  LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.response,
    this.captcha,
    this.isLoadingCaptcha = false,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    LoginResponse? response,
    String? captcha,
    bool? isLoadingCaptcha,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      response: response ?? this.response,
      captcha: captcha ?? this.captcha,
      isLoadingCaptcha: isLoadingCaptcha ?? this.isLoadingCaptcha,
    );
  }
}
