import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  final Map<String, TextEditingController> _controllers = {
    for (String field in [
      'givenNames',
      'surname',
      'dateOfBirth',
      'email',
      'confirmEmail',
      'password',
      'confirmPassword',
      'captcha',
    ])
      field: TextEditingController(),
  };
  final Map<String, String> _errors = {};

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _updateFormData() {
    ref.read(signupFormProvider.notifier).update((state) {
      state
        ..givenNames = _controllers['givenNames']?.text ?? ''
        ..surname = _controllers['surname']?.text ?? ''
        ..dateOfBirth = _controllers['dateOfBirth']?.text ?? ''
        ..email = _controllers['email']?.text ?? ''
        ..confirmEmail = _controllers['confirmEmail']?.text ?? ''
        ..password = _controllers['password']?.text ?? ''
        ..confirmPassword = _controllers['confirmPassword']?.text ?? ''
        ..captchaInput = _controllers['captcha']?.text ?? '';
      return state;
    });
  }

  void _validateField(String fieldName, String value) {
    final formData = ref.read(signupFormProvider);
    String? error;

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

    setState(() => _errors.clear());
    bool hasErrors = false;

    // Validate all fields except captcha
    _controllers.forEach((fieldName, controller) {
      if (fieldName != 'captcha') {
        String? error = _getFieldError(fieldName, controller.text, formData);
        if (error != null) {
          _errors[fieldName] = error;
          hasErrors = true;
        }
      }
    });

    // Validate captcha and privacy policy
    final captchaError = formData.validateField(
      'captcha',
      _controllers['captcha']?.text ?? '',
    );
    if (captchaError != null) {
      _errors['captcha'] = captchaError;
      hasErrors = true;
    }

    if (!formData.isPrivacyPolicyAccepted) {
      _errors['privacyPolicy'] = 'You must accept the Privacy Policy';
      hasErrors = true;
    }

    if (hasErrors) {
      setState(() {});
      return;
    }

    await ref.read(signupProvider.notifier).signup(formData);
  }

  String? _getFieldError(String fieldName, String value, formData) {
    if (fieldName == 'confirmEmail') {
      return formData.validateField(
        fieldName,
        value,
        _controllers['email']?.text,
      );
    } else if (fieldName == 'confirmPassword') {
      return formData.validateField(
        fieldName,
        value,
        _controllers['password']?.text,
      );
    }
    return formData.validateField(fieldName, value);
  }

  @override
  Widget build(BuildContext context) {
    final signupState = ref.watch(signupProvider);
    final formData = ref.watch(signupFormProvider);

    ref.listen<SignupState>(signupProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        _showSnackBar(next.errorMessage, Colors.red);
      } else if (next.response != null && previous?.response == null) {
        _showSnackBar(
          next.response?.message ?? 'Registration successful!',
          Colors.green,
        );
        context.go('/login');
      }
    });

    return LoginPageLayout(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 150,
              vertical: isMobile ? 20 : 50,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Applicant Registration',
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 28,
                      color: const Color(0xFF374151),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(isMobile ? 16 : 30),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '* Required Fields',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: isMobile ? 0 : 200,
                          ),
                          child: Column(
                            children: [
                              ..._buildFormFields(isMobile),
                              _buildCheckbox(
                                'I agree to receive news letter from VETASSESS',
                                formData.isAgreedToReceiveNews,
                                (value) {
                                  ref.read(signupFormProvider.notifier).update((
                                    state,
                                  ) {
                                    state.isAgreedToReceiveNews =
                                        value ?? false;
                                    return state;
                                  });
                                  setState(() {});
                                },
                                isMobile,
                              ),
                              const SizedBox(height: 15),
                              _buildCaptchaSection(isMobile),
                              const SizedBox(height: 20),
                              _buildCookiesNotice(),
                              const SizedBox(height: 15),
                              _buildPrivacyPolicyCheckbox(isMobile),
                              const SizedBox(height: 30),
                              _buildActionButtons(isMobile),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  List<Widget> _buildFormFields(bool isMobile) {
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
            field.$1,
            field.$2,
            field.$3,
            field.$4,
            field.$5,
            isMobile,
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
    bool isMobile,
  ) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                if (isRequired)
                  const Text(
                    ' *',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _controllers[fieldName],
              obscureText: isPassword,
              decoration: _inputDecoration(
                hintText,
                _errors[fieldName] != null,
              ),
              style: const TextStyle(fontSize: 14),
              onChanged: (value) {
                _validateField(fieldName, value);
                _revalidateConfirmationFields(fieldName);
              },
            ),
            if (_errors[fieldName] != null)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  _errors[fieldName]!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            padding: const EdgeInsets.only(top: 12, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    textAlign: TextAlign.right,
                  ),
                ),
                if (isRequired)
                  const Text(
                    ' *',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
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
                    style: const TextStyle(fontSize: 14),
                    onChanged: (value) {
                      _validateField(fieldName, value);
                      _revalidateConfirmationFields(fieldName);
                    },
                  ),
                  if (_errors[fieldName] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        _errors[fieldName]!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
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

  void _revalidateConfirmationFields(String fieldName) {
    if (fieldName == 'email' &&
        _controllers['confirmEmail']?.text.isNotEmpty == true) {
      _validateField('confirmEmail', _controllers['confirmEmail']!.text);
    } else if (fieldName == 'password' &&
        _controllers['confirmPassword']?.text.isNotEmpty == true) {
      _validateField('confirmPassword', _controllers['confirmPassword']!.text);
    }
  }

  InputDecoration _inputDecoration(String hintText, bool hasError) {
    final borderColor = hasError ? Colors.red : Colors.grey.shade400;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide: BorderSide(color: borderColor),
    );

    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide(
          color: hasError ? Colors.red : Colors.blue.shade400,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isDense: true,
    );
  }

  Widget _buildCheckbox(
    String text,
    bool value,
    Function(bool?) onChanged,
    bool isMobile,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox(width: 220),
          SizedBox(
            width: 18,
            height: 18,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(
                0xFF00565B,
              ), // Custom color when selected
              checkColor: Colors.white, // Color of the check mark
              side: BorderSide(color: Colors.grey.shade500, width: 1),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptchaSection(bool isMobile) {
    final signupState = ref.watch(signupProvider);

    return Column(
      children: [
        _buildCaptchaRow(
          'Verification image',
          _buildCaptchaImage(signupState.captchaText, isMobile),
          isMobile,
        ),
        const SizedBox(height: 15),
        _buildCaptchaRow(
          'Enter text shown in the image',
          _buildCaptchaInput(isMobile),
          isMobile,
        ),
      ],
    );
  }

  Widget _buildCaptchaImage(String captchaText, bool isMobile) {
    return Container(
      width: isMobile ? double.infinity : 250,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                captchaText,
                style: const TextStyle(
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
            onTap: () => ref.read(signupProvider.notifier).refreshCaptcha(),
            child: Container(
              width: 35,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFFF8C00),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
              ),
              child: const Icon(Icons.refresh, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaptchaInput(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isMobile ? double.infinity : 250,
          child: TextFormField(
            controller: _controllers['captcha'],
            decoration: _inputDecoration(
              'Text shown in the image',
              _errors['captcha'] != null,
            ),
            style: const TextStyle(fontSize: 14),
            onChanged: (value) => _validateField('captcha', value),
          ),
        ),
        if (_errors['captcha'] != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              _errors['captcha']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildCaptchaRow(String label, Widget widget, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          widget,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          padding: const EdgeInsets.only(top: 12, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  textAlign: TextAlign.right,
                ),
              ),
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
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
        const Text(
          'Cookies Notice:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: const TextSpan(
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

  Widget _buildPrivacyPolicyCheckbox(bool isMobile) {
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
                    setState(() => _errors.remove('privacyPolicy'));
                  } else {
                    setState(() {});
                  }
                },
                activeColor: const Color(
                  0xFF00565B,
                ), // Custom color when selected
                checkColor: Colors.white, // Color of the check mark
                side: BorderSide(color: Colors.grey.shade500, width: 1),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: const TextSpan(
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
            padding: EdgeInsets.only(top: 5, left: isMobile ? 0 : 26),
            child: Text(
              _errors['privacyPolicy']!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  // action buttons
  Widget _buildActionButtons(bool isMobile) {
    final signupState = ref.watch(signupProvider);

    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(
          'Cancel',
          const Color(0xFF00565B),
          () => Navigator.pop(context),
          false,
          isMobile,
        ),
        SizedBox(width: isMobile ? 0 : 15, height: isMobile ? 10 : 0),
        _buildButton(
          signupState.isLoading ? 'Registering...' : 'Register',
          const Color(0xFF00565B),
          signupState.isLoading ? null : _handleSignup,
          signupState.isLoading,
          isMobile,
        ),
      ],
    );
  }

  Widget _buildButton(
    String text,
    Color color,
    VoidCallback? onPressed,
    bool isLoading,
    bool isMobile,
  ) {
    return SizedBox(
      height: 35,
      width: isMobile ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          elevation: 1,
        ),
        child:
            isLoading
                ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : Text(text, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
