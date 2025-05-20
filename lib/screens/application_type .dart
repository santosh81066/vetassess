import 'package:flutter/material.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

class ApplicationTypeSelectionScreen extends StatefulWidget {
  const ApplicationTypeSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationTypeSelectionScreen> createState() => _ApplicationTypeSelectionScreenState();
}

class _ApplicationTypeSelectionScreenState extends State<ApplicationTypeSelectionScreen> {
  String? selectedApplicationType;
  bool isMigrationExpanded = false;
  bool isNonMigrationExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LoginPageLayout(
      child: Padding(
        padding: const EdgeInsets.all(150.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Application Type Selection',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A4A4A),
              ),
            ),
            const Divider(height: 32, thickness: 1),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Your Application Type',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4A4A4A),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Migration Section
                        _buildSectionContainer(
                          isExpanded: isMigrationExpanded,
                          title: 'Migration',
                          onTap: () {
                            setState(() {
                              isMigrationExpanded = !isMigrationExpanded;
                            });
                          },
                          content: Column(
                            children: [
                              _buildRadioOption(
                                title: 'Skills Assessment (GSM, ENS, SESR, 485, SID)',
                                value: 'skills_assessment',
                              ),
                              _buildRadioOption(
                                title: 'Points Test Advice Only (Skills Assessment with another Assessment Authority)',
                                value: 'points_test_advice',
                              ),
                              _buildRadioOption(
                                title: 'Industry Labour Agreement (ILA)',
                                value: 'industry_labour_agreement',
                              ),
                              _buildRadioOption(
                                title: 'Designated Area Migration Agreement (DAMA)',
                                value: 'designated_area_migration',
                                hasInfoIcon: true,
                              ),
                            ],
                          ),
                        ),
                        // Non Migration Section
                        _buildSectionContainer(
                          isExpanded: isNonMigrationExpanded,
                          title: 'Non Migration',
                          onTap: () {
                            setState(() {
                              isNonMigrationExpanded = !isNonMigrationExpanded;
                            });
                          },
                          content: Column(
                            children: [
                              _buildRadioOption(
                                title: 'Qualification Assessment for Financial Adviser Standards and Ethics Authority (FASEA)',
                                value: 'qualification_fasea',
                                hasInfoIcon: true,
                              ),
                              _buildRadioOption(
                                title: 'Qualification Assessment for Psychotherapy and Counselling Federation of Australia (PACFA)',
                                value: 'qualification_pacfa',
                                hasInfoIcon: true,
                              ),
                              _buildRadioOption(
                                title: 'Chinese Qualifications Verification Only',
                                value: 'chinese_qualifications',
                              ),
                              _buildRadioOption(
                                title: 'Australian Institute of Health & Safety (AIHS)',
                                value: 'aihs',
                                hasInfoIcon: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add buttons within the container with a divider
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle cancel action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Handle submit action
                            if (selectedApplicationType != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Selected: $selectedApplicationType')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select an application type')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text('Submit'),
                        ),
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
  }

  Widget _buildSectionContainer({
    required bool isExpanded,
    required String title,
    required VoidCallback onTap,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          // Section Header
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                  bottomLeft: isExpanded ? Radius.zero : Radius.circular(4),
                  bottomRight: isExpanded ? Radius.zero : Radius.circular(4),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Center(
                      child: Icon(
                        isExpanded ? Icons.remove : Icons.add,
                        size: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Section Content
          if (isExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
              width: double.infinity,
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildRadioOption({
    required String title,
    required String value,
    bool hasInfoIcon = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(-4, 0),
            child: Radio<String>(
              value: value,
              groupValue: selectedApplicationType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedApplicationType = newValue;
                });
              },
              activeColor: Colors.teal,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ),
          ),
          if (hasInfoIcon)
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Icon(
                Icons.info_outline,
                color: Colors.orange,
                size: 18,
              ),
            ),
        ],
      ),
    );
  }
}