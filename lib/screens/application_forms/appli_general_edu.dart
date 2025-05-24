import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/screens/application_forms/appli_priority.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../../widgets/application_nav.dart';
import '../tertiary_education.dart';

class EducationForm extends StatefulWidget {
  const EducationForm({super.key});

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: screenWidth * 0.02,
                bottom: screenHeight * 0.12,
                right: screenWidth * 0.02,
              ),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      const Text(
                        'General education',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4D4D4D),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Form Container
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Required Fields
                              Row(
                                children: const [
                                  Text(
                                    '*',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Required Fields',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Primary School Section
                              const Text(
                                'Primary School',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Divider(
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                              const SizedBox(height: 15),

                              // Primary School Form Fields
                              buildLabelledField(
                                'Date started',
                                buildDateField(),
                              ),
                              buildLabelledField(
                                'Date finished',
                                buildDateField(),
                              ),
                              buildLabelledField(
                                'Number of years',
                                buildNumberField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Country(s)',
                                buildCountryField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Year completed',
                                buildYearDropdown(),
                              ),

                              const SizedBox(height: 30),

                              // Secondary School Section
                              const Text(
                                'Secondary School',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Divider(
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                              const SizedBox(height: 15),

                              // Secondary School Form Fields
                              buildLabelledField(
                                'Date started',
                                buildDateField(),
                              ),
                              buildLabelledField(
                                'Date finished',
                                buildDateField(),
                              ),
                              buildLabelledField(
                                'Number of years',
                                buildNumberField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Country(s)',
                                buildCountryField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Highest schooling\ncertificate obtained',
                                buildCertificateField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Year obtained',
                                buildYearDropdown(),
                                isRequired: true,
                              ),

                              const SizedBox(height: 30),

                              // Buttons
                              Center(
                                child: Wrap(
                                  spacing: 15,
                                  runSpacing: 10,
                                  children: [
                                    // Back Button
                                    SizedBox(
                                      height: 36,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                        ),
                                        child: const Text(
                                          'Back',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Save & Exit Button
                                    SizedBox(
                                      height: 36,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                        ),
                                        child: const Text(
                                          'Save & Exit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Continue Button
                                    SizedBox(
                                      height: 36,
                                      child: ElevatedButton(
                                        onPressed:
                                            () => context.go(
                                              '/tertiary_education_form',
                                            ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                        ),
                                        child: const Text(
                                          'Continue',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabelledField(
    String label,
    Widget field, {
    bool isRequired = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // For smaller screens, stack the label and field vertically
          if (constraints.maxWidth < 600) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4D4D4D),
                      ),
                    ),
                    if (isRequired)
                      const Text(' *', style: TextStyle(color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 8),
                field,
              ],
            );
          }

          // For larger screens, use the original row layout
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.35,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4D4D4D),
                          ),
                        ),
                      ),
                      if (isRequired)
                        const Text(' *', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              field,
            ],
          );
        },
      ),
    );
  }

  Widget buildDateField() {
    return SizedBox(
      width: 150,
      height: 34,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: 'MM/yyyy',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
      ),
    );
  }

  Widget buildNumberField() {
    return SizedBox(
      width: 80,
      height: 34,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buildCountryField() {
    return SizedBox(
      width: 250,
      height: 34,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget buildCertificateField() {
    return SizedBox(
      width: 250,
      height: 34,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget buildYearDropdown() {
    return SizedBox(
      width: 200,
      height: 34,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                'Please pick a year',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              items: const [],
              onChanged: (value) {},
            ),
          ),
        ),
      ),
    );
  }
}
