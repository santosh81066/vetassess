import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';
import '../models/tertiary_education_model.dart';
import '../providers/login_provider.dart';
import '../providers/tertiary_education_provider.dart';
import '../widgets/application_nav.dart';
import 'empoyment.dart';

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

  // Dropdown values and checkbox states
  String? awardingBodyCountry, institutionCountry, studyMode;
  bool internshipChecked = false,
      thesisChecked = false,
      majorProjectChecked = false;

  bool get anyCheckboxSelected =>
      internshipChecked || thesisChecked || majorProjectChecked;

  @override
  void initState() {
    super.initState();
    // Listen to provider state changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listen<TertiaryQualificationState>(tertiaryQualificationProvider, (
        previous,
        next,
      ) {
        if (next.isSuccess && previous?.isSuccess != true) {
          _showSuccessDialog();
        } else if (next.error != null && previous?.error != next.error) {
          _showErrorDialog(next.error!);
        }
      });
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
      return null; // Not required
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

    // Additional validation for dropdowns
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

    // Validate course length
    if (_controllers['courseLengthYears']!.text.isEmpty &&
        _controllers['courseLengthSemesters']!.text.isEmpty) {
      _showErrorDialog(
        'Please enter either course length in years or semesters.',
      );
      return false;
    }

    // Validate checkbox requirements
    if (anyCheckboxSelected &&
        _controllers['activityDetails']!.text.trim().isEmpty) {
      _showErrorDialog(
        'Activity details are required when additional requirements are selected.',
      );
      return false;
    }

    return true;
  }

  TertiaryQualificationRequest _createRequest(int userId) {
    String? _getTextOrNull(String key) =>
        _controllers[key]!.text.trim().isEmpty
            ? null
            : _controllers[key]!.text.trim();
    int? _getIntOrNull(String key) =>
        int.tryParse(_controllers[key]!.text.trim());

    return TertiaryQualificationRequest(
      userId: userId, // Use the passed userId instead of hardcoded value
      studentRegistrationNumber: _getTextOrNull('studentRegistration'),
      qualificationName: _controllers['qualificationName']!.text.trim(),
      majorField: _controllers['majorField']!.text.trim(),
      awardingBodyName: _controllers['awardingBodyName']!.text.trim(),
      awardingBodyCountry: awardingBodyCountry!,
      campusAttended: _getTextOrNull('campusAttended'),
      institutionName: _controllers['institutionName']!.text.trim(),
      streetAddress1: _controllers['streetAddress1']!.text.trim(),
      streetAddress2: _getTextOrNull('streetAddress2'),
      suburbCity: _controllers['suburbCity']!.text.trim(),
      state: _getTextOrNull('state'),
      postCode: _getTextOrNull('postCode'),
      institutionCountry: institutionCountry!,
      normalEntryRequirement:
          _controllers['normalEntryRequirement']!.text.trim(),
      entryBasis: _getTextOrNull('entryBasis'),
      courseLengthYearsOrSemesters:
          _controllers['courseLengthYears']!.text.trim().isNotEmpty
              ? _controllers['courseLengthYears']!.text.trim()
              : _controllers['courseLengthSemesters']!.text.trim(),
      semesterLengthWeeksOrMonths: "24",
      courseStartDate: _controllers['courseStartDate']!.text.trim(),
      courseEndDate: _controllers['courseEndDate']!.text.trim(),
      qualificationAwardedDate: _getTextOrNull('qualificationAwardedDate'),
      studyMode: studyMode!,
      hoursPerWeek: _getIntOrNull('hoursPerWeek') ?? 0,
      internshipWeeks:
          internshipChecked ? _getIntOrNull('internshipWeeks') : null,
      thesisWeeks: thesisChecked ? _getIntOrNull('thesisWeeks') : null,
      majorProjectWeeks:
          majorProjectChecked ? _getIntOrNull('majorProjectWeeks') : null,
      activityDetails:
          anyCheckboxSelected
              ? _controllers['activityDetails']!.text.trim()
              : null,
    );
  }

  Future<void> _submitForm() async {
    if (!_validateForm()) return;

    final userIdAsync = ref.read(userIdProvider);

    userIdAsync.when(
      data: (userId) async {
        if (userId == null) {
          _showErrorDialog('User session expired. Please login again.');
          return;
        }

        final request = _createRequest(userId);
        await ref
            .read(tertiaryQualificationProvider.notifier)
            .saveTertiaryQualification(request);
      },
      loading: () {
        // Handle loading state if needed
      },
      error: (error, stack) {
        _showErrorDialog(
          'Error retrieving user information. Please try again.',
        );
      },
    );
  }

  void _showSuccessDialog() {
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
                Navigator.of(context).pop();
                context.go('/employment_form');
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
                ref.read(tertiaryQualificationProvider.notifier).clearError();
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
    final providerState = ref.watch(tertiaryQualificationProvider);

    return LoginPageLayout(
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: const Align(
                  alignment: Alignment.topRight,
                  child: ApplicationNav(),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tertiary education',
                          style: TextStyle(
                            fontSize: 24,
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
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    '* ',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Required Fields',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Provide details of all completed post-secondary qualifications. VETASSESS will assess those qualifications necessary for the applicant to meet the minimum requirements of the nominated occupation.',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 24),
                              _buildSection('Qualification Details', [
                                _buildField(
                                  'Student registration number',
                                  'studentRegistration',
                                  200,
                                  helperText: '(if available)',
                                ),
                                _buildField(
                                  'Name of qualification obtained',
                                  'qualificationName',
                                  350,
                                  required: true,
                                  validator:
                                      (value) => _validateRequired(
                                        value,
                                        'Qualification name',
                                      ),
                                ),
                                _buildField(
                                  'Major field of study',
                                  'majorField',
                                  350,
                                  required: true,
                                  validator:
                                      (value) => _validateRequired(
                                        value,
                                        'Major field',
                                      ),
                                ),
                              ]),
                              _buildSection('Awarding Body Details', [
                                _buildField(
                                  'Name of awarding body',
                                  'awardingBodyName',
                                  350,
                                  required: true,
                                  validator:
                                      (value) => _validateRequired(
                                        value,
                                        'Awarding body name',
                                      ),
                                ),
                                _buildDropdownField(
                                  'Awarding Body Country',
                                  awardingBodyCountry,
                                  (v) =>
                                      setState(() => awardingBodyCountry = v),
                                  350,
                                  required: true,
                                ),
                                _buildField(
                                  'Campus you attended',
                                  'campusAttended',
                                  350,
                                ),
                                _buildField(
                                  'Name of institution you attended',
                                  'institutionName',
                                  350,
                                  required: true,
                                  validator:
                                      (value) => _validateRequired(
                                        value,
                                        'Institution name',
                                      ),
                                ),
                                _buildField(
                                  'Street address',
                                  'streetAddress1',
                                  280,
                                  required: true,
                                  validator:
                                      (value) => _validateRequired(
                                        value,
                                        'Street address',
                                      ),
                                ),
                                _buildField(
                                  'Street address second line',
                                  'streetAddress2',
                                  280,
                                ),
                                _buildField(
                                  'Suburb/City',
                                  'suburbCity',
                                  180,
                                  required: true,
                                  validator:
                                      (value) => _validateRequired(
                                        value,
                                        'Suburb/City',
                                      ),
                                ),
                                _buildField('State', 'state', 180),
                                _buildField('Post code', 'postCode', 180),
                                _buildDropdownField(
                                  'Campus/Institution Country',
                                  institutionCountry,
                                  (v) => setState(() => institutionCountry = v),
                                  350,
                                  required: true,
                                ),
                              ]),
                              _buildSection('Course Details', [
                                _buildField(
                                  'What was the normal entry requirement for\nthe course?',
                                  'normalEntryRequirement',
                                  250,
                                  required: true,
                                  validator:
                                      (value) => _validateRequired(
                                        value,
                                        'Normal entry requirement',
                                      ),
                                ),
                                _buildField(
                                  'If different, what was the basis of your entry into\nthe course?',
                                  'entryBasis',
                                  250,
                                ),
                                _buildCourseLengthField(),
                                _buildDateField(
                                  'Date course commenced',
                                  'courseStartDate',
                                  required: true,
                                ),
                                _buildDateField(
                                  'Date course completed',
                                  'courseEndDate',
                                  required: true,
                                ),
                                _buildDateField(
                                  'Date qualification awarded',
                                  'qualificationAwardedDate',
                                ),
                                _buildDropdownField(
                                  'Study Mode',
                                  studyMode,
                                  (v) => setState(() => studyMode = v),
                                  180,
                                  required: true,
                                  isStudyMode: true,
                                ),
                                _buildField(
                                  'Hours per week',
                                  'hoursPerWeek',
                                  180,
                                  required: true,
                                  validator:
                                      (value) => _validateNumber(
                                        value,
                                        'Hours per week',
                                      ),
                                ),
                              ]),
                              _buildAdditionalRequirementsSection(),
                              const SizedBox(height: 32),
                              _buildButtons(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
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
    String label,
    String key,
    double width, {
    bool required = false,
    String? helperText,
    String? Function(String?)? validator,
  }) {
    return _buildLabelledField(
      label,
      SizedBox(
        width: width,
        height: 34,
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

  Widget _buildDateField(String label, String key, {bool required = false}) {
    return _buildLabelledField(
      label,
      SizedBox(
        width: 180,
        height: 34,
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
    String label,
    String? value,
    ValueChanged<String?> onChanged,
    double width, {
    bool required = false,
    bool isStudyMode = false,
  }) {
    final items =
        isStudyMode
            ? ['Full-time', 'Part-time', 'Other']
            : ['India', 'USA', 'UK', 'Australia', 'Canada'];

    return _buildLabelledField(
      label,
      SizedBox(
        width: width,
        height: 34,
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: _inputDecoration(),
          hint: const Text('Select one'),
          items:
              items
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

  Widget _buildCourseLengthField() {
    return _buildFormRow(
      'Normal length of full-time course',
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _controllers['courseLengthYears'],
                  decoration: _inputDecoration(),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              const Text('OR', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 12),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: _controllers['courseLengthSemesters'],
                  decoration: _inputDecoration(),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  'Years',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(width: 12),
              Text('  '),
              SizedBox(width: 12),
              SizedBox(
                width: 60,
                child: Text(
                  'Semesters',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
      isRequired: true,
    );
  }

  Widget _buildAdditionalRequirementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Course Requirements',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4D4D4D),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Were you required to complete any of the following before receiving the qualification?',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        _buildCheckboxWithWeeks(
          'An internship, supervised practical training or work placement',
          internshipChecked,
          'internshipWeeks',
          (v) => setState(() => internshipChecked = v ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxWithWeeks(
          'A thesis',
          thesisChecked,
          'thesisWeeks',
          (v) => setState(() => thesisChecked = v ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxWithWeeks(
          'A major project',
          majorProjectChecked,
          'majorProjectWeeks',
          (v) => setState(() => majorProjectChecked = v ?? false),
        ),
        if (anyCheckboxSelected) ...[
          const SizedBox(height: 16),
          _buildLabelledField(
            'Activity details (including dates)',
            SizedBox(
              width: 600,
              child: TextFormField(
                controller: _controllers['activityDetails'],
                maxLines: 5,
                decoration: _inputDecoration(),
                validator:
                    anyCheckboxSelected
                        ? (value) =>
                            _validateRequired(value, 'Activity details')
                        : null,
              ),
            ),
            isRequired: true,
          ),
        ],
      ],
    );
  }

  Widget _buildCheckboxWithWeeks(
    String label,
    bool value,
    String weeksKey,
    ValueChanged<bool?> onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        const SizedBox(width: 16),
        if (value) ...[
          const Text('Number of weeks spent', style: TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            height: 30,
            child: TextFormField(
              controller: _controllers[weeksKey],
              decoration: _inputDecoration(),
              keyboardType: TextInputType.number,
              validator:
                  value
                      ? (val) => _validateNumber(val, 'Number of weeks')
                      : null,
            ),
          ),
          const SizedBox(width: 16),
        ],
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(value: value, onChanged: onChanged),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    final providerState = ref.watch(tertiaryQualificationProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.teal),
            foregroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed:
              providerState.isLoading
                  ? null
                  : () {
                    // Reset form or navigate back
                    ref
                        .read(tertiaryQualificationProvider.notifier)
                        .resetState();
                    context.pop();
                  },
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed: providerState.isLoading ? null : _submitForm,
          child:
              providerState.isLoading
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : const Text('Save & Continue'),
        ),
      ],
    );
  }

  Widget _buildLabelledField(
    String label,
    Widget field, {
    bool isRequired = false,
    String? helperText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 12,
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: const TextStyle(fontSize: 14)),
                  if (isRequired)
                    const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                field,
                if (helperText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      helperText,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormRow(String label, Widget field, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 12,
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: const TextStyle(fontSize: 14)),
                  if (isRequired)
                    const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(flex: 20, child: field),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      hintText: hintText,
      isDense: true,
    );
  }
}
