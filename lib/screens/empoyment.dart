import 'package:flutter/material.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

class EmploymentForm extends StatefulWidget {
  const EmploymentForm({Key? key}) : super(key: key);

  @override
  State<EmploymentForm> createState() => _EmploymentFormState();
}

class _EmploymentFormState extends State<EmploymentForm> {
  bool isCurrentlyEmployed = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Space for left container, to be added in the future
          Container(
            width: screenWidth * 0.3,
          ),
          
          // Main content container
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
                                      border: Border.all(color: Colors.grey.shade700),
                                    ),
                                    child: const Icon(Icons.question_mark, size: 12),
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
                                buildTextField(width: 250),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Alternate/Former name(s) of the business',
                                buildTextField(width: 250),
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
                                buildTextField(width: 250),
                                isRequired: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.2),
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
                                            borderSide: BorderSide(color: Colors.grey.shade300),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              buildLabelledField(
                                'Suburb/City',
                                buildTextField(width: 250),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'State',
                                buildTextField(width: 250),
                              ),
                              buildLabelledField(
                                'Post code',
                                buildTextField(width: 150),
                              ),
                              buildLabelledField(
                                'Country',
                                buildDropdownField(width: 250),
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
                                buildTextField(width: 250),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Daytime telephone number',
                                buildTextField(width: 200),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Fax number',
                                buildTextField(width: 200),
                              ),
                              buildLabelledField(
                                'Mobile number',
                                buildTextField(width: 200),
                              ),
                              buildLabelledField(
                                'Email address',
                                buildTextField(width: 250),
                                isRequired: true,
                              ),
                              buildLabelledField(
                                'Web address',
                                buildTextField(width: 250),
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
                                buildTextField(width: 250),
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
                                  border: Border.all(color: Colors.amber.shade300),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline, color: Colors.amber.shade800),
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
                              
                              // Tasks table
                              Column(
                                children: [
                                  buildTaskRow(1),
                                  buildTaskRow(2),
                                  buildTaskRow(3),
                                  buildTaskRow(4),
                                  buildTaskRow(5),
                                ],
                              ),
                              
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: const Text('Add task'),
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 32),
                              
                              // Buttons row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: const Text('Cancel'),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {},
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
        ),
        const Text('No'),
      ],
    );
  }
  
  Widget buildNumberWithLabel(String label) {
    return Row(
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
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
  
  Widget buildTaskRow(int number) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              child: Text(
                number.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Task / Duty / Responsibility',
                ),
              ),
            ),
            IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
              onPressed: () {},
              constraints: const BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
              padding: EdgeInsets.zero,
              iconSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}