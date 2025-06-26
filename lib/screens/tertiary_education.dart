import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/models/tertiary_education_model.dart';
import 'package:vetassess/widgets/login_page_layout.dart';
import '../providers/login_provider.dart';
import '../providers/tertiary_education_provider.dart';
import '../widgets/application_nav.dart';

class TertiaryEducationForm extends ConsumerStatefulWidget {
  const TertiaryEducationForm({super.key});

  @override
  ConsumerState<TertiaryEducationForm> createState() =>
      _TertiaryEducationFormState();
}

class _TertiaryEducationFormState extends ConsumerState<TertiaryEducationForm> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _controllers = <String, TextEditingController>{
    'studentRegistration': TextEditingController(),
    'qualificationName': TextEditingController(),
    'majorField': TextEditingController(),
    'awardingBodyName': TextEditingController(),
    'campusAttended': TextEditingController(),
    'institutionName': TextEditingController(),
    'streetAddress1': TextEditingController(),
    'streetAddress2': TextEditingController(),
    'suburbCity': TextEditingController(),
    'state': TextEditingController(),
    'postCode': TextEditingController(),
    'normalEntryRequirement': TextEditingController(),
    'entryBasis': TextEditingController(),
    'courseLengthYears': TextEditingController(),
    'courseLengthSemesters': TextEditingController(),
    'courseStartDate': TextEditingController(),
    'courseEndDate': TextEditingController(),
    'qualificationAwardedDate': TextEditingController(),
    'hoursPerWeek': TextEditingController(),
    'internshipWeeks': TextEditingController(),
    'thesisWeeks': TextEditingController(),
    'majorProjectWeeks': TextEditingController(),
    'activityDetails': TextEditingController(),
  };

  int? get _currentUserId {
    final loginState = ref.read(loginProvider);
    return loginState.response?.userId;
  }

  // Dropdown values and checkbox states
  String? awardingBodyCountry, institutionCountry, studyMode;
  bool internshipChecked = false,
      thesisChecked = false,
      majorProjectChecked = false;

  bool get anyCheckboxSelected =>
      internshipChecked || thesisChecked || majorProjectChecked;

  // Responsive helper methods
  double _getFieldWidth(BuildContext context, double baseWidth) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth * 0.7 * 0.6; // 60% of the right column

    if (screenWidth < 768) {
      return availableWidth * 0.9;
    } else if (screenWidth < 1024) {
      return baseWidth * 0.8;
    }
    return baseWidth;
  }

  double _getNavWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 768) {
      return screenWidth * 0.25;
    } else if (screenWidth < 1024) {
      return screenWidth * 0.28;
    }
    return screenWidth * 0.3;
  }

  double _getFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 768) {
      return baseSize * 0.9;
    }
    return baseSize;
  }

  EdgeInsets _getMargin(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 768) {
      return const EdgeInsets.all(8.0);
    } else if (screenWidth < 1024) {
      return const EdgeInsets.all(12.0);
    }
    return const EdgeInsets.all(16.0);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tertiaryEducationProvider.notifier).resetState();
    });
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateDate(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegex.hasMatch(value.trim())) {
      return 'Please enter date in YYYY-MM-DD format';
    }
    return null;
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (int.tryParse(value.trim()) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  bool _validateForm() {
    if (!_formKey.currentState!.validate()) {
      _showErrorDialog('Please fix the validation errors before submitting.');
      return false;
    }

    if (awardingBodyCountry == null) {
      _showErrorDialog('Please select Awarding Body Country.');
      return false;
    }
    if (institutionCountry == null) {
      _showErrorDialog('Please select Campus/Institution Country.');
      return false;
    }
    if (studyMode == null) {
      _showErrorDialog('Please select Study Mode.');
      return false;
    }

    if (_controllers['courseLengthYears']!.text.isEmpty &&
        _controllers['courseLengthSemesters']!.text.isEmpty) {
      _showErrorDialog(
        'Please enter either course length in years or semesters.',
      );
      return false;
    }

    if (anyCheckboxSelected &&
        _controllers['activityDetails']!.text.trim().isEmpty) {
      _showErrorDialog(
        'Activity details are required when additional requirements are selected.',
      );
      return false;
    }

    return true;
  }

  Map<String, dynamic> _createFormData() {
    final formData = <String, dynamic>{};

    _controllers.forEach((key, controller) {
      formData[key] = controller.text.trim();
    });

    formData['awardingBodyCountry'] = awardingBodyCountry;
    formData['institutionCountry'] = institutionCountry;
    formData['studyMode'] = studyMode;

    formData['internshipChecked'] = internshipChecked;
    formData['thesisChecked'] = thesisChecked;
    formData['majorProjectChecked'] = majorProjectChecked;

    return formData;
  }

  Future<void> _submitForm() async {
    if (!_validateForm()) return;

    final userId = _currentUserId;
    if (userId == null) {
      _showErrorDialog('User session expired. Please login again.');
      return;
    }

    final formData = _createFormData();
    await ref.read(tertiaryEducationProvider.notifier).submitTertiaryEducation(
      userId: userId,
      formData: formData,
    );
  }

  void _showSuccessDialog() {
    print('_showSuccessDialog called');

    if (!mounted) {
      print('Widget not mounted, skipping dialog');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('Success'),
            ],
          ),
          content: const Text(
            'Tertiary qualification has been saved successfully!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                print('Continue button pressed');
                Navigator.of(context).pop();

                ref.read(tertiaryEducationProvider.notifier).resetState();

                print('Navigating to /doc_upload');
                context.go('/doc_upload');
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error, color: Colors.red, size: 28),
              SizedBox(width: 8),
              Text('Error'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(tertiaryEducationProvider.notifier).clearError();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<TertiaryEducationState>(tertiaryEducationProvider, (previous, next) {
      if (next.isSuccess && (previous?.isSuccess != true)) {
        print('Triggering success dialog');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showSuccessDialog();
        });
      }
      else if (next.errorMessage != null &&
          next.errorMessage!.isNotEmpty &&
          previous?.errorMessage != next.errorMessage) {
        print('Triggering error dialog');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showErrorDialog(next.errorMessage!);
        });
      }
    });

    final providerState = ref.watch(tertiaryEducationProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return LoginPageLayout(
      child: Stack(
        children: [
          // Use LayoutBuilder for better responsive handling
          LayoutBuilder(
            builder: (context, constraints) {
              // Switch to column layout on small screens
              if (screenWidth < 768) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: const ApplicationNav(),
                      ),
                      Container(
                        margin: _getMargin(context),
                        child: _buildFormContent(context),
                      ),
                    ],
                  ),
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: _getNavWidth(context),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: ApplicationNav(),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: _getMargin(context),
                          child: _buildFormContent(context),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          // Loading overlay
          if (providerState.isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Saving qualification...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tertiary education',
            style: TextStyle(
              fontSize: _getFontSize(context, 24),
              fontWeight: FontWeight.w500,
              color: Color(0xFF4D4D4D),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: _getMargin(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '* ',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: _getFontSize(context, 14),
                      ),
                    ),
                    Text(
                      'Required Fields',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: _getFontSize(context, 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Provide details of all completed post-secondary qualifications. VETASSESS will assess those qualifications necessary for the applicant to meet the minimum requirements of the nominated occupation.',
                  style: TextStyle(fontSize: _getFontSize(context, 14)),
                ),
                const SizedBox(height: 24),
                _buildSection(context, 'Qualification Details', [
                  _buildField(
                    context,
                    'Student registration number',
                    'studentRegistration',
                    200,
                    helperText: '(if available)',
                  ),
                  _buildField(
                    context,
                    'Name of qualification obtained',
                    'qualificationName',
                    350,
                    required: true,
                    validator: (value) => _validateRequired(
                      value,
                      'Qualification name',
                    ),
                  ),
                  _buildField(
                    context,
                    'Major field of study',
                    'majorField',
                    350,
                    required: true,
                    validator: (value) => _validateRequired(
                      value,
                      'Major field',
                    ),
                  ),
                ]),
                _buildSection(context, 'Awarding Body Details', [
                  _buildField(
                    context,
                    'Name of awarding body',
                    'awardingBodyName',
                    350,
                    required: true,
                    validator: (value) => _validateRequired(
                      value,
                      'Awarding body name',
                    ),
                  ),
                  _buildDropdownField(
                    context,
                    'Awarding Body Country',
                    awardingBodyCountry,
                        (v) => setState(() => awardingBodyCountry = v),
                    350,
                    required: true,
                  ),
                  _buildField(
                    context,
                    'Campus you attended',
                    'campusAttended',
                    350,
                  ),
                  _buildField(
                    context,
                    'Name of institution you attended',
                    'institutionName',
                    350,
                    required: true,
                    validator: (value) => _validateRequired(
                      value,
                      'Institution name',
                    ),
                  ),
                  _buildField(
                    context,
                    'Street address',
                    'streetAddress1',
                    280,
                    required: true,
                    validator: (value) => _validateRequired(
                      value,
                      'Street address',
                    ),
                  ),
                  _buildField(
                    context,
                    'Street address second line',
                    'streetAddress2',
                    280,
                  ),
                  _buildField(
                    context,
                    'Suburb/City',
                    'suburbCity',
                    180,
                    required: true,
                    validator: (value) => _validateRequired(
                      value,
                      'Suburb/City',
                    ),
                  ),
                  _buildField(context, 'State', 'state', 180),
                  _buildField(context, 'Post code', 'postCode', 180),
                  _buildDropdownField(
                    context,
                    'Campus/Institution Country',
                    institutionCountry,
                        (v) => setState(() => institutionCountry = v),
                    350,
                    required: true,
                  ),
                ]),
                _buildSection(context, 'Course Details', [
                  _buildField(
                    context,
                    'What was the normal entry requirement for\nthe course?',
                    'normalEntryRequirement',
                    250,
                    required: true,
                    validator: (value) => _validateRequired(
                      value,
                      'Normal entry requirement',
                    ),
                  ),
                  _buildField(
                    context,
                    'If different, what was the basis of your entry into\nthe course?',
                    'entryBasis',
                    250,
                  ),
                  _buildCourseLengthField(context),
                  _buildDateField(
                    context,
                    'Date course commenced',
                    'courseStartDate',
                    required: true,
                  ),
                  _buildDateField(
                    context,
                    'Date course completed',
                    'courseEndDate',
                    required: true,
                  ),
                  _buildDateField(
                    context,
                    'Date qualification awarded',
                    'qualificationAwardedDate',
                  ),
                  _buildDropdownField(
                    context,
                    'Study Mode',
                    studyMode,
                        (v) => setState(() => studyMode = v),
                    180,
                    required: true,
                    isStudyMode: true,
                  ),
                  _buildField(
                    context,
                    'Hours per week',
                    'hoursPerWeek',
                    180,
                    required: true,
                    validator: (value) => _validateNumber(
                      value,
                      'Hours per week',
                    ),
                  ),
                ]),
                _buildAdditionalRequirementsSection(context),
                const SizedBox(height: 32),
                _buildButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: _getFontSize(context, 18),
            fontWeight: FontWeight.w500,
            color: Color(0xFF4D4D4D),
          ),
        ),
        const SizedBox(height: 16),
        ...children,
        const SizedBox(height: 16),
        const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildField(
      BuildContext context,
      String label,
      String key,
      double baseWidth, {
        bool required = false,
        String? helperText,
        String? Function(String?)? validator,
      }) {
    return _buildLabelledField(
      context,
      label,
      SizedBox(
        width: _getFieldWidth(context, baseWidth),
        // Remove fixed height to allow error text space
        child: TextFormField(
          controller: _controllers[key],
          decoration: _inputDecoration(),
          validator: validator,
        ),
      ),
      isRequired: required,
      helperText: helperText,
    );
  }

  Widget _buildDateField(BuildContext context, String label, String key, {bool required = false}) {
    return _buildLabelledField(
      context,
      label,
      SizedBox(
        width: _getFieldWidth(context, 180),
        // Remove fixed height to allow error text space
        child: TextFormField(
          controller: _controllers[key],
          decoration: _inputDecoration(hintText: 'yyyy-mm-dd'),
          validator: required ? (value) => _validateDate(value, label) : null,
          readOnly: true,
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Colors.black,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              _controllers[key]!.text =
              "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
            }
          },
        ),
      ),
      isRequired: required,
    );
  }

  Widget _buildDropdownField(
      BuildContext context,
      String label,
      String? value,
      ValueChanged<String?> onChanged,
      double baseWidth, {
        bool required = false,
        bool isStudyMode = false,
      }) {
    final items = isStudyMode
        ? ['Full-time', 'Part-time', 'Other']
        : ['India', 'USA', 'UK', 'Australia', 'Canada'];

    return _buildLabelledField(
      context,
      label,
      SizedBox(
        width: _getFieldWidth(context, baseWidth),
        // Remove fixed height to allow error text space
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: _inputDecoration(),
          hint: const Text('Select one'),
          validator: required
              ? (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }
            return null;
          }
              : null,
          items: items
              .map(
                (item) => DropdownMenuItem(value: item, child: Text(item)),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ),
      isRequired: required,
    );
  }

  Widget _buildAdditionalRequirementsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Additional Course Requirements',
          style: TextStyle(
            fontSize: _getFontSize(context, 18),
            fontWeight: FontWeight.w500,
            color: Color(0xFF4D4D4D),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Were you required to complete any of the following before receiving the qualification?',
          style: TextStyle(fontSize: _getFontSize(context, 14)),
        ),
        const SizedBox(height: 16),
        _buildCheckboxWithWeeks(
          context,
          'An internship, supervised practical training or work placement',
          internshipChecked,
          'internshipWeeks',
              (v) => setState(() => internshipChecked = v ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxWithWeeks(
          context,
          'A thesis',
          thesisChecked,
          'thesisWeeks',
              (v) => setState(() => thesisChecked = v ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxWithWeeks(
          context,
          'A major project',
          majorProjectChecked,
          'majorProjectWeeks',
              (v) => setState(() => majorProjectChecked = v ?? false),
        ),
        if (anyCheckboxSelected) ...[
          const SizedBox(height: 16),
          _buildLabelledField(
            context,
            'Activity details (including dates)',
            SizedBox(
              width: _getFieldWidth(context, 600),
              child: TextFormField(
                controller: _controllers['activityDetails'],
                maxLines: 5,
                decoration: _inputDecoration(),
                validator: anyCheckboxSelected
                    ? (value) => _validateRequired(value, 'Activity details')
                    : null,
              ),
            ),
            isRequired: true,
          ),
        ],
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    final providerState = ref.watch(tertiaryEducationProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 768;

    return Flex(
      direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.teal),
            foregroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed: providerState.isLoading
              ? null
              : () {
            // Clear form and reset state
            _controllers.values.forEach((controller) => controller.clear());
            setState(() {
              awardingBodyCountry = null;
              institutionCountry = null;
              studyMode = null;
              internshipChecked = false;
              thesisChecked = false;
              majorProjectChecked = false;
            });
            ref.read(tertiaryEducationProvider.notifier).resetState();
          },
          child: const Text('Clear'),
        ),
        SizedBox(width: isSmallScreen ? 0 : 16, height: isSmallScreen ? 12 : 0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          onPressed: providerState.isLoading ? null : _submitForm,
          child: providerState.isLoading
              ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : const Text('Save and Continue'),
        ),
      ],
    );
  }

  Widget _buildLabelledField(
      BuildContext context,
      String label,
      Widget field, {
        bool isRequired = false,
        String? helperText,
      }) {
    return _buildFormRow(
      context,
      label,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          field,
          if (helperText != null) ...[
            const SizedBox(height: 4),
            Text(
              helperText,
              style: TextStyle(
                fontSize: _getFontSize(context, 12),
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
      isRequired: isRequired,
    );
  }

  Widget _buildFormRow(
      BuildContext context,
      String label,
      Widget field, {
        bool isRequired = false,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 768;

    if (isSmallScreen) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (isRequired)
                  Text(
                    '* ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: _getFontSize(context, 14),
                    ),
                  ),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: _getFontSize(context, 14),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4D4D4D),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            field,
          ],
        ),
      );
    }

    // Desktop layout - right-align the field to the label
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label section - takes up left portion
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Right align the label
                children: [
                  if (isRequired)
                    Text(
                      '* ',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: _getFontSize(context, 14),
                      ),
                    ),
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: _getFontSize(context, 14),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4D4D4D),
                      ),
                      textAlign: TextAlign.right, // Right align text
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Field section - takes up right portion
          Expanded(
            flex: 2,
            child: field,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxWithWeeks(
      BuildContext context,
      String label,
      bool value,
      String weeksKey,
      ValueChanged<bool?> onChanged,
      ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 768;

    if (isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                    label,
                    style: TextStyle(fontSize: _getFontSize(context, 14))
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(value: value, onChanged: onChanged),
              ),
            ],
          ),
          if (value) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                    'Number of weeks spent',
                    style: TextStyle(fontSize: _getFontSize(context, 12))
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  // Remove fixed height to allow error text space
                  child: TextFormField(
                    controller: _controllers[weeksKey],
                    decoration: _inputDecoration(),
                    keyboardType: TextInputType.number,
                    validator: value
                        ? (val) => _validateNumber(val, 'Number of weeks')
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ],
      );
    }

    // Desktop layout - right-aligned like other fields
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Changed from center to start for error text alignment
        children: [
          // Label section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0), // Added top padding
              child: Text(
                label,
                style: TextStyle(fontSize: _getFontSize(context, 14)),
                textAlign: TextAlign.right, // Right align text
              ),
            ),
          ),
          // Field section
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to start for error text
              children: [
                if (value) ...[
                  Text(
                    'Number of weeks spent',
                    style: TextStyle(fontSize: _getFontSize(context, 12)),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 60,
                    // Remove fixed height to allow error text space
                    child: TextFormField(
                      controller: _controllers[weeksKey],
                      decoration: _inputDecoration(),
                      keyboardType: TextInputType.number,
                      validator: value
                          ? (val) => _validateNumber(val, 'Number of weeks')
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 8.0), // Add padding to align with field
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(value: value, onChanged: onChanged),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseLengthField(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 768;

    return _buildFormRow(
      context,
      'Normal length of full-time course',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: isSmallScreen ? _getFieldWidth(context, 120) : 60,
                // Remove fixed height to allow error text space
                child: TextFormField(
                  controller: _controllers['courseLengthYears'],
                  decoration: _inputDecoration(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    // Only validate if both fields are empty
                    if ((value == null || value.trim().isEmpty) &&
                        (_controllers['courseLengthSemesters']!.text.isEmpty)) {
                      return 'Required';
                    }
                    if (value != null && value.trim().isNotEmpty) {
                      final number = int.tryParse(value.trim());
                      if (number == null || number <= 0) {
                        return 'Invalid';
                      }
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: isSmallScreen ? 0 : 12, height: isSmallScreen ? 8 : 0),
              Text('OR', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _getFontSize(context, 14),
              )),
              SizedBox(width: isSmallScreen ? 0 : 12, height: isSmallScreen ? 8 : 0),
              SizedBox(
                width: isSmallScreen ? _getFieldWidth(context, 120) : 60,
                // Remove fixed height to allow error text space
                child: TextFormField(
                  controller: _controllers['courseLengthSemesters'],
                  decoration: _inputDecoration(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    // Only validate if both fields are empty
                    if ((value == null || value.trim().isEmpty) &&
                        (_controllers['courseLengthYears']!.text.isEmpty)) {
                      return 'Required';
                    }
                    if (value != null && value.trim().isNotEmpty) {
                      final number = int.tryParse(value.trim());
                      if (number == null || number <= 0) {
                        return 'Invalid';
                      }
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Flex(
            direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
            children: [
              SizedBox(
                width: isSmallScreen ? _getFieldWidth(context, 120) : 60,
                child: Text(
                  'Years',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: _getFontSize(context, 12)),
                ),
              ),
              SizedBox(width: isSmallScreen ? 0 : 12, height: isSmallScreen ? 4 : 0),
              if (!isSmallScreen) const Text('  '),
              SizedBox(width: isSmallScreen ? 0 : 12, height: isSmallScreen ? 4 : 0),
              SizedBox(
                width: isSmallScreen ? _getFieldWidth(context, 120) : 60,
                child: Text(
                  'Semesters',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: _getFontSize(context, 12)),
                ),
              ),
            ],
          ),
        ],
      ),
      isRequired: true,
    );
  }

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 14,
      ),
      // Add proper error text styling
      errorStyle: const TextStyle(fontSize: 12, height: 1.2),
      isDense: true,
    );
  }
}