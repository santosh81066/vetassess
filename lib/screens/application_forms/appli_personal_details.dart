import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/widgets/login_page_layout.dart';
import 'package:vetassess/providers/persondetails_provider.dart';

import '../../widgets/application_nav.dart';
import 'appli_occupation.dart';

class PersonalDetailsForm extends ConsumerStatefulWidget {
  const PersonalDetailsForm({super.key});

  @override
  ConsumerState<PersonalDetailsForm> createState() => PersonalDetailsFormState();
}

class PersonalDetailsFormState extends ConsumerState<PersonalDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Text editing controllers
  final _surnameController = TextEditingController();
  final _givenNamesController = TextEditingController();
  final _previousSurnameController = TextEditingController();
  final _previousGivenNamesController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _passportNumberController = TextEditingController();
  final _passportIssuedDateController = TextEditingController();
  final _otherPassportNumberController = TextEditingController();
  final _otherPassportIssuedDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _faxController = TextEditingController();
  final _mobileController = TextEditingController();
  
  // Address controllers
  final _postalAddress1Controller = TextEditingController();
  final _postalAddress2Controller = TextEditingController();
  final _postalAddress3Controller = TextEditingController();
  final _postalSuburbController = TextEditingController();
  final _postalStateController = TextEditingController();
  final _postalPostcodeController = TextEditingController();
  
  final _homeAddress1Controller = TextEditingController();
  final _homeAddress2Controller = TextEditingController();
  final _homeAddress3Controller = TextEditingController();
  final _homeSuburbController = TextEditingController();
  final _homeStateController = TextEditingController();
  final _homePostcodeController = TextEditingController();

  bool _isLoading = false;

    // Get user ID from login state
  int? get _currentUserId {
    final loginState = ref.read(loginProvider);
    return loginState.response?.userId;
  }

  // Responsive breakpoints
  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  bool _isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 && 
           MediaQuery.of(context).size.width < 1024;
  }

  bool _isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  double _getNavWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (_isMobile(context)) return screenWidth * 0.2;
    if (_isTablet(context)) return screenWidth * 0.25;
    return screenWidth * 0.3;
  }

  double _getFormRightMargin(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (_isMobile(context)) return 16;
    if (_isTablet(context)) return 50;
    return 125;
  }

  double _getFormRightPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (_isMobile(context)) return 20;
    if (_isTablet(context)) return 50;
    return 100;
  }

  @override
  void dispose() {
    // Dispose all controllers
    _surnameController.dispose();
    _givenNamesController.dispose();
    _previousSurnameController.dispose();
    _previousGivenNamesController.dispose();
    _dateOfBirthController.dispose();
    _passportNumberController.dispose();
    _passportIssuedDateController.dispose();
    _otherPassportNumberController.dispose();
    _otherPassportIssuedDateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _faxController.dispose();
    _mobileController.dispose();
    _postalAddress1Controller.dispose();
    _postalAddress2Controller.dispose();
    _postalAddress3Controller.dispose();
    _postalSuburbController.dispose();
    _postalStateController.dispose();
    _postalPostcodeController.dispose();
    _homeAddress1Controller.dispose();
    _homeAddress2Controller.dispose();
    _homeAddress3Controller.dispose();
    _homeSuburbController.dispose();
    _homeStateController.dispose();
    _homePostcodeController.dispose();
    super.dispose();
  }

  void _copyFromPostalAddress() {
    setState(() {
      _homeAddress1Controller.text = _postalAddress1Controller.text;
      _homeAddress2Controller.text = _postalAddress2Controller.text;
      _homeAddress3Controller.text = _postalAddress3Controller.text;
      _homeSuburbController.text = _postalSuburbController.text;
      _homeStateController.text = _postalStateController.text;
      _homePostcodeController.text = _postalPostcodeController.text;
    });
    
    final personalDetails = ref.read(personalDetailsProvider.notifier);
    personalDetails.copyPostalToHome();
  }

  Future<void> _saveAndExit() async {
    if (!_formKey.currentState!.validate()) return;

      // Check if user ID is available
    final userId = _currentUserId;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in. Please login again.')),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    // Update all form data to provider
    _updateProviderData();
    
    // Save as draft
    final success = await ref.read(personalDetailsProvider.notifier).saveAsDraft(
      userId: userId, // Replace with actual user ID
    );
    
    setState(() => _isLoading = false);
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Draft saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save draft. Please try again.')),
      );
    }
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) return;

     // Check if user ID is available
    final userId = _currentUserId;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in. Please login again.')),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    // Update all form data to provider
    _updateProviderData();
    
   
    // Submit the form
    final  success = await ref.read(personalDetailsProvider.notifier).submitPersonalDetails(    
      userId:  userId, // Replace with actual user ID
    );
    
    setState(() => _isLoading = false);
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Personal details submitted successfully!')),
      );
      context.go('/occupation_form');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit. Please try again.')),
      );
    }
  }

  void _updateProviderData() {
    final personalDetailsNotifier = ref.read(personalDetailsProvider.notifier);
    final currentState = ref.read(personalDetailsProvider);
    
    personalDetailsNotifier.updateSurname(_surnameController.text);
    personalDetailsNotifier.updateGivenNames(_givenNamesController.text);
    personalDetailsNotifier.updateDateOfBirth(_dateOfBirthController.text);
    personalDetailsNotifier.updateCurrentPassportNumber(_passportNumberController.text);
    personalDetailsNotifier.updateDatePassportIssued(_passportIssuedDateController.text);
    personalDetailsNotifier.updateEmailAddress(_emailController.text);
    personalDetailsNotifier.updateDaytimeTelephoneNumber(_phoneController.text);
    
    // Combine address lines
    String postalAddress = [
      _postalAddress1Controller.text,
      _postalAddress2Controller.text,
      _postalAddress3Controller.text,
    ].where((line) => line.isNotEmpty).join('\n');
    
    String homeAddress = [
      _homeAddress1Controller.text,
      _homeAddress2Controller.text,
      _homeAddress3Controller.text,
    ].where((line) => line.isNotEmpty).join('\n');
    
    personalDetailsNotifier.updatePostalStreetAddress(postalAddress);
    personalDetailsNotifier.updatePostalSuburbCity(_postalSuburbController.text);
    personalDetailsNotifier.updateHomeStreetAddress(homeAddress);
    personalDetailsNotifier.updateHomeSuburbCity(_homeSuburbController.text);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final personalDetails = ref.watch(personalDetailsProvider);
    final loginState = ref.watch(loginProvider);

       // Show error if user is not logged in
    if (loginState.response?.userId == null) {
      return LoginPageLayout(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Session expired or user not logged in',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: Text('Go to Login'),
              ),
            ],
          ),
        ),
      );
    }

    return LoginPageLayout(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Form(
            key: _formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.02),
                  width: _getNavWidth(context),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ApplicationNav(),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: screenHeight * 0.02, 
                          left: screenWidth * 0.02
                        ),
                        child: Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: _isMobile(context) ? 20 : 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: screenHeight * 0.02,
                          left: screenWidth * 0.02,
                          bottom: _isMobile(context) ? 50 : 100,
                          right: _getFormRightMargin(context),
                        ),
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.025,
                          left: screenWidth * 0.025,
                          right: _getFormRightPadding(context),
                          bottom: screenHeight * 0.025,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildRequiredFieldsNotice(),
                              ..._buildAllSections(),
                              _buildAuthorizationSection(),
                              if (_isLoading)
                                const Center(child: CircularProgressIndicator())
                              else
                                _buildActionButtons(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequiredFieldsNotice() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '* ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              'Required Fields',
              style: TextStyle(
                color: Colors.red.shade700, 
                fontSize: _isMobile(context) ? 12 : 14
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }

  List<Widget> _buildAllSections() {
    return [
      _buildSection('General Information', [
        _buildField(
          'Preferred title',
          _buildDropdown(
            ref.watch(personalDetailsProvider).preferredTitle,
            (v) => ref.read(personalDetailsProvider.notifier).updatePreferredTitle(v),
            _getFieldWidth(),
            ['Mr', 'Mrs', 'Ms', 'Dr', 'Prof'],
          ),
          required: true,
        ),
        _buildField(
          'Surname or family name',
          _buildTextField(_surnameController),
          required: true,
        ),
        _buildField('Given names', _buildTextField(_givenNamesController)),
        _buildField('Gender', _buildGenderRadioGroup(), required: true),
        _buildField('Previous surname or family name', _buildTextField(_previousSurnameController)),
        _buildField('Previous given names', _buildTextField(_previousGivenNamesController)),
        _buildField(
          'Date of birth (dd/mm/yyyy)',
          _buildTextField(_dateOfBirthController, _getFieldWidth()),
          required: true,
        ),
        _buildField(
          'Country of birth',
          _buildDropdown(
            ref.watch(personalDetailsProvider).countryOfBirth,
            (v) => ref.read(personalDetailsProvider.notifier).updateCountryOfBirth(v),
            _getFieldWidth(),
            ['Australia', 'India', 'USA', 'UK', 'Canada'], // Add your country list
          ),
          required: true,
        ),
        _buildField(
          'Country of current residency',
          _buildDropdown(
            ref.watch(personalDetailsProvider).countryOfCurrentResidency,
            (v) => ref.read(personalDetailsProvider.notifier).updateCountryOfCurrentResidency(v),
            _getFieldWidth(),
            ['Australia', 'India', 'USA', 'UK', 'Canada'], // Add your country list
          ),
          required: true,
        ),
      ]),

      _buildDivider(),

      _buildSection('Citizenship', [
        _buildField(
          'Country',
          _buildDropdown(
            ref.watch(personalDetailsProvider).citizenshipCountry,
            (v) => ref.read(personalDetailsProvider.notifier).updateCitizenshipCountry(v),
            _getFieldWidth(),
            ['Australia', 'India', 'USA', 'UK', 'Canada'], // Add your country list
          ),
          required: true,
        ),
        _buildField('Current passport number', _buildTextField(_passportNumberController)),
        _buildField('Date passport issued', _buildTextField(_passportIssuedDateController, _getFieldWidth())),
      ]),

      _buildDivider(),

      _buildSection('Other Citizenship', [
        _buildField(
          'Country',
          _buildDropdown(
            ref.watch(personalDetailsProvider).citizenshipCountry, // You might want a separate field for other citizenship
            (v) => {}, // Handle other citizenship country
            _getFieldWidth(),
            ['Australia', 'India', 'USA', 'UK', 'Canada'], // Add your country list
          ),
        ),
        _buildField('Current passport number', _buildTextField(_otherPassportNumberController)),
        _buildField('Date passport issued', _buildTextField(_otherPassportIssuedDateController, _getFieldWidth())),
      ]),

      _buildDivider(),

      _buildSection("Applicant's Contact Details", [
        _buildField('Email address', _buildTextField(_emailController), required: true),
        _buildField(
          'Daytime telephone number',
          _buildTextField(_phoneController),
          required: true,
        ),
        _buildField('Fax number', _buildTextField(_faxController)),
        _buildField('Mobile number', _buildTextField(_mobileController)),
      ]),

      _buildDivider(),

      _buildAddressSection(
        "Applicant's Postal Address",
        ref.watch(personalDetailsProvider).postalCountry,
        (v) => ref.read(personalDetailsProvider.notifier).updatePostalCountry(v),
        _postalAddress1Controller,
        _postalAddress2Controller,
        _postalAddress3Controller,
        _postalSuburbController,
        _postalStateController,
        _postalPostcodeController,
      ),

      _buildDivider(),

      _buildAddressSection(
        "Applicant's Home Address",
        ref.watch(personalDetailsProvider).homeCountry,
        (v) => ref.read(personalDetailsProvider.notifier).updateHomeCountry(v),
        _homeAddress1Controller,
        _homeAddress2Controller,
        _homeAddress3Controller,
        _homeSuburbController,
        _homeStateController,
        _homePostcodeController,
        showCopyButton: true,
      ),
    ];
  }

  double _getFieldWidth() {
    final screenWidth = MediaQuery.of(context).size.width;
    if (_isMobile(context)) return screenWidth * 0.8;
    if (_isTablet(context)) return screenWidth * 0.4;
    return 250;
  }

  Widget _buildDivider() {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Divider(color: Colors.grey.shade300, thickness: 1),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: _isMobile(context) ? 16 : 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ...fields,
      ],
    );
  }

  Widget _buildAddressSection(
    String title,
    String? selectedCountry,
    Function(String?) onCountryChanged,
    TextEditingController address1Controller,
    TextEditingController address2Controller,
    TextEditingController address3Controller,
    TextEditingController suburbController,
    TextEditingController stateController,
    TextEditingController postcodeController, {
    bool showCopyButton = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: _isMobile(context) ? 16 : 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        if (showCopyButton) ...[
          Center(
            child: ElevatedButton(
              onPressed: _copyFromPostalAddress,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Copy from Postal Address',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _isMobile(context) ? 12 : 14,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
        _buildField('Street address', _buildMultiLineAddress(
          address1Controller,
          address2Controller,
          address3Controller,
        ), required: true),
        _buildField('Suburb/City', _buildTextField(suburbController, _getFieldWidth()), required: true),
        _buildField('State', _buildTextField(stateController, _getFieldWidth())),
        _buildField('Post code', _buildTextField(postcodeController, _getFieldWidth())),
        _buildField(
          'Country',
          _buildDropdown(
            selectedCountry,
            onCountryChanged,
            _getFieldWidth(),
            ['Australia', 'India', 'USA', 'UK', 'Canada'], // Add your country list
          ),
          required: true,
        ),
      ],
    );
  }

  Widget _buildField(String label, Widget field, {bool required = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Mobile layout: stack label and field vertically
          if (_isMobile(context)) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    if (required)
                      Text(
                        ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                field,
              ],
            );
          }

          // Desktop and Tablet layout: side by side
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.015,
                    right: screenWidth * 0.02,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: _isTablet(context) ? 13 : 14,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              if (required)
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.015,
                    right: 4,
                  ),
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Expanded(
                flex: 3,
                child: Align(alignment: Alignment.centerLeft, child: field),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, [double? maxWidth]) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.015,
            vertical: screenHeight * 0.015,
          ),
        ),
        style: TextStyle(fontSize: _isMobile(context) ? 12 : 14),
        validator: (value) {
          // Add validation logic if needed
          return null;
        },
      ),
    );
  }

  Widget _buildMultiLineAddress(
    TextEditingController controller1,
    TextEditingController controller2,
    TextEditingController controller3,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        _buildTextField(controller1),
        SizedBox(height: screenHeight * 0.01),
        _buildTextField(controller2),
        SizedBox(height: screenHeight * 0.01),
        _buildTextField(controller3),
      ],
    );
  }

  Widget _buildDropdown(
    String? value,
    Function(String?) onChanged, [
    double? maxWidth,
    List<String>? options,
  ]) {
    final screenHeight = MediaQuery.of(context).size.height;
    final dropdownOptions = options ?? ['Option 1', 'Option 2'];

    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.015,
            vertical: screenHeight * 0.015,
          ),
        ),
        hint: Text(
          'Select one',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: _isMobile(context) ? 12 : 14,
          ),
        ),
        items: dropdownOptions.map((option) => 
          DropdownMenuItem(value: option, child: Text(option))
        ).toList(),
        onChanged: onChanged,
        validator: (value) {
          // Add validation logic if needed
          return null;
        },
      ),
    );
  }

  Widget _buildGenderRadioGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile<String>(
          title: Text(
            'Male',
            style: TextStyle(fontSize: _isMobile(context) ? 12 : 14),
          ),
          value: 'Male',
          groupValue: ref.watch(personalDetailsProvider).gender,
          onChanged: (value) => ref.read(personalDetailsProvider.notifier).updateGender(value!),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        RadioListTile<String>(
          title: Text(
            'Female',
            style: TextStyle(fontSize: _isMobile(context) ? 12 : 14),
          ),
          value: 'Female',
          groupValue: ref.watch(personalDetailsProvider).gender,
          onChanged: (value) => ref.read(personalDetailsProvider.notifier).updateGender(value!),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        RadioListTile<String>(
          title: Text(
            'Indeterminate/Intersex/Unspecified',
            style: TextStyle(fontSize: _isMobile(context) ? 12 : 14),
          ),
          value: 'Indeterminate',
          groupValue: ref.watch(personalDetailsProvider).gender,
          onChanged: (value) => ref.read(personalDetailsProvider.notifier).updateGender(value!),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
      ],
    );
  }

  Widget _buildAuthorizationSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        _buildDivider(),
        Container(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you authorise an agent or representative to act for you in all matters concerned with this application?',
                style: TextStyle(
                  fontSize: _isMobile(context) ? 12 : 14,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              LayoutBuilder(
                builder: (context, constraints) {
                  // Mobile layout: stack radio buttons vertically
                  if (_isMobile(context)) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: ref.watch(personalDetailsProvider).isAgentAuthorized,
                              onChanged: (value) => ref.read(personalDetailsProvider.notifier).updateIsAgentAuthorized(value!),
                            ),
                            Text(
                              'Yes',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: ref.watch(personalDetailsProvider).isAgentAuthorized,
                              onChanged: (value) => ref.read(personalDetailsProvider.notifier).updateIsAgentAuthorized(value!),
                            ),
                            Text(
                              'No',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  // Desktop and Tablet layout: side by side
                  return Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: ref.watch(personalDetailsProvider).isAgentAuthorized,
                        onChanged: (value) => ref.read(personalDetailsProvider.notifier).updateIsAgentAuthorized(value!),
                      ),
                      Text(
                        'Yes',
                        style: TextStyle(fontSize: _isTablet(context) ? 13 : 14),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Radio<bool>(
                        value: false,
                        groupValue: ref.watch(personalDetailsProvider).isAgentAuthorized,
                        onChanged: (value) => ref.read(personalDetailsProvider.notifier).updateIsAgentAuthorized(value!),
                      ),
                      Text(
                        'No',
                        style: TextStyle(fontSize: _isTablet(context) ? 13 : 14),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }

  Widget _buildActionButtons() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile layout: stack buttons vertically
        if (_isMobile(context)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _isLoading ? null : _saveAndExit,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                ),
                child: Text(
                  'Save & Exit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              ElevatedButton(
                onPressed: _isLoading ? null : _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          );
        }

        // Desktop and Tablet layout: side by side
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _saveAndExit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Save & Exit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _isTablet(context) ? 13 : 14,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            ElevatedButton(
              onPressed: _isLoading ? null : _continue,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.015,
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _isTablet(context) ? 13 : 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}