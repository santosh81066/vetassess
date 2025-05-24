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

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 900;

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Align(
              alignment: Alignment.topRight,
              child: ApplicationNav(),
            ),
          ),

          // Main content container with responsive padding and width
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: isSmallScreen ? 8 : 16,
              ),
              padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Occupation',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3C4043),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                '* Required Fields',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),

                          // Assessment type - Responsive row layout
                          _buildResponsiveFormRow(
                            context,
                            label: 'Assessment type',
                            isRequired: true,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio<bool>(
                                      value: true,
                                      groupValue: isFullSkillsAssessment,
                                      onChanged: (value) {
                                        setState(() {
                                          isFullSkillsAssessment = value!;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                    const Flexible(
                                      child: Text('Full Skills Assessment'),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.blue,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<bool>(
                                      value: false,
                                      groupValue: isFullSkillsAssessment,
                                      onChanged: (value) {
                                        setState(() {
                                          isFullSkillsAssessment = value!;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                    const Flexible(
                                      child: Text('Qualifications Only'),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.blue,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Visa type
                          _buildResponsiveFormRow(
                            context,
                            label: 'Visa type',
                            isRequired: true,
                            contentPadding: const EdgeInsets.only(top: 13),
                            content: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                isDense: isSmallScreen,
                              ),
                              isExpanded: true,
                              value:
                                  'Employer Nomination Scheme Visa (subclass 186) - Direct Entry',
                              onChanged: (String? newValue) {},
                              items:
                                  <String>[
                                    'Employer Nomination Scheme Visa (subclass 186) - Direct Entry',
                                  ].map<DropdownMenuItem<String>>((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 12 : 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Select occupation
                          _buildResponsiveFormRow(
                            context,
                            label: 'Select occupation',
                            isRequired: true,
                            contentPadding: const EdgeInsets.only(top: 13),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                    isDense: isSmallScreen,
                                  ),
                                  isExpanded: true,
                                  value: '234111 Agricultural Consultant',
                                  onChanged: (String? newValue) {},
                                  items:
                                      <String>[
                                        '234111 Agricultural Consultant',
                                      ].map<DropdownMenuItem<String>>((
                                        String value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: isSmallScreen ? 12 : 14,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  children: [
                                    Text(
                                      'for more information, please check ',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 11 : 13,
                                      ),
                                    ),
                                    Text(
                                      'Department of Home Affairs website',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 11 : 13,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),

                          // ANZSCO code
                          _buildResponsiveFormRow(
                            context,
                            label: 'ANZSCO code',
                            isRequired: false,
                            content: Text(
                              '234111',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Note
                          _buildResponsiveFormRow(
                            context,
                            label: 'Note',
                            isRequired: false,
                            content: Text(
                              'Please note it is an applicant\'s responsibility to ensure that the selected occupation is available for the intended visa category.',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Skills Requirement
                          _buildResponsiveFormRow(
                            context,
                            label: 'Skills Requirement',
                            isRequired: false,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'This occupation requires a qualification assessed as comparable to the education level of an Australian Qualifications Framework (AQF) Bachelor Degree or higher degree and in a field highly relevant to the nominated occupation.',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 12 : 14,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'In addition to the above, it is essential for applicants to meet the following employment criteria:',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 12 : 14,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildBulletPoint(
                                  'at least one year of post-qualification employment at an appropriate skill level, undertaken in the last five years,',
                                  isSmallScreen,
                                ),
                                const SizedBox(height: 8),
                                _buildBulletPoint(
                                  'working 20 hours or more per week, and',
                                  isSmallScreen,
                                ),
                                const SizedBox(height: 8),
                                _buildBulletPoint(
                                  'highly relevant to the nominated occupation.',
                                  isSmallScreen,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Please note in order to achieve a successful Skills Assessment Outcome, a positive assessment for both qualifications and employment is required.',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 12 : 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Additional Information
                          _buildResponsiveFormRow(
                            context,
                            label: 'Additional Information',
                            isRequired: false,
                            content: Text(
                              'Information Sheet',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Bottom buttons
                          Center(
                            child: SizedBox(
                              width: screenWidth * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 12 : 20,
                                        vertical: isSmallScreen ? 8 : 10,
                                      ),
                                    ),
                                    child: const Text('Back'),
                                  ),
                                  const SizedBox(width: 15),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 12 : 20,
                                        vertical: isSmallScreen ? 8 : 10,
                                      ),
                                    ),
                                    child: const Text('Save & Exit'),
                                  ),
                                  const SizedBox(width: 15),
                                  ElevatedButton(
                                    onPressed:
                                        () => context.go('/education_form'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 12 : 20,
                                        vertical: isSmallScreen ? 8 : 10,
                                      ),
                                    ),
                                    child: const Text('Continue'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right spacing for large screens
          if (!isSmallScreen && !isMediumScreen)
            SizedBox(width: screenWidth * 0.05),
        ],
      ),
    );
  }

  // Helper method to create responsive form rows
  Widget _buildResponsiveFormRow(
    BuildContext context, {
    required String label,
    required bool isRequired,
    required Widget content,
    EdgeInsets? contentPadding,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    // For small screens, use a column layout instead of row
    if (isSmallScreen) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (isRequired) const SizedBox(width: 5),
                if (isRequired)
                  const Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(padding: contentPadding ?? EdgeInsets.zero, child: content),
          ],
        ),
      );
    }

    // For medium and large screens, use row layout with flexible widths
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: contentPadding ?? const EdgeInsets.only(top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                if (isRequired) const SizedBox(width: 5),
                if (isRequired)
                  const Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(flex: 5, child: content),
      ],
    );
  }

  // Helper method to create bullet points
  Widget _buildBulletPoint(String text, bool isSmallScreen) {
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
          child: Text(
            text,
            style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
          ),
        ),
      ],
    );
  }
}
