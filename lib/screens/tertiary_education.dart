import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';
import '../widgets/application_nav.dart';
import '../providers/tertiary_education_provider.dart';
import '../models/tertiary_education_model.dart';

class TertiaryEducationForm extends ConsumerStatefulWidget {
  const TertiaryEducationForm({super.key});

  @override
  ConsumerState<TertiaryEducationForm> createState() =>
      _TertiaryEducationFormState();
}

class _TertiaryEducationFormState extends ConsumerState<TertiaryEducationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _fieldErrors = {};

  @override
  void initState() {
    super.initState();
    // Reset form and API state when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tertiaryEducationFormProvider.notifier).resetForm();
      ref.read(tertiaryEducationProvider.notifier).resetState();
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Education qualification saved successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.go('/employment_form');
                },
                child: const Text('Continue'),
              ),
            ],
          ),
    );
  }

  Future<void> _handleSubmit() async {
    // Clear previous field errors
    setState(() {
      _fieldErrors = {};
    });

    final formData = ref.read(tertiaryEducationFormProvider);
    final formNotifier = ref.read(tertiaryEducationFormProvider.notifier);

    // Validate form
    final errors = formNotifier.validateForm();
    if (errors.isNotEmpty) {
      setState(() {
        _fieldErrors = errors;
      });
      return;
    }

    // TODO: Get actual user ID from authentication state
    const int userId = 3; // Replace with actual user ID

    final request = formNotifier.toRequest(userId);
    await ref
        .read(tertiaryEducationProvider.notifier)
        .submitTertiaryEducation(request);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;
    final isTablet = screenWidth > 768 && screenWidth <= 1200;

    final apiState = ref.watch(tertiaryEducationProvider);
    final formData = ref.watch(tertiaryEducationFormProvider);

    // Listen to API state changes
    ref.listen<TertiaryEducationState>(tertiaryEducationProvider, (
      previous,
      next,
    ) {
      if (next.isSuccess) {
        _showSuccessDialog();
      } else if (next.error != null) {
        _showErrorDialog(next.error!);
      }
    });

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width:
                isMobile
                    ? screenWidth * 0.25
                    : isTablet
                    ? screenWidth * 0.28
                    : screenWidth * 0.3,
            child: Align(
              alignment: Alignment.topRight,
              child: ApplicationNav(),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(isMobile ? 8.0 : 16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tertiary education',
                        style: TextStyle(
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4D4D4D),
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRequiredFieldsHeader(),
                            SizedBox(height: isMobile ? 16 : 24),

                            ..._buildSection('Qualification Details', [
                              _buildField(
                                'Student registration number',
                                helper: '(if available)',
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateStudentRegistrationNumber,
                                value: formData.studentRegistrationNumber,
                              ),
                              _buildField(
                                'Name of qualification obtained',
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateQualificationName,
                                value: formData.qualificationName,
                                errorText: _fieldErrors['qualificationName'],
                              ),
                              _buildField(
                                'Major field of study',
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateMajorField,
                                value: formData.majorField,
                                errorText: _fieldErrors['majorField'],
                              ),
                            ]),

                            ..._buildSection('Awarding Body Details', [
                              _buildField(
                                'Name of awarding body',
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateAwardingBodyName,
                                value: formData.awardingBodyName,
                                errorText: _fieldErrors['awardingBodyName'],
                              ),
                              _buildField(
                                'Awarding Body Country',
                                isDropdown: true,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateAwardingBodyCountry,
                                value: formData.awardingBodyCountry,
                                errorText: _fieldErrors['awardingBodyCountry'],
                                dropdownItems: countryOptions,
                              ),
                              _buildField(
                                'Campus you attended',
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateCampusAttended,
                                value: formData.campusAttended,
                              ),
                              _buildField(
                                'Name of institution you attended',
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateInstitutionName,
                                value: formData.institutionName,
                              ),
                              _buildField(
                                'Street address',
                                width: isMobile ? 180 : 280,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateStreetAddress1,
                                value: formData.streetAddress1,
                                errorText: _fieldErrors['streetAddress1'],
                              ),
                              _buildField(
                                'Street address second line',
                                width: isMobile ? 180 : 280,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateStreetAddress2,
                                value: formData.streetAddress2,
                              ),
                              _buildField(
                                'Suburb/City',
                                width: isMobile ? 140 : 180,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateSuburbCity,
                                value: formData.suburbCity,
                                errorText: _fieldErrors['suburbCity'],
                              ),
                              _buildField(
                                'State',
                                width: isMobile ? 140 : 180,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateState,
                                value: formData.state,
                              ),
                              _buildField(
                                'Post code',
                                width: isMobile ? 140 : 180,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updatePostCode,
                                value: formData.postCode,
                              ),
                              _buildField(
                                'Campus/Institution Country',
                                isDropdown: true,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateInstitutionCountry,
                                value: formData.institutionCountry,
                                errorText: _fieldErrors['institutionCountry'],
                                dropdownItems: countryOptions,
                              ),
                            ]),

                            ..._buildSection('Course Details', [
                              _buildField(
                                'What was the normal entry requirement for the course?',
                                width: isMobile ? 180 : 250,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateNormalEntryRequirement,
                                value: formData.normalEntryRequirement,
                                errorText:
                                    _fieldErrors['normalEntryRequirement'],
                              ),
                              _buildField(
                                'If different, what was the basis of your entry into the course?',
                                width: isMobile ? 180 : 250,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateEntryBasis,
                                value: formData.entryBasis,
                              ),
                              _buildCourseLanguageRow(),
                              _buildField(
                                'Semester/Term length',
                                width: isMobile ? 140 : 180,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateSemesterLengthWeeksOrMonths,
                                value: formData.semesterLengthWeeksOrMonths,
                                helper: 'e.g., "24 weeks" or "6 months"',
                              ),
                              _buildField(
                                'Date course commenced',
                                isDate: true,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateCourseStartDate,
                                value: formData.courseStartDate,
                                errorText: _fieldErrors['courseStartDate'],
                              ),
                              _buildField(
                                'Date course completed',
                                isDate: true,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateCourseEndDate,
                                value: formData.courseEndDate,
                                errorText: _fieldErrors['courseEndDate'],
                              ),
                              _buildField(
                                'Date qualification awarded',
                                isDate: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateQualificationAwardedDate,
                                value: formData.qualificationAwardedDate,
                              ),
                              _buildField(
                                'Study Mode',
                                isDropdown: true,
                                width: isMobile ? 140 : 180,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateStudyMode,
                                value: formData.studyMode,
                                errorText: _fieldErrors['studyMode'],
                                dropdownItems: studyModeOptions,
                              ),
                              _buildField(
                                'Hours per week',
                                width: isMobile ? 140 : 180,
                                required: true,
                                onChanged:
                                    ref
                                        .read(
                                          tertiaryEducationFormProvider
                                              .notifier,
                                        )
                                        .updateHoursPerWeek,
                                value: formData.hoursPerWeek,
                                errorText: _fieldErrors['hoursPerWeek'],
                                isNumeric: true,
                              ),
                            ]),

                            ..._buildSection('Additional Course Requirements', [
                              Text(
                                'Were you required to complete any of the following before receiving the qualification?',
                                style: TextStyle(fontSize: isMobile ? 12 : 14),
                              ),
                              if (_fieldErrors['courseLength'] != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    _fieldErrors['courseLength']!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              SizedBox(height: isMobile ? 12 : 16),
                              _buildCheckboxWithWeeks(
                                'An internship, supervised practical training or work placement',
                                formData.hasInternship,
                                formData.internshipWeeks,
                                (value) => ref
                                    .read(
                                      tertiaryEducationFormProvider.notifier,
                                    )
                                    .updateHasInternship(value),
                                (weeks) => ref
                                    .read(
                                      tertiaryEducationFormProvider.notifier,
                                    )
                                    .updateInternshipWeeks(weeks),
                              ),
                              _buildCheckboxWithWeeks(
                                'A thesis',
                                formData.hasThesis,
                                formData.thesisWeeks,
                                (value) => ref
                                    .read(
                                      tertiaryEducationFormProvider.notifier,
                                    )
                                    .updateHasThesis(value),
                                (weeks) => ref
                                    .read(
                                      tertiaryEducationFormProvider.notifier,
                                    )
                                    .updateThesisWeeks(weeks),
                              ),
                              _buildCheckboxWithWeeks(
                                'A major project',
                                formData.hasMajorProject,
                                formData.majorProjectWeeks,
                                (value) => ref
                                    .read(
                                      tertiaryEducationFormProvider.notifier,
                                    )
                                    .updateHasMajorProject(value),
                                (weeks) => ref
                                    .read(
                                      tertiaryEducationFormProvider.notifier,
                                    )
                                    .updateMajorProjectWeeks(weeks),
                              ),
                            ]),

                            SizedBox(height: isMobile ? 24 : 32),
                            _buildButtons(apiState.isLoading),
                          ],
                        ),
                      ),
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

  Widget _buildRequiredFieldsHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              '* ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              'Required Fields',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Provide details of all completed post-secondary qualifications. VETASSESS will assess those qualifications necessary for the applicant to meet the minimum requirements of the nominated occupation.',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width <= 768 ? 12 : 14,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSection(String title, List<Widget> fields) {
    final isMobile = MediaQuery.of(context).size.width <= 768;
    return [
      Text(
        title,
        style: TextStyle(
          fontSize: isMobile ? 16 : 18,
          fontWeight: FontWeight.w500,
          color: Color(0xFF4D4D4D),
        ),
      ),
      SizedBox(height: isMobile ? 12 : 16),
      ...fields,
      SizedBox(height: isMobile ? 12 : 16),
      const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
      SizedBox(height: isMobile ? 12 : 16),
    ];
  }

  Widget _buildField(
    String label, {
    bool required = false,
    bool isDropdown = false,
    bool isDate = false,
    bool isNumeric = false,
    double? width,
    String? helper,
    String? value,
    String? errorText,
    Function(String?)?
    onChanged, // Changed from Function(String)? to Function(String?)?
    List<String>? dropdownItems,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;

    Widget field;
    if (isDate) {
      field = _buildDateField(value: value, onChanged: onChanged);
    } else if (isDropdown) {
      field = _buildDropdown(
        width ?? (isMobile ? 200 : 350),
        value: value,
        onChanged: onChanged,
        items: dropdownItems ?? [],
      );
    } else {
      field = _buildTextField(
        width ?? (isMobile ? 200 : 350),
        value: value,
        onChanged: onChanged,
        isNumeric: isNumeric,
      );
    }

    return _buildResponsiveLayout(
      label,
      field,
      required: required,
      helper: helper,
      errorText: errorText,
    );
  }

  Widget _buildResponsiveLayout(
    String label,
    Widget field, {
    bool required = false,
    String? helper,
    String? errorText,
  }) {
    final isMobile = MediaQuery.of(context).size.width <= 768;

    Widget helperAndError = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (helper != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              helper,
              style: TextStyle(
                fontSize: isMobile ? 10 : 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText,
              style: TextStyle(fontSize: isMobile ? 10 : 12, color: Colors.red),
            ),
          ),
      ],
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 12),
                    softWrap: true,
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
            const SizedBox(height: 8),
            field,
            helperAndError,
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 12,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.right,
                        softWrap: true,
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
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [field, helperAndError],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    double width, {
    String? value,
    Function(String?)?
    onChanged, // Changed from Function(String)? to Function(String?)?
    bool isNumeric = false,
  }) {
    final isMobile = MediaQuery.of(context).size.width <= 768;
    return SizedBox(
      width: isMobile ? MediaQuery.of(context).size.width * 0.6 : width,
      height: isMobile ? 30 : 34,
      child: TextFormField(
        initialValue: value,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 10,
            vertical: isMobile ? 8 : 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildDropdown(
    double width, {
    String? value,
    Function(String?)? onChanged,
    List<String> items = const [],
  }) {
    final isMobile = MediaQuery.of(context).size.width <= 768;
    return SizedBox(
      width: isMobile ? MediaQuery.of(context).size.width * 0.6 : width,
      height: isMobile ? 30 : 34,
      child: DropdownButtonFormField<String>(
        value: value?.isEmpty == true ? null : value,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 10,
            vertical: isMobile ? 8 : 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        hint: Text(
          'Select one',
          style: TextStyle(fontSize: isMobile ? 12 : 14),
        ),
        items:
            items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                ),
              );
            }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  //
  Widget _buildDateField({String? value, Function(String?)? onChanged}) {
    final isMobile = MediaQuery.of(context).size.width <= 768;
    return SizedBox(
      width: isMobile ? MediaQuery.of(context).size.width * 0.4 : 180,
      height: isMobile ? 30 : 34,
      child: TextFormField(
        initialValue: value,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 10,
            vertical: isMobile ? 8 : 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: 'yyyy/mm/dd',
          hintStyle: TextStyle(fontSize: isMobile ? 10 : 12),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildCourseLanguageRow() {
    final isMobile = MediaQuery.of(context).size.width <= 768;
    final formData = ref.watch(tertiaryEducationFormProvider);

    Widget courseFields = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: isMobile ? 50 : 60,
              child: TextFormField(
                initialValue: formData.courseLengthYears,
                onChanged:
                    ref
                        .read(tertiaryEducationFormProvider.notifier)
                        .updateCourseLengthYears,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 10,
                    vertical: isMobile ? 10 : 12,
                  ),
                ),
              ),
            ),
            SizedBox(width: isMobile ? 8 : 12),
            Text(
              'OR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 12 : 14,
              ),
            ),
            SizedBox(width: isMobile ? 8 : 12),
            SizedBox(
              width: isMobile ? 50 : 60,
              child: TextFormField(
                initialValue: formData.courseLengthSemesters,
                onChanged:
                    ref
                        .read(tertiaryEducationFormProvider.notifier)
                        .updateCourseLengthSemesters,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 10,
                    vertical: isMobile ? 10 : 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: isMobile ? 50 : 60,
              child: Text(
                'Years',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 10 : 12),
              ),
            ),
            SizedBox(width: isMobile ? 8 : 12),
            Container(width: 16),
            SizedBox(width: isMobile ? 8 : 12),
            Container(
              width: isMobile ? 50 : 60,
              child: Text(
                'Semesters',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 10 : 12),
              ),
            ),
          ],
        ),
        if (_fieldErrors['courseLength'] != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              _fieldErrors['courseLength']!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );

    return _buildResponsiveLayout(
      'Normal length of full-time course',
      courseFields,
      required: true,
    );
  }

  Widget _buildCheckboxWithWeeks(
    String label,
    bool isChecked,
    String weeks,
    Function(bool) onCheckChanged,
    Function(String) onWeeksChanged,
  ) {
    final isMobile = MediaQuery.of(context).size.width <= 768;

    Widget checkboxRow = Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: isMobile ? 12 : 14),
            softWrap: true,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: isMobile ? 20 : 24,
          height: isMobile ? 20 : 24,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) => onCheckChanged(value ?? false),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        if (isChecked) ...[
          const SizedBox(width: 8),
          SizedBox(
            width: isMobile ? 50 : 60,
            height: isMobile ? 30 : 34,
            child: TextFormField(
              initialValue: weeks,
              onChanged: onWeeksChanged,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Weeks',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 6 : 8,
                  vertical: isMobile ? 8 : 10,
                ),
              ),
            ),
          ),
        ],
      ],
    );

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: checkboxRow,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(flex: 12, child: Container()),
          const SizedBox(width: 16),
          Expanded(flex: 20, child: checkboxRow),
        ],
      ),
    );
  }

  Widget _buildButtons(bool isLoading) {
    final isMobile = MediaQuery.of(context).size.width <= 768;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.teal),
            foregroundColor: Colors.teal,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 8 : 12,
            ),
          ),
          onPressed: isLoading ? null : () => context.go('/previous_page'),
          child: Text('Cancel', style: TextStyle(fontSize: isMobile ? 12 : 14)),
        ),
        SizedBox(width: isMobile ? 6 : 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: isMobile ? 8 : 12,
            ),
          ),
          onPressed: isLoading ? null : _handleSubmit,
          child:
              isLoading
                  ? SizedBox(
                    width: isMobile ? 16 : 20,
                    height: isMobile ? 16 : 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                  : Text(
                    'Save & Continue',
                    style: TextStyle(fontSize: isMobile ? 12 : 14),
                  ),
        ),
      ],
    );
  }
}
