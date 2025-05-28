import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/registration_model.dart';
import '../providers/registration_provider.dart';
import '../widgets/login_page_layout.dart';

class VetassessRegistrationForm extends ConsumerStatefulWidget {
  const VetassessRegistrationForm({super.key});

  @override
  ConsumerState<VetassessRegistrationForm> createState() =>
      _VetassessRegistrationFormState();
}

class _VetassessRegistrationFormState
    extends ConsumerState<VetassessRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String> _errors = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final fields = [
      'givenNames',
      'surname',
      'dateOfBirth',
      'email',
      'confirmEmail',
      'password',
      'confirmPassword',
      'captcha',
    ];

    for (String field in fields) {
      _controllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _updateFormData() {
    final formData = ref.read(signupFormProvider.notifier);
    formData.update((state) {
      state.givenNames = _controllers['givenNames']?.text ?? '';
      state.surname = _controllers['surname']?.text ?? '';
      state.dateOfBirth = _controllers['dateOfBirth']?.text ?? '';
      state.email = _controllers['email']?.text ?? '';
      state.confirmEmail = _controllers['confirmEmail']?.text ?? '';
      state.password = _controllers['password']?.text ?? '';
      state.confirmPassword = _controllers['confirmPassword']?.text ?? '';
      state.captchaInput = _controllers['captcha']?.text ?? '';
      return state;
    });
  }

  void _validateField(String fieldName, String value) {
    final formData = ref.read(signupFormProvider);
    String? error;

    // For confirmEmail and confirmPassword, pass the original value for comparison
    if (fieldName == 'confirmEmail') {
      error = formData.validateField(
        fieldName,
        value,
        _controllers['email']?.text,
      );
    } else if (fieldName == 'confirmPassword') {
      error = formData.validateField(
        fieldName,
        value,
        _controllers['password']?.text,
      );
    } else {
      error = formData.validateField(fieldName, value);
    }

    setState(() {
      if (error != null) {
        _errors[fieldName] = error;
      } else {
        _errors.remove(fieldName);
      }
    });
  }

  Future<void> _handleSignup() async {
    _updateFormData();
    final formData = ref.read(signupFormProvider);

    // Validate all fields
    setState(() {
      _errors.clear();
    });

    bool hasErrors = false;
    _controllers.forEach((fieldName, controller) {
      if (fieldName != 'captcha') {
        String? error;

        // Handle confirmation fields
        if (fieldName == 'confirmEmail') {
          error = formData.validateField(
            fieldName,
            controller.text,
            _controllers['email']?.text,
          );
        } else if (fieldName == 'confirmPassword') {
          error = formData.validateField(
            fieldName,
            controller.text,
            _controllers['password']?.text,
          );
        } else {
          error = formData.validateField(fieldName, controller.text);
        }

        if (error != null) {
          _errors[fieldName] = error;
          hasErrors = true;
        }
      }
    });

    // Validate captcha
    final captchaError = formData.validateField(
      'captcha',
      _controllers['captcha']?.text ?? '',
    );
    if (captchaError != null) {
      _errors['captcha'] = captchaError;
      hasErrors = true;
    }

    // Check if privacy policy is accepted
    if (!formData.isPrivacyPolicyAccepted) {
      _errors['privacyPolicy'] = 'You must accept the Privacy Policy';
      hasErrors = true;
    }

    if (hasErrors) {
      setState(() {});
      return;
    }

    // Submit the form
    await ref.read(signupProvider.notifier).signup(formData);
  }

  @override
  Widget build(BuildContext context) {
    final signupState = ref.watch(signupProvider);
    final formData = ref.watch(signupFormProvider);

    // Listen to signup state changes
    ref.listen<SignupState>(signupProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } else if (next.response != null && previous?.response == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.response?.message ?? 'Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to login or dashboard
        Navigator.pop(context);
      }
    });

    return LoginPageLayout(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 150, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Applicant Registration',
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '* Required Fields',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 200),
                      child: Column(
                        children: [
                          ..._buildFormFields(),
                          _buildCheckbox(
                            'I agree to receive news letter from VETASSESS',
                            formData.isAgreedToReceiveNews,
                            (value) {
                              ref.read(signupFormProvider.notifier).update((
                                state,
                              ) {
                                state.isAgreedToReceiveNews = value ?? false;
                                return state;
                              });
                            },
                          ),
                          SizedBox(height: 15),
                          _buildCaptchaSection(),
                          SizedBox(height: 20),
                          _buildCookiesNotice(),
                          SizedBox(height: 15),
                          _buildPrivacyPolicyCheckbox(),
                          SizedBox(height: 30),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    final fields = [
      ('Given Names', 'Given names', 'givenNames', true, false),
      ('Surname or family name', 'Surname', 'surname', true, false),
      ('Date of birth (dd/mm/yyyy)', 'dd/mm/yyyy', 'dateOfBirth', true, false),
      ('Email address', 'Email address', 'email', true, false),
      (
        'Confirm email address',
        'Re-enter email address',
        'confirmEmail',
        true,
        false,
      ),
      ('Password', 'Password', 'password', true, true),
      ('Confirm password', 'Re-enter password', 'confirmPassword', true, true),
    ];

    return fields
        .map(
          (field) => _buildFormField(
            field.$1, // label
            field.$2, // hintText
            field.$3, // fieldName
            field.$4, // isRequired
            field.$5, // isPassword
          ),
        )
        .toList();
  }

  Widget _buildFormField(
    String label,
    String hintText,
    String fieldName,
    bool isRequired,
    bool isPassword,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            padding: EdgeInsets.only(top: 12, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.right,
                  ),
                ),
                if (isRequired)
                  Text(' *', style: TextStyle(color: Colors.red, fontSize: 14)),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _controllers[fieldName],
                    obscureText: isPassword,
                    decoration: _inputDecoration(
                      hintText,
                      _errors[fieldName] != null,
                    ),
                    style: TextStyle(fontSize: 14),
                    onChanged: (value) {
                      _validateField(fieldName, value);

                      // Re-validate confirmation fields when original fields change
                      if (fieldName == 'email' &&
                          _controllers['confirmEmail']?.text.isNotEmpty ==
                              true) {
                        _validateField(
                          'confirmEmail',
                          _controllers['confirmEmail']!.text,
                        );
                      } else if (fieldName == 'password' &&
                          _controllers['confirmPassword']?.text.isNotEmpty ==
                              true) {
                        _validateField(
                          'confirmPassword',
                          _controllers['confirmPassword']!.text,
                        );
                      }
                    },
                  ),
                  if (_errors[fieldName] != null)
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        _errors[fieldName]!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText, bool hasError) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(
          color: hasError ? Colors.red : Colors.grey.shade400,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(
          color: hasError ? Colors.red : Colors.grey.shade400,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(
          color: hasError ? Colors.red : Colors.blue.shade400,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(color: Colors.red),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isDense: true,
    );
  }

  Widget _buildCheckbox(String text, bool value, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 220),
          SizedBox(
            width: 18,
            height: 18,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              side: BorderSide(color: Colors.grey.shade500, width: 1),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptchaSection() {
    final signupState = ref.watch(signupProvider);

    return Column(
      children: [
        _buildCaptchaRow(
          'Verification image',
          Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      signupState.captchaText,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap:
                      () => ref.read(signupProvider.notifier).refreshCaptcha(),
                  child: Container(
                    width: 35,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF8C00),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                    ),
                    child: Icon(Icons.refresh, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        _buildCaptchaRow(
          'Enter text shown in the image',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 250,
                child: TextFormField(
                  controller: _controllers['captcha'],
                  decoration: _inputDecoration(
                    'Text shown in the image',
                    _errors['captcha'] != null,
                  ),
                  style: TextStyle(fontSize: 14),
                  onChanged: (value) => _validateField('captcha', value),
                ),
              ),
              if (_errors['captcha'] != null)
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    _errors['captcha']!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCaptchaRow(String label, Widget widget) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          padding: EdgeInsets.only(top: 12, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.right,
                ),
              ),
              Text(' *', style: TextStyle(color: Colors.red, fontSize: 14)),
            ],
          ),
        ),
        widget,
      ],
    );
  }

  Widget _buildCookiesNotice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cookies Notice:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
            children: [
              TextSpan(
                text:
                    'This website uses Cookies which are used to allow us to track the number of people visiting the site, the pages that they visit and how long they stay on each page. This information allows us to continually develop and improve the service we offer our website visitors, and to ensure that we are meeting our key priority of keeping you informed. Find out more about our ',
              ),
              TextSpan(
                text: 'Privacy Policy',
                style: TextStyle(
                  color: Color(0xFFFF8C00),
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyPolicyCheckbox() {
    final formData = ref.watch(signupFormProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: formData.isPrivacyPolicyAccepted,
                onChanged: (value) {
                  ref.read(signupFormProvider.notifier).update((state) {
                    state.isPrivacyPolicyAccepted = value ?? false;
                    return state;
                  });
                  if (value == true) {
                    setState(() {
                      _errors.remove('privacyPolicy');
                    });
                  }
                },
                side: BorderSide(color: Colors.grey.shade500, width: 1),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(text: 'I have read and accepted the VETASSESS '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: Color(0xFFFF8C00),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Disclaimer',
                      style: TextStyle(
                        color: Color(0xFFFF8C00),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (_errors['privacyPolicy'] != null)
          Padding(
            padding: EdgeInsets.only(top: 5, left: 26),
            child: Text(
              _errors['privacyPolicy']!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons() {
    final signupState = ref.watch(signupProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(
          'Cancel',
          Color(0xFF00565B),
          () => Navigator.pop(context),
          false,
        ),
        SizedBox(width: 15),
        _buildButton(
          signupState.isLoading ? 'Registering...' : 'Register',
          Color(0xFF00565B),
          signupState.isLoading ? null : _handleSignup,
          signupState.isLoading,
        ),
      ],
    );
  }

  Widget _buildButton(
    String text,
    Color color,
    VoidCallback? onPressed,
    bool isLoading,
  ) {
    return Container(
      height: 35,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          elevation: 1,
        ),
        child:
            isLoading
                ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : Text(text, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
