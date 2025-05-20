import 'package:flutter/material.dart';
import '../widgets/login_page_layout.dart';

class VetassessRegistrationForm extends StatefulWidget {
  const VetassessRegistrationForm({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _VetassessRegistrationFormState createState() => _VetassessRegistrationFormState();
}
class _VetassessRegistrationFormState extends State<VetassessRegistrationForm> {

  final _formKey = GlobalKey<FormState>();


  // Controllers for form fields
  final TextEditingController _givenNamesController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();

  bool _receiveNewsLetter = false;
  bool _acceptedPrivacyPolicy = false;
  bool _formSubmitted = false;
  String? _captchaImage = "UVB9B"; // This would normally be fetched from server

  @override
  void dispose() {
    _givenNamesController.dispose();
    _surnameController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _captchaController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LoginPageLayout(
      child:  Container(
        color: Colors.white,
        child: Column(

            children: [
              // Main content
              Container(
                color: Colors.white,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),

                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Applicant Registration',
                        style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFF374151),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 30),

                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '* Required Fields',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Given Names field
                            _buildFormField(
                              label: 'Given Names',
                              controller: _givenNamesController,
                              hintText: 'Given names',

                            ),

                            // Surname field
                            _buildFormField(
                              label: 'Surname or family name ',
                              controller: _surnameController,
                              hintText: 'Surname',
                              isRequired: true,
                            ),

                            // Date of birth field
                            _buildFormField(
                              label: 'Date of birth (dd/mm/yyyy) ',
                              controller: _dobController,
                              hintText: 'dd/mm/yyyy',
                              isRequired: true,
                            ),

                            // Email field
                            _buildFormField(
                              label: 'Email address ',
                              controller: _emailController,
                              hintText: 'Email address',
                              isRequired: true,
                            ),

                            // Confirm email field
                            _buildFormField(
                              label: 'Confirm email address ',
                              controller: _confirmEmailController,
                              hintText: 'Re-enter email address',
                              isRequired: true,
                            ),

                            // Password field
                            _buildFormField(
                              label: 'Password ',
                              controller: _passwordController,
                              hintText: 'Password',
                              isRequired: true,
                              isPassword: true,
                            ),

                            // Confirm password field
                            _buildFormField(
                              label: 'Confirm password ',
                              controller: _confirmPasswordController,
                              hintText: 'Re-enter password',
                              isRequired: true,
                              isPassword: true,
                            ),

                            // Newsletter checkbox
                            _buildCheckboxField(
                              text: 'I agree to receive news letter from VETASSESS',
                              value: _receiveNewsLetter,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _receiveNewsLetter = value;
                                  });
                                }
                              },
                            ),

                            SizedBox(height: 20),

                            // CAPTCHA section
                            _buildCaptchaSection(),
                            _buildCookiesNotice(),
                            _buildPrivacyPolicyCheckbox(),
                            SizedBox(height: 24),
                            Divider(color: Colors.grey.shade300),
                            _buildActionButtons(),
                            // Enter text field

                            SizedBox(height: 20),

                            // Terms checkbox




                            // Buttons

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),

    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool isRequired = false,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label section
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14),
                ),
                if (isRequired)
                  const Text(
                    ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),


          // Input field section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 TextFormField(
                  controller: controller,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    hintText: hintText ?? label,
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.blue.shade400),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  validator: isRequired
                      ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  } : null,
                ),
                if (isRequired && controller != null)
                  const Padding(
                    padding:  EdgeInsets.only(top: 4),
                    child: Text(
                      'This field is required.',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCheckboxField({
    required String text,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width / 3),
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              side: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCaptchaSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Verification Image
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Verification image',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                flex: 3,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CAPTCHA text display
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          _captchaImage ?? '',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 18,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Refresh button
                      Container(
                        color: Colors.orange,
                        child: IconButton(
                          icon: Icon(Icons.refresh, color: Colors.white),
                          onPressed: () {
                            // Would normally fetch a new CAPTCHA
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Enter CAPTCHA text field
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Enter text shown in the image',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _captchaController,
                      decoration: InputDecoration(
                        hintText: 'Text shown in the image',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'This field is required.',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildCookiesNotice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cookies Notice:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This website uses Cookies which are used to allow us to track the number of people visiting the site, the pages that they visit and how long they stay on each page. This information allows us to continually develop and improve the service we offer our website visitors, and to ensure that we are meeting our key priority of keeping you informed. Find out more about our Privacy Policy.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPrivacyPolicyCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _acceptedPrivacyPolicy,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _acceptedPrivacyPolicy = value;
                });
              }
            },
            side: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: 'I have read and accepted the VETASSESS ',
              style: TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Colors.orange,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Disclaimer',
                  style: TextStyle(
                    color: Colors.orange,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _acceptedPrivacyPolicy ? () {
            if (_formKey.currentState!.validate()) {
              // Process data
            }
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            disabledBackgroundColor: Colors.grey.shade300,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text('Register'),
        ),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () {
            // Cancel registration
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

}