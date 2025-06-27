import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ConsumerState<PersonalDetailsForm> createState() =>
      PersonalDetailsFormState();
}

class PersonalDetailsFormState extends ConsumerState<PersonalDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers map for easier management
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {
      'surname': TextEditingController(),
      'givenNames': TextEditingController(),
      'previousSurname': TextEditingController(),
      'previousGivenNames': TextEditingController(),
      'dateOfBirth': TextEditingController(),
      'passportNumber': TextEditingController(),
      'passportIssuedDate': TextEditingController(),
      'otherPassportNumber': TextEditingController(),
      'otherPassportIssuedDate': TextEditingController(),
      'email': TextEditingController(),
      'phone': TextEditingController(),
      'fax': TextEditingController(),
      'mobile': TextEditingController(),
      'postalAddress1': TextEditingController(),
      'postalAddress2': TextEditingController(),
      'postalAddress3': TextEditingController(),
      'postalSuburb': TextEditingController(),
      'postalState': TextEditingController(),
      'postalPostcode': TextEditingController(),
      'homeAddress1': TextEditingController(),
      'homeAddress2': TextEditingController(),
      'homeAddress3': TextEditingController(),
      'homeSuburb': TextEditingController(),
      'homeState': TextEditingController(),
      'homePostcode': TextEditingController(),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Responsive utilities
  int? get _currentUserId => ref.read(loginProvider).response?.userId;
  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 1024;

  double _getNavWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return _isMobile(context)
        ? width * 0.2
        : _isTablet(context)
        ? width * 0.25
        : width * 0.3;
  }

  double _getFormRightMargin(BuildContext context) {
    return _isMobile(context)
        ? 16
        : _isTablet(context)
        ? 50
        : 125;
  }

  double _getFormRightPadding(BuildContext context) {
    return _isMobile(context)
        ? 20
        : _isTablet(context)
        ? 50
        : 100;
  }

  double _getFieldWidth() {
    final width = MediaQuery.of(context).size.width;
    return _isMobile(context)
        ? width * 0.8
        : _isTablet(context)
        ? width * 0.4
        : 250;
  }

  void _copyFromPostalAddress() {
    setState(() {
      [
        'Address1',
        'Address2',
        'Address3',
        'Suburb',
        'State',
        'Postcode',
      ].forEach((field) {
        _controllers['home$field']!.text = _controllers['postal$field']!.text;
      });
    });
    ref.read(personalDetailsProvider.notifier).copyPostalToHome();
  }

  // Validation methods
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{8,}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateDate(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    try {
      // Validate yyyy-mm-dd format
      final parts = value.split('-');
      if (parts.length != 3) throw FormatException();

      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      final date = DateTime(year, month, day);
      if (date.year != year || date.month != month || date.day != day) {
        throw FormatException();
      }

      return null;
    } catch (e) {
      return 'Please enter date in yyyy-mm-dd format';
    }
  }

  String? _validateDropdown(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateAddress() {
    final address1 = _controllers['postalAddress1']?.text.trim() ?? '';
    final address2 = _controllers['postalAddress2']?.text.trim() ?? '';
    final address3 = _controllers['postalAddress3']?.text.trim() ?? '';

    if (address1.isEmpty && address2.isEmpty && address3.isEmpty) {
      return 'At least one address line is required';
    }
    return null;
  }

  String? _validateHomeAddress() {
    final address1 = _controllers['homeAddress1']?.text.trim() ?? '';
    final address2 = _controllers['homeAddress2']?.text.trim() ?? '';
    final address3 = _controllers['homeAddress3']?.text.trim() ?? '';

    if (address1.isEmpty && address2.isEmpty && address3.isEmpty) {
      return 'At least one address line is required';
    }
    return null;
  }

  Future<void> _selectDate(String controllerKey) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _controllers[controllerKey]!.text =
        '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> _handleSubmission(bool isDraft) async {
    if (!isDraft && !_formKey.currentState!.validate()) {
      // Show error message for validation failure
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate gender selection for non-draft submissions
    if (!isDraft && ref.read(personalDetailsProvider).gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your gender'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = _currentUserId;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not logged in. Please login again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    _updateProviderData();

    try {
      final result = isDraft
          ? await ref
          .read(personalDetailsProvider.notifier)
          .saveAsDraft(userId: userId)
          : await ref
          .read(personalDetailsProvider.notifier)
          .submitPersonalDetails(userId: userId);

      if (mounted) {
        setState(() => _isLoading = false);

        if (result.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isDraft
                    ? 'Draft saved successfully!'
                    : 'Personal details submitted successfully!',
              ),
              backgroundColor: Colors.green,
            ),
          );
          if (!isDraft) context.go('/occupation_form');
        } else {
          _showErrorDialog(
            title: isDraft ? 'Failed to Save Draft' : 'Submission Failed',
            message: result.errorMessage ?? 'Unknown error occurred',
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorDialog(
          title: 'Error',
          message: 'An unexpected error occurred: ${e.toString()}',
        );
      }
    }
  }

  void _showErrorDialog({required String title, required String message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: SingleChildScrollView(
            child: SelectableText(
              message,
              style: TextStyle(fontSize: _isMobile(context) ? 12 : 14),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
           // context.go('/occupation_form'),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateProviderData() {
    final notifier = ref.read(personalDetailsProvider.notifier);

    notifier.updateSurname(_controllers['surname']!.text);
    notifier.updateGivenNames(_controllers['givenNames']!.text);
    notifier.updateDateOfBirth(_controllers['dateOfBirth']!.text);
    notifier.updateCurrentPassportNumber(_controllers['passportNumber']!.text);
    notifier.updateDatePassportIssued(_controllers['passportIssuedDate']!.text);
    notifier.updateEmailAddress(_controllers['email']!.text);
    notifier.updateDaytimeTelephoneNumber(_controllers['phone']!.text);

    // Combine address lines
    final postalAddress = [
      _controllers['postalAddress1']!.text,
      _controllers['postalAddress2']!.text,
      _controllers['postalAddress3']!.text,
    ].where((line) => line.isNotEmpty).join('\n');

    final homeAddress = [
      _controllers['homeAddress1']!.text,
      _controllers['homeAddress2']!.text,
      _controllers['homeAddress3']!.text,
    ].where((line) => line.isNotEmpty).join('\n');

    notifier.updatePostalStreetAddress(postalAddress);
    notifier.updatePostalSuburbCity(_controllers['postalSuburb']!.text);
    notifier.updateHomeStreetAddress(homeAddress);
    notifier.updateHomeSuburbCity(_controllers['homeSuburb']!.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LoginPageLayout(
      child: Form(
        key: _formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: _getNavWidth(context),
              child: const Align(
                alignment: Alignment.topRight,
                 child: ApplicationNavWithProgress(
                  currentRoute: '/personal_form',
            completedRoutes: {
              // '/personal_form',
              // '/occupation_form',
              // '/education_form',
              // '/tertiary_education_form',
              // '/employment_form',
              // '/licence_form',
              // '/app_priority_form',
            },
              ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.02,
                      left: size.width * 0.02,
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
                      top: size.height * 0.02,
                      left: size.width * 0.02,
                      bottom: _isMobile(context) ? 50 : 100,
                      right: _getFormRightMargin(context),
                    ),
                    padding: EdgeInsets.only(
                      top: size.height * 0.025,
                      left: size.width * 0.025,
                      right: _getFormRightPadding(context),
                      bottom: size.height * 0.025,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }

  Widget _buildRequiredFieldsNotice() {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              '* ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              'Required Fields',
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: _isMobile(context) ? 12 : 14,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }

  List<Widget> _buildAllSections() {
    final personalDetails = ref.watch(personalDetailsProvider);
    const countries = ['Australia', 'India', 'USA', 'UK', 'Canada'];

    return [
      _buildSection('General Information', [
        _buildField(
          'Preferred title',
          _buildDropdown(
            personalDetails.preferredTitle,
                (v) => ref
                .read(personalDetailsProvider.notifier)
                .updatePreferredTitle(v),
            const ['Mr', 'Mrs', 'Ms', 'Dr', 'Prof'],
            validator: (value) => _validateDropdown(value, 'Preferred title'),
          ),
          required: true,
        ),
        _buildField(
          'Surname or family name',
          _buildTextField('surname', validator: (value) => _validateRequired(value, 'Surname')),
          required: true,
        ),
        _buildField('Given names', _buildTextField('givenNames')),
        _buildField('Gender', _buildGenderRadioGroup(), required: true),
        _buildField(
          'Previous surname or family name',
          _buildTextField('previousSurname'),
        ),
        _buildField(
          'Previous given names',
          _buildTextField('previousGivenNames'),
        ),
        _buildField(
          'Date of birth (yyyy-mm-dd)',
          _buildDateField('dateOfBirth', 'Date of birth'),
          required: true,
        ),
        _buildField(
          'Country of birth',
          _buildDropdown(
            personalDetails.countryOfBirth,
                (v) => ref
                .read(personalDetailsProvider.notifier)
                .updateCountryOfBirth(v),
            countries,
            validator: (value) => _validateDropdown(value, 'Country of birth'),
          ),
          required: true,
        ),
        _buildField(
          'Country of current residency',
          _buildDropdown(
            personalDetails.countryOfCurrentResidency,
                (v) => ref
                .read(personalDetailsProvider.notifier)
                .updateCountryOfCurrentResidency(v),
            countries,
            validator: (value) => _validateDropdown(value, 'Country of current residency'),
          ),
          required: true,
        ),
      ]),
      _buildDivider(),
      _buildSection('Citizenship', [
        _buildField(
          'Country',
          _buildDropdown(
            personalDetails.citizenshipCountry,
                (v) => ref
                .read(personalDetailsProvider.notifier)
                .updateCitizenshipCountry(v),
            countries,
            validator: (value) => _validateDropdown(value, 'Citizenship country'),
          ),
          required: true,
        ),
        _buildField(
          'Current passport number',
          _buildTextField('passportNumber'),
          required: true,
        ),
        _buildField(
          'Date passport issued (dd/mm/yyyy)',
          _buildDateField('passportIssuedDate', 'Passport issue date'),
          required: true,
        ),
        
      ]),
      _buildDivider(),
      _buildSection('Other Citizenship', [
        _buildField('Country', _buildDropdown(null, (v) {}, countries)),
        _buildField(
          'Current passport number',
          _buildTextField('otherPassportNumber'),
        ),
        _buildField(
          'Date passport issued',
          _buildDateField('otherPassportIssuedDate', 'Other passport issue date'),
          required: false,
        ),
        
      ]),
      _buildDivider(),
      _buildSection("Applicant's Contact Details", [
        _buildField('Email address', _buildTextField('email', validator: _validateEmail), required: true),
        _buildField(
          'Daytime telephone number',
          _buildTextField('phone', validator: _validatePhone, keyboardType: TextInputType.phone),
          required: true,
        ),
        _buildField('Fax number', _buildTextField('fax', keyboardType: TextInputType.phone)),
        _buildField('Mobile number', _buildTextField('mobile', keyboardType: TextInputType.phone)),
      ]),
      _buildDivider(),
      _buildAddressSection(
        "Applicant's Postal Address",
        'postal',
        personalDetails.postalCountry,
            (v) =>
            ref.read(personalDetailsProvider.notifier).updatePostalCountry(v),
      ),
      _buildDivider(),
      _buildAddressSection(
        "Applicant's Home Address",
        'home',
        personalDetails.homeCountry,
            (v) => ref.read(personalDetailsProvider.notifier).updateHomeCountry(v),
        showCopyButton: true,
      ),
    ];
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
      String prefix,
      String? selectedCountry,
      Function(String?) onCountryChanged, {
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
        _buildField(
          'Street address',
          _buildMultiLineAddress(prefix),
          required: true,
        ),
        _buildField(
          'Suburb/City',
          _buildTextField('${prefix}Suburb', validator: (value) => _validateRequired(value, 'Suburb/City')),
          required: true,
        ),
        _buildField(
          'State',
          _buildTextField('${prefix}State'),
        ),
        _buildField(
          'Post code',
          _buildTextField('${prefix}Postcode'),
        ),
        _buildField(
          'Country',
          _buildDropdown(
            selectedCountry,
            onCountryChanged,
            const ['Australia', 'India', 'USA', 'UK', 'Canada'],
            validator: (value) => _validateDropdown(value, 'Country'),
          ),
          required: true,
        ),
      ],
    );
  }

  Widget _buildField(String label, Widget field, {bool required = false}) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      child: _isMobile(context)
          ? Column(
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
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          field,
        ],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.015,
                right: size.width * 0.02,
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
                top: size.height * 0.015,
                right: 4,
              ),
              child: const Text(
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
      ),
    );
  }

  Widget _buildTextField(
      String key, {
        double? maxWidth,
        String? Function(String?)? validator,
        TextInputType? keyboardType,
        List<TextInputFormatter>? inputFormatters,
      }) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      child: TextFormField(
        controller: _controllers[key],
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.015,
            vertical: size.height * 0.015,
          ),
        ),
        style: TextStyle(fontSize: _isMobile(context) ? 12 : 14),
      ),
    );
  }

Widget _buildDateField(String key, String fieldName) {
  return GestureDetector(
    onTap: () => _selectDate(key),
    child: AbsorbPointer(
      child: _buildTextField(
        key,
        maxWidth: _getFieldWidth(),
        validator: (value) {
          // Only validate the main Citizenship's passport issued date
          if (key == 'passportIssuedDate') {
            return _validateDate(value, fieldName); // Required
          }

          // Skip validation for otherPassportIssuedDate
          return null;
        },
      ),
    ),
  );
}


  Widget _buildMultiLineAddress(String prefix) {
    final size = MediaQuery.of(context).size;

    // Custom validator for address that checks if at least one line is filled
    String? addressValidator(String? value) {
      if (prefix == 'postal') {
        return _validateAddress();
      } else if (prefix == 'home') {
        return _validateHomeAddress();
      }
      return null;
    }

    return Column(
      children: [
        _buildTextField('${prefix}Address1', validator: addressValidator),
        SizedBox(height: size.height * 0.01),
        _buildTextField('${prefix}Address2'),
        SizedBox(height: size.height * 0.01),
        _buildTextField('${prefix}Address3'),
      ],
    );
  }

  Widget _buildDropdown(
      String? value,
      Function(String?) onChanged,
      List<String> options, {
        double? maxWidth,
        String? Function(String?)? validator,
      }) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      child: DropdownButtonFormField<String>(
        value: value,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.015,
            vertical: size.height * 0.015,
          ),
        ),
        hint: Text(
          'Select one',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: _isMobile(context) ? 12 : 14,
          ),
        ),
        items: options
            .map(
              (option) =>
              DropdownMenuItem(value: option, child: Text(option)),
        )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildGenderRadioGroup() {
    const genders = ['Male', 'Female', 'Indeterminate'];
    const labels = ['Male', 'Female', 'Indeterminate/Intersex/Unspecified'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        genders.length,
            (index) => RadioListTile<String>(
          title: Text(
            labels[index],
            style: TextStyle(fontSize: _isMobile(context) ? 12 : 14),
          ),
          value: genders[index],
          groupValue: ref.watch(personalDetailsProvider).gender,
          onChanged: (value) => ref
              .read(personalDetailsProvider.notifier)
              .updateGender(value!),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
      ),
    );
  }

  Widget _buildAuthorizationSection() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        _buildDivider(),
        Container(
          padding: EdgeInsets.all(size.width * 0.02),
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
              SizedBox(height: size.height * 0.015),
              _isMobile(context)
                  ? Column(
                children: [
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: ref
                            .watch(personalDetailsProvider)
                            .isAgentAuthorized,
                        onChanged: (v) => ref
                            .read(personalDetailsProvider.notifier)
                            .updateIsAgentAuthorized(v!),
                      ),
                      const Text('Yes', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<bool>(
                        value: false,
                        groupValue: ref
                            .watch(personalDetailsProvider)
                            .isAgentAuthorized,
                        onChanged: (v) => ref
                            .read(personalDetailsProvider.notifier)
                            .updateIsAgentAuthorized(v!),
                      ),
                      const Text('No', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              )
                  : Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: ref
                        .watch(personalDetailsProvider)
                        .isAgentAuthorized,
                    onChanged: (v) => ref
                        .read(personalDetailsProvider.notifier)
                        .updateIsAgentAuthorized(v!),
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: _isTablet(context) ? 13 : 14,
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Radio<bool>(
                    value: false,
                    groupValue: ref
                        .watch(personalDetailsProvider)
                        .isAgentAuthorized,
                    onChanged: (v) => ref
                        .read(personalDetailsProvider.notifier)
                        .updateIsAgentAuthorized(v!),
                  ),
                  Text(
                    'No',
                    style: TextStyle(
                      fontSize: _isTablet(context) ? 13 : 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.03),
      ],
    );
  }

  Widget _buildActionButtons() {
    final size = MediaQuery.of(context).size;
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );

    return _isMobile(context)
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _isLoading ? null : () => _handleSubmission(true),
          style: buttonStyle.copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: size.height * 0.015),
            ),
          ),
          child: const Text(
            'Save & Exit',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        ElevatedButton(
          onPressed: _isLoading ? null : () => _handleSubmission(false),
          style: buttonStyle.copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: size.height * 0.015),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _isLoading ? null : () => _handleSubmission(true),
          style: buttonStyle.copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.height * 0.015,
              ),
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
        SizedBox(width: size.width * 0.02),
        ElevatedButton(
          onPressed: _isLoading ? null : () => _handleSubmission(false),
          style: buttonStyle.copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.height * 0.015,
              ),
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
  }
}