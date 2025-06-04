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
  String? message;
  int? userId;
  String? accessToken;
  String? refreshToken;
  String? role; // Add role field to response

  LoginResponse({
    this.message, 
    this.userId, 
    this.accessToken, 
    this.refreshToken,
    this.role, // Add role parameter
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    role = json['role']; // Parse role from response
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['role'] = this.role; // Include role in JSON
    return data;
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
  final String? userRole; // Add user role to state

  LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.response,
    this.captcha,
    this.isLoadingCaptcha = false,
    this.userRole, // Add userRole parameter
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    LoginResponse? response,
    String? captcha,
    bool? isLoadingCaptcha,
    String? userRole, // Add userRole to copyWith
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      response: response ?? this.response,
      captcha: captcha ?? this.captcha,
      isLoadingCaptcha: isLoadingCaptcha ?? this.isLoadingCaptcha,
      userRole: userRole ?? this.userRole, // Include userRole in copyWith
    );
  }
}