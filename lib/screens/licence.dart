import 'package:flutter/material.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../widgets/application_nav.dart';
import 'application_forms/appli_priority.dart';

class LicenceForm extends StatefulWidget {
  const LicenceForm({super.key});

  @override
  State<LicenceForm> createState() => _LicenceFormState();
}

class _LicenceFormState extends State<LicenceForm> {
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
                        'Licence',
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

                              // Description text
                              const Text(
                                'Complete details about licences / registrations / memberships.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Divider(
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                              const SizedBox(height: 20),

                              // Licence Form Fields
                              buildLabelledField(
                                'Category',
                                buildDropdownField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Country of issuer',
                                buildDropdownField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Name of issuing body',
                                buildTextField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Type of licence / registration / membership',
                                buildTextField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Registration number',
                                buildTextField(),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Date of expiry',
                                buildDateField(),
                              ),
                              buildLabelledField(
                                'Current status',
                                buildDropdownField(),
                                isRequired: true,
                              ),

                              const SizedBox(height: 20),
                              const Divider(
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                              const SizedBox(height: 20),

                              // Buttons
                              Center(
                                child: Wrap(
                                  spacing: 15,
                                  runSpacing: 10,
                                  children: [
                                    // Cancel Button
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
                                          'Cancel',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Save & Continue Button
                                    SizedBox(
                                      height: 36,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      ApplicationPriorityProcessing(),
                                            ),
                                          );
                                        },
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
                                          'Save & Continue',
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

  Widget buildTextField() {
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

  Widget buildDropdownField() {
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
                'Select one',
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
