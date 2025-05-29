import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';
import '../../widgets/application_nav.dart';
import 'appli_general_edu.dart';

class OccupationForm extends StatefulWidget {
  const OccupationForm({super.key});

  @override
  State<OccupationForm> createState() => _OccupationFormState();
}

class _OccupationFormState extends State<OccupationForm> {
  bool isFullSkillsAssessment = true;

  // Responsive breakpoints
  static const double _smallBreakpoint = 600;
  static const double _mediumBreakpoint = 900;

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
        _buildDropdown(
          'Employer Nomination Scheme Visa (subclass 186) - Direct Entry',
          ['Employer Nomination Scheme Visa (subclass 186) - Direct Entry'],
          responsive,
        ),
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
        Text('234111', style: TextStyle(fontSize: responsive.fontSize)),
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
          onChanged: (v) => setState(() => isFullSkillsAssessment = v!),
          activeColor: Colors.blue,
        ),
        Flexible(child: Text(label)),
        const SizedBox(width: 5),
        const Icon(Icons.info_outline, color: Colors.blue, size: 18),
      ],
    );
  }

  Widget _buildDropdown(
    String value,
    List<String> items,
    _ResponsiveHelper responsive,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: responsive.isSmall,
      ),
      isExpanded: true,
      value: value,
      onChanged: (String? newValue) {},
      items: items.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: responsive.fontSize),
        ),
      )).toList(),
    );
  }

  Widget _buildOccupationDropdown(_ResponsiveHelper responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdown(
          '234111 Agricultural Consultant',
          ['234111 Agricultural Consultant'],
          responsive,
        ),
        const SizedBox(height: 8),
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
    final bullets = [
      'at least one year of post-qualification employment at an appropriate skill level, undertaken in the last five years,',
      'working 20 hours or more per week, and',
      'highly relevant to the nominated occupation.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This occupation requires a qualification assessed as comparable to the education level of an Australian Qualifications Framework (AQF) Bachelor Degree or higher degree and in a field highly relevant to the nominated occupation.',
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
                    onPressed: () {},
                    style: buttonStyle,
                    child: const Text('Back', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
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
                onPressed: () => context.go('/education_form'),
                style: buttonStyle,
                child: const Text('Continue', style: TextStyle(fontSize: 12)),
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
              onPressed: () {},
              style: buttonStyle,
              child: const Text('Back'),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () {},
              style: buttonStyle,
              child: const Text('Save & Exit'),
            ),
            const SizedBox(width: 15),
            ElevatedButton(
              onPressed: () => context.go('/education_form'),
              style: buttonStyle,
              child: const Text('Continue'),
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