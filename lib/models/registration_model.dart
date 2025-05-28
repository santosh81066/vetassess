// Simple model classes without code generation
class SignupRequest {
  final String givenNames;
  final String surname;
  final String dateOfBirth;
  final String email;
  final String confirmEmail;
  final String password;
  final String confirmPassword;
  final bool isAgreedToReceiveNewsChecked;
  final String captchaInput;
  final String captchaOriginal;

  SignupRequest({
    required this.givenNames,
    required this.surname,
    required this.dateOfBirth,
    required this.email,
    required this.confirmEmail,
    required this.password,
    required this.confirmPassword,
    this.isAgreedToReceiveNewsChecked = false,
    required this.captchaInput,
    required this.captchaOriginal,
  });

  Map<String, dynamic> toJson() {
    return {
      'givenNames': givenNames,
      'surname': surname,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'confirmEmail': confirmEmail,
      'password': password,
      'confirmPassword': confirmPassword,
      'isAgreedToReceiveNewsChecked': isAgreedToReceiveNewsChecked,
      'captchaInput': captchaInput,
      'captchaOriginal': captchaOriginal,
    };
  }
}

class SignupResponse {
  final String? message;
  final String? token;
  final Map<String, dynamic>? user;

  SignupResponse({this.message, this.token, this.user});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      message: json['message'],
      token: json['token'],
      user: json['user'],
    );
  }
}

class SignupState {
  final bool isLoading;
  final String errorMessage;
  final SignupResponse? response;
  final String captchaText;

  SignupState({
    this.isLoading = false,
    this.errorMessage = '',
    this.response,
    this.captchaText = 'ABC123',
  });

  SignupState copyWith({
    bool? isLoading,
    String? errorMessage,
    SignupResponse? response,
    String? captchaText,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      response: response ?? this.response,
      captchaText: captchaText ?? this.captchaText,
    );
  }
}

// Form validation class
class SignupFormData {
  String givenNames = '';
  String surname = '';
  String dateOfBirth = '';
  String email = '';
  String confirmEmail = '';
  String password = '';
  String confirmPassword = '';
  bool isAgreedToReceiveNews = false;
  String captchaInput = '';
  bool isPrivacyPolicyAccepted = false;

  bool get isValid {
    return givenNames.isNotEmpty &&
        surname.isNotEmpty &&
        dateOfBirth.isNotEmpty &&
        email.isNotEmpty &&
        confirmEmail.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        captchaInput.isNotEmpty &&
        isPrivacyPolicyAccepted &&
        email == confirmEmail &&
        password == confirmPassword &&
        _isValidEmail(email) &&
        _isValidDateFormat(dateOfBirth);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  bool _isValidDateFormat(String date) {
    try {
      final parts = date.split('/');
      if (parts.length != 3) return false;
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return day >= 1 && day <= 31 && month >= 1 && month <= 12 && year >= 1900;
    } catch (e) {
      return false;
    }
  }

  String? validateField(
    String fieldName,
    String value, [
    String? compareValue,
  ]) {
    switch (fieldName) {
      case 'givenNames':
        return value.isEmpty ? 'Given names are required' : null;
      case 'surname':
        return value.isEmpty ? 'Surname is required' : null;
      case 'dateOfBirth':
        if (value.isEmpty) return 'Date of birth is required';
        if (!_isValidDateFormat(value)) return 'Please use dd/mm/yyyy format';
        return null;
      case 'email':
        if (value.isEmpty) return 'Email is required';
        if (!_isValidEmail(value)) return 'Please enter a valid email';
        return null;
      case 'confirmEmail':
        if (value.isEmpty) return 'Please confirm your email';
        if (compareValue != null && value != compareValue)
          return 'Emails do not match';
        return null;
      case 'password':
        if (value.isEmpty) return 'Password is required';
        if (value.length < 6) return 'Password must be at least 6 characters';
        return null;
      case 'confirmPassword':
        if (value.isEmpty) return 'Please confirm your password';
        if (compareValue != null && value != compareValue) {
          return 'Passwords do not match';
        }
        return null;
      case 'captcha':
        return value.isEmpty ? 'Please enter the captcha text' : null;
      default:
        return null;
    }
  }
}
