import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/providers/visatype_provider.dart';
import 'package:vetassess/providers/occupationtype_provider.dart';
import 'package:vetassess/widgets/login_page_layout.dart';
import '../../widgets/application_nav.dart';
import 'appli_general_edu.dart';
import 'package:vetassess/models/getvisatype_model.dart';
import 'package:vetassess/models/getoccupationtype_model.dart';

class OccupationForm extends ConsumerStatefulWidget {
  const OccupationForm({super.key});

  @override
  ConsumerState<OccupationForm> createState() => _OccupationFormState();
}

class _OccupationFormState extends ConsumerState<OccupationForm> {
  bool isFullSkillsAssessment = true;
  Occupations? selectedOccupation;
  bool _isLoading = false;

  // Responsive breakpoints
  static const double _smallBreakpoint = 600;
  static const double _mediumBreakpoint = 900;

  int? get _currentUserId {
    final loginState = ref.read(loginProvider);
    return loginState.response?.userId;
  }

  int? get _visaId {
    final visaState = ref.read(visatypeProvider);
    return visaState.selectedVisaType?.id;
  }

  // Fixed: Use selectedOccupation from local state instead of provider
  int? get _occupationId {
    return selectedOccupation?.id;
  }

  @override
  void initState() {
    super.initState();
    // Fetch initial visa types for Full Skills Assessment and occupations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchVisaTypesForCurrentSelection();
      _fetchOccupations();
    });
  }

  void _fetchVisaTypesForCurrentSelection() {
    final category = isFullSkillsAssessment ? 'Full Skills Assessment' : 'Qualifications Only';
    print('Fetching visa types for category: $category');
    ref.read(visatypeProvider.notifier).fetchVisaTypes(category);
  }

  void _fetchOccupations() {
    ref.read(occupationtypeProvider.notifier).fetchDocumentCategories();
  }

  // Enhanced validation method
  String? _validateForm() {
    final errors = <String>[];

    // Check if user is logged in
    if (_currentUserId == null) {
      errors.add('User not logged in. Please login again.');
    }

    // Check if visa type is selected
    if (_visaId == null) {
      errors.add('Please select a visa type.');
    }

    // Check if occupation is selected
    if (selectedOccupation == null) {
      errors.add('Please select an occupation.');
    }

    return errors.isEmpty ? null : errors.join('\n');
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
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
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

  void _showSuccessDialog({required String message, VoidCallback? onContinue}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Success',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onContinue?.call();
            },
            child: const Text(
              'OK',
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

  Future<void> _continue() async {
    // Validate form before submission
    final validationError = _validateForm();
    if (validationError != null) {
      _showErrorDialog(
        title: 'Validation Error',
        message: validationError,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Submit the form
      final result = await ref.read(occupationtypeProvider.notifier).submitOccupations(
        userId: _currentUserId!,
        visaId: _visaId!,
        occupationId: _occupationId!,
      );

      if (mounted) {
        setState(() => _isLoading = false);

        if (result.success) {
          _showSuccessDialog(
            message: 'Occupation details submitted successfully!',
            onContinue: () => context.go('/education_form'),
          );
        } else {
          _showErrorDialog(
            title: 'Submission Failed',
            message: result.errorMessage ?? 'Failed to submit occupation details. Please try again.',
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

  Future<void> _saveAsDraft() async {
    // Basic validation for draft
    if (_currentUserId == null) {
      _showErrorDialog(
        title: 'Error',
        message: 'User not logged in. Please login again.',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // For draft, we can save even without complete data
      final result = await ref.read(occupationtypeProvider.notifier).saveAsDraft(
        userId: _currentUserId!,
        visaId: _visaId,
        occupationId: _occupationId,
        assessmentType: isFullSkillsAssessment ? 'Full Skills Assessment' : 'Qualifications Only',
      );

      if (mounted) {
        setState(() => _isLoading = false);

        if (result.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Draft saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          _showErrorDialog(
            title: 'Save Draft Failed',
            message: result.errorMessage ?? 'Failed to save draft. Please try again.',
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = _ResponsiveHelper(size);

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.3,
            child: const Align(
              alignment: Alignment.topRight,
              child: ApplicationNav(),
            ),
          ),
          Expanded(child: _buildMainContent(context, responsive)),
          if (!responsive.isSmall && !responsive.isMedium)
            SizedBox(width: size.width * 0.05),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, _ResponsiveHelper responsive) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: responsive.isSmall ? 4 : 16,
      ),
      padding: EdgeInsets.all(responsive.isSmall ? 8 : 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.all(responsive.isSmall ? 4 : 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.isSmall ? 8 : 0),
              child: const Text(
                'Occupation',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3C4043),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildFormContainer(responsive),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContainer(_ResponsiveHelper responsive) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.all(responsive.isSmall ? 12 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                '* Required Fields',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 25),
          ..._buildFormFields(responsive),
          const SizedBox(height: 30),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildActionButtons(responsive),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  List<Widget> _buildFormFields(_ResponsiveHelper responsive) {
    return [
      _buildFormRow(
        'Assessment type',
        true,
        _buildAssessmentTypeRadios(),
        responsive,
      ),
      const SizedBox(height: 15),
      _buildFormRow(
        'Visa type',
        true,
        _buildVisaTypeDropdown(responsive),
        responsive,
        contentPadding: const EdgeInsets.only(top: 13),
      ),
      const SizedBox(height: 15),
      _buildFormRow(
        'Select occupation',
        true,
        _buildOccupationDropdown(responsive),
        responsive,
        contentPadding: const EdgeInsets.only(top: 13),
      ),
      const SizedBox(height: 15),
      _buildFormRow(
        'ANZSCO code',
        false,
        Text(
          selectedOccupation?.anzscoCode ?? 'Please select an occupation',
          style: TextStyle(
            fontSize: responsive.fontSize,
            color: selectedOccupation?.anzscoCode != null ? Colors.black : Colors.grey,
          ),
        ),
        responsive,
      ),
      const SizedBox(height: 15),
      _buildFormRow(
        'Note',
        false,
        Text(
          'Please note it is an applicant\'s responsibility to ensure that the selected occupation is available for the intended visa category.',
          style: TextStyle(fontSize: responsive.fontSize),
        ),
        responsive,
      ),
      const SizedBox(height: 15),
      _buildFormRow(
        'Skills Requirement',
        false,
        _buildSkillsRequirement(responsive),
        responsive,
      ),
      const SizedBox(height: 15),
      _buildFormRow(
        'Additional Information',
        false,
        Text(
          'Information Sheet',
          style: TextStyle(
            fontSize: responsive.fontSize,
            color: Colors.orange,
          ),
        ),
        responsive,
      ),
    ];
  }

  Widget _buildFormRow(
      String label,
      bool isRequired,
      Widget content,
      _ResponsiveHelper responsive, {
        EdgeInsets? contentPadding,
      }) {
    final labelWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isRequired) const SizedBox(width: 5),
        if (isRequired)
          const Text('*', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      ],
    );

    if (responsive.isSmall) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelWidget,
            const SizedBox(height: 8),
            Padding(
              padding: contentPadding ?? EdgeInsets.zero,
              child: content,
            ),
          ],
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: contentPadding ?? const EdgeInsets.only(top: 2),
            child: Align(alignment: Alignment.centerRight, child: labelWidget),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(flex: 5, child: content),
      ],
    );
  }

  Widget _buildAssessmentTypeRadios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRadioOption(true, 'Full Skills Assessment'),
        _buildRadioOption(false, 'Qualifications Only'),
      ],
    );
  }

  Widget _buildRadioOption(bool value, String label) {
    return Row(
      children: [
        Radio<bool>(
          value: value,
          groupValue: isFullSkillsAssessment,
          onChanged: (v) {
            if (v != null) {
              setState(() {
                isFullSkillsAssessment = v;
                // Clear selections when changing assessment type
                selectedOccupation = null;
              });
              // Clear current selection and fetch new visa types
              ref.read(visatypeProvider.notifier).clearSelection();
              _fetchVisaTypesForCurrentSelection();
            }
          },
          activeColor: Colors.blue,
        ),
        Flexible(child: Text(label)),
        const SizedBox(width: 5),
        const Icon(Icons.info_outline, color: Colors.blue, size: 18),
      ],
    );
  }

  Widget _buildVisaTypeDropdown(_ResponsiveHelper responsive) {
    final visaTypeState = ref.watch(visatypeProvider);
    final currentCategory = isFullSkillsAssessment ? 'Full Skills Assessment' : 'Qualifications Only';

    if (visaTypeState.isLoading) {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 8),
              Text(
                'Loading visa types...',
                style: TextStyle(fontSize: responsive.fontSize),
              ),
            ],
          ),
        ),
      );
    }

    if (visaTypeState.error != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                'Error loading visa types',
                style: TextStyle(color: Colors.red, fontSize: responsive.fontSize),
              ),
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: _fetchVisaTypesForCurrentSelection,
            child: const Text('Retry'),
          ),
        ],
      );
    }

    // Filter visa types for current category
    final filteredVisaTypes = visaTypeState.visaTypes
        .where((visaType) => visaType.category?.trim() == currentCategory.trim())
        .toList();

    if (filteredVisaTypes.isEmpty) {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            'No visa types available for $currentCategory',
            style: TextStyle(fontSize: responsive.fontSize),
          ),
        ),
      );
    }

    // Check if selected visa type belongs to current category
    VisaTypeModel? validSelectedVisaType = visaTypeState.selectedVisaType;
    if (validSelectedVisaType != null &&
        validSelectedVisaType.category?.trim() != currentCategory.trim()) {
      validSelectedVisaType = null;
      // Update the provider to clear invalid selection
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(visatypeProvider.notifier).clearSelection();
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<VisaTypeModel>(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isDense: responsive.isSmall,
          ),
          isExpanded: true,
          value: validSelectedVisaType,
          hint: Text(
            'Select a visa type',
            style: TextStyle(fontSize: responsive.fontSize),
          ),
          onChanged: (VisaTypeModel? newValue) {
            if (newValue != null) {
              ref.read(visatypeProvider.notifier).selectVisaType(newValue);
            }
          },
          items: filteredVisaTypes.map((visaType) {
            return DropdownMenuItem<VisaTypeModel>(
              value: visaType,
              child: Tooltip(
                message: visaType.visaName ?? '',
                child: Text(
                  visaType.visaName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: responsive.fontSize),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 4),
        Text(
          'Category: $currentCategory (${filteredVisaTypes.length} options)',
          style: TextStyle(
            fontSize: responsive.smallFontSize,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // Updated occupation dropdown with better error handling
  Widget _buildOccupationDropdown(_ResponsiveHelper responsive) {
    final occupationState = ref.watch(occupationtypeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Occupation Dropdown
        DropdownButtonFormField<Occupations>(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isDense: responsive.isSmall,
          ),
          isExpanded: true,
          value: selectedOccupation,
          hint: Text(
            'Select an occupation',
            style: TextStyle(fontSize: responsive.fontSize),
          ),
          onChanged: (Occupations? newValue) {
            setState(() {
              selectedOccupation = newValue;
            });
          },
          items: occupationState.occupations?.map((occupation) {
            return DropdownMenuItem<Occupations>(
              value: occupation,
              child: Tooltip(
                message: '${occupation.anzscoCode} - ${occupation.occupationName}',
                child: Text(
                  '${occupation.anzscoCode} ${occupation.occupationName}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: responsive.fontSize),
                ),
              ),
            );
          }).toList() ?? [],
        ),
        const SizedBox(height: 8),
        // Loading state
        if (occupationState.occupations == null || occupationState.occupations!.isEmpty)
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
                Text(
                  'Loading occupations...',
                  style: TextStyle(fontSize: responsive.smallFontSize),
                ),
              ],
            ),
          ),
        // Info text
        Wrap(
          children: [
            Text(
              'for more information, please check ',
              style: TextStyle(fontSize: responsive.smallFontSize),
            ),
            Text(
              'Department of Home Affairs website',
              style: TextStyle(
                fontSize: responsive.smallFontSize,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillsRequirement(_ResponsiveHelper responsive) {
    final textStyle = TextStyle(fontSize: responsive.fontSize);

    // Use skills requirement from selected occupation if available
    String skillsRequirementText = selectedOccupation?.skillsRequirement ??
        'This occupation requires a qualification assessed as comparable to the education level of an Australian Qualifications Framework (AQF) Bachelor Degree or higher degree and in a field highly relevant to the nominated occupation.';

    const bullets = [
      'at least one year of post-qualification employment at an appropriate skill level, undertaken in the last five years,',
      'working 20 hours or more per week, and',
      'highly relevant to the nominated occupation.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          skillsRequirementText,
          style: textStyle,
        ),
        const SizedBox(height: 15),
        Text(
          'In addition to the above, it is essential for applicants to meet the following employment criteria:',
          style: textStyle,
        ),
        const SizedBox(height: 10),
        ...bullets.map((text) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildBulletPoint(text, responsive),
        )),
        const SizedBox(height: 15),
        Text(
          'Please note in order to achieve a successful Skills Assessment Outcome, a positive assessment for both qualifications and employment is required.',
          style: textStyle,
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text, _ResponsiveHelper responsive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: responsive.fontSize)),
        ),
      ],
    );
  }

  Widget _buildActionButtons(_ResponsiveHelper responsive) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.symmetric(
        horizontal: responsive.isSmall ? 8 : 20,
        vertical: responsive.isSmall ? 6 : 10,
      ),
    );

    // For mobile, use a column layout or flexible row
    if (responsive.isSmall) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : () => context.go('/personal_form'),
                    style: buttonStyle,
                    child: const Text('Back', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveAsDraft,
                    style: buttonStyle,
                    child: const Text('Save & Exit', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _continue,
                style: buttonStyle,
                child: _isLoading
                    ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text('Continue', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      );
    }

    // For larger screens, use the original row layout
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : () => context.go('/personal_form'),
              style: buttonStyle,
              child: const Text('Back'),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveAsDraft,
              style: buttonStyle,
              child: const Text('Save & Exit'),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: _isLoading ? null : _continue,
              style: buttonStyle,
              child: _isLoading
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class for responsive design
class _ResponsiveHelper {
  final Size size;

  _ResponsiveHelper(this.size);

  bool get isSmall => size.width < 600;
  bool get isMedium => size.width >= 600 && size.width < 900;
  bool get isLarge => size.width >= 900;

  double get fontSize => isSmall ? 12 : 14;
  double get smallFontSize => isSmall ? 11 : 13;

  double get horizontalPadding => isSmall ? 8 : 16;
  double get containerPadding => isSmall ? 12 : 20;
}