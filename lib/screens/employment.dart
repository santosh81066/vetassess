import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../widgets/application_nav.dart';
import 'licence.dart';

class EmploymentForm extends StatefulWidget {
  const EmploymentForm({super.key});

  @override
  State<EmploymentForm> createState() => _EmploymentFormState();
}

class _EmploymentFormState extends State<EmploymentForm> {
  bool isCurrentlyEmployed = false;
  List<TextEditingController> taskControllers = List.generate(5, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in taskControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isMobile = screenWidth < 768;

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation sidebar
          Container(
            width: isMobile ? 0 : MediaQuery.of(context).size.width * 0.3,
            child: isMobile ? const SizedBox.shrink() : Align(
              alignment: Alignment.topRight,
              child: ApplicationNav(),
            ),
          ),

          // Main content container
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
                  padding: EdgeInsets.all(isMobile ? screenWidth * 0.04 : screenWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Employment',
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
                          padding: EdgeInsets.all(isMobile ? screenWidth * 0.04 : screenWidth * 0.03),
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
                              const SizedBox(height: 8),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'List the most recent employment first. Only list employment positions, which can be supported by complete documentation.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.question_mark,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Employment Details Section
                              const Text(
                                'Employment Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(height: 16),

                              buildLabelledField(
                                'Business name',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Alternate/Former name(s) of the business',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                              ),

                              const SizedBox(height: 24),

                              // Employment Address Section
                              const Text(
                                'Employment Address',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(height: 16),

                              buildLabelledField(
                                'Street address',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                                isRequired: true,
                              ),
                              
                              // Multi-line street address field
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (isMobile) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          TextField(
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    
                                    return Row(
                                      children: [
                                        SizedBox(width: constraints.maxWidth * 0.35 + 16),
                                        Expanded(
                                          child: TextField(
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(4),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),

                              buildLabelledField(
                                'Suburb/City',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'State',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                              ),
                              buildLabelledField(
                                'Post code',
                                buildTextField(width: _getFieldWidth(screenWidth, 150)),
                              ),
                              buildLabelledField(
                                'Country',
                                buildDropdownField(width: _getFieldWidth(screenWidth, 250)),
                                isRequired: true,
                              ),

                              const SizedBox(height: 24),

                              // Employer Contact Details Section
                              const Text(
                                'Employer Contact Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(height: 16),

                              buildLabelledField(
                                'Name of employer/supervisor/manager',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Daytime telephone number',
                                buildTextField(width: _getFieldWidth(screenWidth, 200)),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Fax number',
                                buildTextField(width: _getFieldWidth(screenWidth, 200)),
                              ),
                              buildLabelledField(
                                'Mobile number',
                                buildTextField(width: _getFieldWidth(screenWidth, 200)),
                              ),
                              buildLabelledField(
                                'Email address',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Web address',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                              ),

                              const SizedBox(height: 24),

                              // Employment Details Section (second)
                              const Text(
                                'Employment Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(height: 16),

                              buildLabelledField(
                                'Position/Job title',
                                buildTextField(width: _getFieldWidth(screenWidth, 250)),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Date employment started',
                                buildDateField(),
                                isRequired: true,
                              ),

                              // Current employment radio buttons
                              buildLabelledField(
                                'Is applicant currently employed in this position?',
                                buildRadioButtons(),
                                isRequired: true,
                              ),

                              buildLabelledField(
                                'Date employment ended',
                                buildDateField(),
                                isRequired: true,
                              ),

                              // Unpaid leave row
                              buildLabelledField(
                                'Total length of unpaid leave',
                                buildNumberWithLabel('day(s)'),
                              ),

                              // Working hours row
                              buildLabelledField(
                                'Normal required working hours',
                                buildNumberWithLabel('hours per week'),
                                isRequired: true,
                              ),

                              const SizedBox(height: 24),

                              // Applicant's main tasks/duties Section
                              const Text(
                                'Applicant\'s main tasks/ duties/ responsibilities in this position',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4D4D4D),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Warning info box
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade50,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Colors.amber.shade300,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.amber.shade800,
                                    ),
                                    const SizedBox(width: 8),
                                    const Expanded(
                                      child: Text(
                                        'Please enter at least 5 tasks/duties/responsibilities in your employment position.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Tasks table with improved styling
                              buildTasksTable(),

                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 16 : 20,
                                        vertical: isMobile ? 8 : 12,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        taskControllers.add(TextEditingController());
                                      });
                                    },
                                    child: const Text('Add task'),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),

                              // Buttons row
                              Row(
                                mainAxisAlignment: isMobile 
                                    ? MainAxisAlignment.spaceEvenly 
                                    : MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 16 : 20,
                                        vertical: isMobile ? 8 : 12,
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text('Cancel'),
                                  ),
                                  SizedBox(width: isMobile ? 0 : 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 16 : 20,
                                        vertical: isMobile ? 8 : 12,
                                      ),
                                    ),
                                    onPressed: () {
                                      context.go('/licence_form');
                                    },
                                    child: const Text('Save & Continue'),
                                  ),
                                ],
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

  double _getFieldWidth(double screenWidth, double defaultWidth) {
    if (screenWidth < 768) {
      return screenWidth * 0.8; // Mobile: 80% of screen width
    } else if (screenWidth < 1024) {
      return screenWidth * 0.4; // Tablet: 40% of screen width
    } else {
      return defaultWidth; // Desktop: fixed width
    }
  }

  Widget buildTasksTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: const [
                SizedBox(
                  width: 50,
                  child: Text(
                    'No.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Task / Duty / Responsibility',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(width: 40), // Space for action button
              ],
            ),
          ),
          // Task rows
          ...List.generate(taskControllers.length, (index) => buildTaskRow(index + 1, index)),
        ],
      ),
    );
  }

  Widget buildTaskRow(int number, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: index == taskControllers.length - 1 ? 0 : 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                number.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: taskControllers[index],
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Task / Duty / Responsibility',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(
              width: 40,
              child: IconButton(
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                onPressed: () {
                  // Only allow deletion if there's more than one task
                  if (taskControllers.length > 1) {
                    setState(() {
                      // Dispose the controller before removing it
                      taskControllers[index].dispose();
                      taskControllers.removeAt(index);
                    });
                  }
                },
                constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabelledField(
    String label,
    Widget field, {
    bool isRequired = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          
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
                field,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.35,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
              ),
              const SizedBox(width: 8),
              field,
            ],
          );
        },
      ),
    );
  }

  Widget buildTextField({required double width}) {
    return SizedBox(
      width: width,
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.teal.shade400),
          ),
        ),
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.teal.shade400),
          ),
          hintText: 'dd/mm/yyyy',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
      ),
    );
  }

  Widget buildDropdownField({required double width}) {
    return SizedBox(
      width: width,
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

  Widget buildRadioButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          value: true,
          groupValue: isCurrentlyEmployed,
          onChanged: (value) {
            setState(() {
              if (value != null) isCurrentlyEmployed = value;
            });
          },
          activeColor: Colors.teal,
        ),
        const Text('Yes'),
        const SizedBox(width: 20),
        Radio<bool>(
          value: false,
          groupValue: isCurrentlyEmployed,
          onChanged: (value) {
            setState(() {
              if (value != null) isCurrentlyEmployed = value;
            });
          },
          activeColor: Colors.teal,
        ),
        const Text('No'),
      ],
    );
  }

  Widget buildNumberWithLabel(String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.teal.shade400),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}