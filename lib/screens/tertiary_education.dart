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
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Responsive breakpoints
    final bool isDesktop = screenWidth > 1200;
    final bool isTablet = screenWidth > 768 && screenWidth <= 1200;
    final bool isMobile = screenWidth <= 768;

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation container - responsive width
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

          // Main content container
          Expanded(
            child: Container(
              margin: EdgeInsets.all(isMobile ? 8.0 : 16.0),
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
                          Text(
                            'Provide details of all completed post-secondary qualifications. VETASSESS will assess those qualifications necessary for the applicant to meet the minimum requirements of the nominated occupation.',
                            style: TextStyle(fontSize: isMobile ? 12 : 14),
                          ),
                          SizedBox(height: isMobile ? 16 : 24),

                          // Qualification Details Section
                          Text(
                            'Qualification Details',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          buildResponsiveLabelledField(
                            context,
                            'Student registration number',
                            buildResponsiveTextField(context, isMobile ? 150 : 200),
                            helperText: '(if available)',
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Name of qualification obtained',
                            buildResponsiveTextField(context, isMobile ? 200 : 350),
                            isRequired: true,
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Major field of study',
                            buildResponsiveTextField(context, isMobile ? 200 : 350),
                            isRequired: true,
                          ),

                          SizedBox(height: isMobile ? 12 : 16),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFEEEEEE),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Awarding Body Details Section
                          Text(
                            'Awarding Body Details',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          buildResponsiveLabelledField(
                            context,
                            'Name of awarding body',
                            buildResponsiveTextField(context, isMobile ? 200 : 350),
                            isRequired: true,
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Awarding Body Country',
                            buildResponsiveDropdown(context, isMobile ? 200 : 350),
                            isRequired: true,
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Campus you attended',
                            buildResponsiveTextField(context, isMobile ? 200 : 350),
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Name of institution you attended',
                            buildResponsiveTextField(context, isMobile ? 200 : 350),
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Street address',
                            buildResponsiveTextField(context, isMobile ? 180 : 280),
                            isRequired: true,
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Street address second line',
                            buildResponsiveTextField(context, isMobile ? 180 : 280),
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Suburb/City',
                            buildResponsiveTextField(context, isMobile ? 140 : 180),
                            isRequired: true,
                          ),
                          buildResponsiveLabelledField(
                            context, 
                            'State', 
                            buildResponsiveTextField(context, isMobile ? 140 : 180)
                          ),
                          buildResponsiveLabelledField(
                            context, 
                            'Post code', 
                            buildResponsiveTextField(context, isMobile ? 140 : 180)
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Campus/Institution Country',
                            buildResponsiveDropdown(context, isMobile ? 200 : 350),
                            isRequired: true,
                          ),

                          SizedBox(height: isMobile ? 12 : 16),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFEEEEEE),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Course Details Section
                          Text(
                            'Course Details',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Fixed: Course entry requirement field
                          buildResponsiveLabelledField(
                            context,
                            'What was the normal entry requirement for the course?',
                            buildResponsiveTextField(context, isMobile ? 180 : 250),
                            isRequired: true,
                          ),
                          
                          // Fixed: Different entry basis field
                          buildResponsiveLabelledField(
                            context,
                            'If different, what was the basis of your entry into the course?',
                            buildResponsiveTextField(context, isMobile ? 180 : 250),
                          ),

                          // Fixed: Course length row - responsive with proper alignment
                          buildCourseLanguageRow(context, isMobile),

                          buildResponsiveLabelledField(
                            context,
                            'Date course commenced',
                            buildResponsiveDateField(context),
                            isRequired: true,
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Date course completed',
                            buildResponsiveDateField(context),
                            isRequired: true,
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Date qualification awarded',
                            buildResponsiveDateField(context),
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Study Mode',
                            buildResponsiveDropdown(context, isMobile ? 140 : 180),
                            isRequired: true,
                          ),
                          buildResponsiveLabelledField(
                            context,
                            'Hours per week',
                            buildResponsiveTextField(context, isMobile ? 140 : 180),
                            isRequired: true,
                          ),

                          SizedBox(height: isMobile ? 12 : 16),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFEEEEEE),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Additional Course Requirements Section
                          Text(
                            'Additional Course Requirements',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          Text(
                            'Were you required to complete any of the following before receiving the qualification?',
                            style: TextStyle(fontSize: isMobile ? 12 : 14),
                          ),
                          SizedBox(height: isMobile ? 12 : 16),

                          // Checkboxes for requirements - responsive
                          buildResponsiveCheckboxRow(
                            context,
                            'An internship, supervised practical training or work placement',
                          ),
                          SizedBox(height: isMobile ? 6 : 8),
                          buildResponsiveCheckboxRow(context, 'A thesis'),
                          SizedBox(height: isMobile ? 6 : 8),
                          buildResponsiveCheckboxRow(context, 'A major project'),

                          SizedBox(height: isMobile ? 24 : 32),

                          // Buttons row - responsive
                          Row(
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
                                onPressed: () {},
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                                ),
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
                                onPressed: () {
                                  context.go('/employment_form');
                                },
                                child: Text(
                                  'Save & Continue',
                                  style: TextStyle(fontSize: isMobile ? 12 : 14),
                                ),
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
          ),
        ],
      ),
    );
  }

  Widget buildResponsiveFormRow(BuildContext context, String label, Widget field, {bool isRequired = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;
    
    if (isMobile) {
      // Stack layout for mobile
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label, 
                    style: TextStyle(fontSize: 12),
                    softWrap: true,
                  ),
                ),
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
            const SizedBox(height: 8),
            field,
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
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      label, 
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.right,
                    ),
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
          ),
          const SizedBox(width: 16),
          Expanded(flex: 20, child: field),
        ],
      ),
    );
  }

  Widget buildResponsiveLabelledField(
    BuildContext context,
    String label,
    Widget field, {
    bool isRequired = false,
    String? helperText,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;
    
    if (isMobile) {
      // Stack layout for mobile
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
            const SizedBox(height: 8),
            field,
            if (helperText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  helperText,
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ),
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

  // Fixed: New method for course length with proper alignment
  Widget buildCourseLanguageRow(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Normal length of full-time course',
                    style: TextStyle(fontSize: 12),
                    softWrap: true,
                  ),
                ),
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
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                const Text(
                  'OR',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
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
                  width: 50,
                  child: const Text(
                    'Years',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                SizedBox(width: 8),
                Container(width: 16), // Space for "OR"
                SizedBox(width: 8),
                Container(
                  width: 50,
                  child: const Text(
                    'Semesters',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
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
                  children: [
                    Text(
                      'Normal length of full-time course', 
                      style: const TextStyle(fontSize: 14),
                    ),
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
              children: [
                Row(
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
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    const Text(
                      'OR',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 12),
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
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 12,
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
                      width: 60,
                      child: const Text(
                        'Years',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(width: 16), // Space for "OR"
                    SizedBox(width: 12),
                    Container(
                      width: 60,
                      child: const Text(
                        'Semesters',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildResponsiveTextField(BuildContext context, double desktopWidth) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;
    
    double width = isMobile ? screenWidth * 0.6 : desktopWidth;
    double height = isMobile ? 30 : 34;
    
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
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

  Widget buildResponsiveDropdown(BuildContext context, double desktopWidth) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;
    
    double width = isMobile ? screenWidth * 0.6 : desktopWidth;
    double height = isMobile ? 30 : 34;
    
    return SizedBox(
      width: width,
      height: height,
      child: DropdownButtonFormField<String>(
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
        items: const [],
        onChanged: (value) {},
      ),
    );
  }

  Widget buildResponsiveDateField(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;
    
    double width = isMobile ? screenWidth * 0.4 : 180;
    double height = isMobile ? 30 : 34;
    
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 10,
            vertical: isMobile ? 8 : 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: 'dd/mm/yyyy',
          hintStyle: TextStyle(fontSize: isMobile ? 10 : 12),
          isDense: true,
        ),
      ),
    );
  }

  Widget buildResponsiveCheckboxRow(BuildContext context, String label) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;
    
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label, 
                style: TextStyle(fontSize: 12),
                softWrap: true,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: false, 
                onChanged: (value) {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      );
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          flex: 12,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                label, 
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 20,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(value: false, onChanged: (value) {}),
            ),
          ),
        ),
      ],
    );
  }
}