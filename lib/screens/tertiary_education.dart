import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../widgets/application_nav.dart';
import 'empoyment.dart';

class TertiaryEducationForm extends StatefulWidget {
  const TertiaryEducationForm({super.key});

  @override
  State<TertiaryEducationForm> createState() => _TertiaryEducationFormState();
}

class _TertiaryEducationFormState extends State<TertiaryEducationForm> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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

          // Main content container
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
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
                        Row(
                          children: const [
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

                        // Qualification Details Section
                        const Text(
                          'Qualification Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4D4D4D),
                          ),
                        ),
                        const SizedBox(height: 16),

                        buildLabelledField(
                          'Student registration number',
                          buildTextField(200),
                          helperText: '(if available)',
                        ),
                        buildLabelledField(
                          'Name of qualification obtained',
                          buildTextField(350),
                          isRequired: true,
                        ),
                        buildLabelledField(
                          'Major field of study',
                          buildTextField(350),
                          isRequired: true,
                        ),

                        const SizedBox(height: 16),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFEEEEEE),
                        ),
                        const SizedBox(height: 16),

                        // Awarding Body Details Section
                        const Text(
                          'Awarding Body Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4D4D4D),
                          ),
                        ),
                        const SizedBox(height: 16),

                        buildLabelledField(
                          'Name of awarding body',
                          buildTextField(350),
                          isRequired: true,
                        ),
                        buildLabelledField(
                          'Awarding Body Country',
                          buildDropdown(350),
                          isRequired: true,
                        ),
                        buildLabelledField(
                          'Campus you attended',
                          buildTextField(350),
                        ),
                        buildLabelledField(
                          'Name of institution you attended',
                          buildTextField(350),
                        ),
                        buildLabelledField(
                          'Street address',
                          buildTextField(280),
                          isRequired: true,
                        ),
                        buildLabelledField(
                          'Street address second line',
                          buildTextField(280),
                        ),
                        buildLabelledField(
                          'Suburb/City',
                          buildTextField(180),
                          isRequired: true,
                        ),
                        buildLabelledField('State', buildTextField(180)),
                        buildLabelledField('Post code', buildTextField(180)),
                        buildLabelledField(
                          'Campus/Institution Country',
                          buildDropdown(350),
                          isRequired: true,
                        ),

                        const SizedBox(height: 16),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFEEEEEE),
                        ),
                        const SizedBox(height: 16),

                        // Course Details Section
                        const Text(
                          'Course Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4D4D4D),
                          ),
                        ),
                        const SizedBox(height: 16),

                        buildLabelledField(
                          'What was the normal entry requirement for\nthe course?',
                          buildTextField(250),
                          isRequired: true,
                        ),
                        buildLabelledField(
                          'If different, what was the basis of your entry into\nthe course?',
                          buildTextField(250),
                        ),

                        // Course length row
                        buildFormRow(
                          'Normal length of full-time course',
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 60,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'OR',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 12),
                              SizedBox(
                                width: 60,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isRequired: true,
                        ),

                        // Years/Semesters row
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            children: [
                              const Spacer(flex: 12),
                              Container(
                                width: 60,
                                child: const Text(
                                  'Years',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text('  '),
                              const SizedBox(width: 12),
                              Container(
                                width: 60,
                                child: const Text(
                                  'Semesters',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),

                        buildLabelledField(
                          'Date course commenced',
                          buildDateField(),
                          isRequired: true,
                        ),
                        buildLabelledField(
                          'Date course completed',
                          buildDateField(),
                          isRequired: true,
                        ),
                        buildLabelledField(
                          'Date qualification awarded',
                          buildDateField(),
                        ),
                        buildLabelledField(
                          'Study Mode',
                          buildDropdown(180),
                          isRequired: true,
                        ),
                        buildLabelledField(
                          'Hours per week',
                          buildTextField(180),
                          isRequired: true,
                        ),

                        const SizedBox(height: 16),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFEEEEEE),
                        ),
                        const SizedBox(height: 16),

                        // Additional Course Requirements Section
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

                        // Checkboxes for requirements
                        buildCheckboxRow(
                          'An internship, supervised practical training or work placement',
                        ),
                        const SizedBox(height: 8),
                        buildCheckboxRow('A thesis'),
                        const SizedBox(height: 8),
                        buildCheckboxRow('A major project'),

                        const SizedBox(height: 32),

                        // Buttons row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.teal),
                                foregroundColor: Colors.teal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                              ),
                              onPressed: () {
                                context.go('/employment_form');
                              },
                              child: const Text('Save & Continue'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFormRow(String label, Widget field, {bool isRequired = false}) {
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

  Widget buildLabelledField(
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

  Widget buildTextField(double width) {
    return SizedBox(
      width: width,
      height: 34,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
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

  Widget buildDropdown(double width) {
    return SizedBox(
      width: width,
      height: 34,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        hint: const Text('Select one'),
        items: const [],
        onChanged: (value) {},
      ),
    );
  }

  Widget buildDateField() {
    return SizedBox(
      width: 180,
      height: 34,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: 'dd/mm/yyyy',
          isDense: true,
        ),
      ),
    );
  }

  Widget buildCheckboxRow(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 16),
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(value: false, onChanged: (value) {}),
        ),
      ],
    );
  }
}
