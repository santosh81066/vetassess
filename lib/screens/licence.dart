import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../widgets/application_nav.dart';

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
    final isTablet = screenWidth >= 768;
    final isMobile = screenWidth < 600;

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation Panel - Responsive width
          Container(
            width: isMobile 
                ? screenWidth * 0.25 
                : isTablet 
                    ? screenWidth * 0.28 
                    : screenWidth * 0.3,
            child: Align(
              alignment: Alignment.topRight,
              child: ApplicationNav(),
            ),
          ),
          
          // Main Content - Flexible
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.02,
                left: isMobile ? screenWidth * 0.01 : screenWidth * 0.02,
                bottom: screenHeight * 0.12,
                right: isMobile ? screenWidth * 0.01 : screenWidth * 0.02,
              ),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(
                    isMobile ? screenWidth * 0.015 : screenWidth * 0.025
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title - Responsive font size
                      Text(
                        'Licence',
                        style: TextStyle(
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4D4D4D),
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 20),

                      // Form Container
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            isMobile ? screenWidth * 0.02 : screenWidth * 0.03
                          ),
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
                                  Flexible(
                                    child: Text(
                                      'Required Fields',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isMobile ? 16 : 20),

                              // Description text
                              Text(
                                'Complete details about licences / registrations / memberships.',
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              SizedBox(height: isMobile ? 16 : 20),
                              const Divider(
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                              SizedBox(height: isMobile ? 16 : 20),

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

                              SizedBox(height: isMobile ? 16 : 20),
                              const Divider(
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                              SizedBox(height: isMobile ? 16 : 20),

                              // Buttons - Responsive layout
                              Center(
                                child: isMobile
                                    ? Column(
                                        children: [
                                          buildButton('Cancel', () {}),
                                          const SizedBox(height: 10),
                                          buildButton('Save & Continue', () {
                                            context.go('/app_priority_form');
                                          }),
                                        ],
                                      )
                                    : Wrap(
                                        spacing: 15,
                                        runSpacing: 10,
                                        children: [
                                          buildButton('Cancel', () {}),
                                          buildButton('Save & Continue', () {
                                            context.go('/app_priority_form');
                                          }),
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

  Widget buildButton(String text, VoidCallback onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return SizedBox(
      width: isMobile ? double.infinity : null,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 16,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget buildLabelledField(
    String label,
    Widget field, {
    bool isRequired = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 16.0 : 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // For mobile screens, always stack vertically
          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                const SizedBox(height: 8),
                SizedBox(width: double.infinity, child: field),
              ],
            );
          }

          // For tablet and desktop, use row layout with flexible proportions
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: isTablet 
                    ? constraints.maxWidth * 0.4 
                    : constraints.maxWidth * 0.35,
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
                          textAlign: TextAlign.right,
                        ),
                      ),
                      if (isRequired)
                        const Text(' *', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: field,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildDateField() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    
    return SizedBox(
      width: isMobile 
          ? double.infinity 
          : isTablet 
              ? 150 
              : 180, // Smaller width for date field
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    
    return SizedBox(
      width: isMobile 
          ? double.infinity 
          : isTablet 
              ? 200 
              : 250,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    
    return SizedBox(
      width: isMobile 
          ? double.infinity 
          : isTablet 
              ? 160 
              : 180, // Smaller width for dropdown field
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