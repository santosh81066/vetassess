import 'package:flutter/material.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import 'appli_occupation.dart';

class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({super.key});

  @override
  PersonalDetailsFormState createState() => PersonalDetailsFormState();
}

class PersonalDetailsFormState extends State<PersonalDetailsForm> {
  String? selectedTitle;
  String? selectedGender = 'Male';
  String? selectedCountryOfBirth;
  String? selectedCountryOfResidence;
  String? selectedCitizenshipCountry;
  String? selectedOtherCitizenshipCountry;
  String? selectedPostalCountry;
  String? selectedHomeCountry;
  bool? authorizeAgent = true;

  @override
  Widget build(BuildContext context) {
    return LoginPageLayout(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Container(width: MediaQuery.of(context).size.width * 0.3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        'Personal Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        bottom: 100,
                        right: 125,
                      ),
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 100,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildRequiredFieldsNotice(),
                            ..._buildAllSections(),
                            _buildAuthorizationSection(),
                            _buildActionButtons(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRequiredFieldsNotice() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '* ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              'Required Fields',
              style: TextStyle(color: Colors.red.shade700, fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }

  List<Widget> _buildAllSections() {
    return [
      _buildSection('General Information', [
        _buildField(
          'Preferred title',
          _buildDropdown(selectedTitle, (v) => selectedTitle = v, 250),
          required: true,
        ),
        _buildField(
          'Surname or family name',
          _buildTextField(),
          required: true,
        ),
        _buildField('Given names', _buildTextField()),
        _buildField('Gender', _buildGenderRadioGroup(), required: true),
        _buildField('Previous surname or family name', _buildTextField()),
        _buildField('Previous given names', _buildTextField()),
        _buildField(
          'Date of birth (dd/mm/yyyy)',
          _buildTextField(250),
          required: true,
        ),
        _buildField(
          'Country of birth',
          _buildDropdown(
            selectedCountryOfBirth,
            (v) => selectedCountryOfBirth = v,
            250,
          ),
          required: true,
        ),
        _buildField(
          'Country of current residency',
          _buildDropdown(
            selectedCountryOfResidence,
            (v) => selectedCountryOfResidence = v,
            250,
          ),
          required: true,
        ),
      ]),

      _buildDivider(),

      _buildSection('Citizenship', [
        _buildField(
          'Country',
          _buildDropdown(
            selectedCitizenshipCountry,
            (v) => selectedCitizenshipCountry = v,
            250,
          ),
          required: true,
        ),
        _buildField('Current passport number', _buildTextField()),
        _buildField('Date passport issued', _buildTextField(250)),
      ]),

      _buildDivider(),

      _buildSection('Other Citizenship', [
        _buildField(
          'Country',
          _buildDropdown(
            selectedOtherCitizenshipCountry,
            (v) => selectedOtherCitizenshipCountry = v,
            250,
          ),
        ),
        _buildField('Current passport number', _buildTextField()),
        _buildField('Date passport issued', _buildTextField(250)),
      ]),

      _buildDivider(),

      _buildSection("Applicant's Contact Details", [
        _buildField('Email address', _buildTextField(), required: true),
        _buildField(
          'Daytime telephone number',
          _buildTextField(),
          required: true,
        ),
        _buildField('Fax number', _buildTextField()),
        _buildField('Mobile number', _buildTextField()),
      ]),

      _buildDivider(),

      _buildAddressSection(
        "Applicant's Postal Address",
        selectedPostalCountry,
        (v) => selectedPostalCountry = v,
      ),

      _buildDivider(),

      _buildAddressSection(
        "Applicant's Home Address",
        selectedHomeCountry,
        (v) => selectedHomeCountry = v,
        showCopyButton: true,
      ),
    ];
  }

  Widget _buildDivider() {
    return Column(
      children: [
        SizedBox(height: 16),
        Divider(color: Colors.grey.shade300, thickness: 1),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 16),
        ...fields,
      ],
    );
  }

  Widget _buildAddressSection(
    String title,
    String? selectedCountry,
    Function(String?) onCountryChanged, {
    bool showCopyButton = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 16),
        if (showCopyButton) ...[
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Copy from Postal Address',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
        _buildField('Street address', _buildMultiLineAddress(), required: true),
        _buildField('Suburb/City', _buildTextField(250), required: true),
        _buildField('State', _buildTextField(250)),
        _buildField('Post code', _buildTextField(250)),
        _buildField(
          'Country',
          _buildDropdown(selectedCountry, onCountryChanged, 250),
          required: true,
        ),
      ],
    );
  }

  Widget _buildField(String label, Widget field, {bool required = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Mobile layout: stack label and field vertically
          if (constraints.maxWidth < 600) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    if (required)
                      Text(
                        ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                field,
              ],
            );
          }

          // Desktop layout: side by side (original layout)
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(top: 12, right: 16),
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              if (required)
                Padding(
                  padding: EdgeInsets.only(top: 12, right: 4),
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Expanded(
                flex: 3,
                child: Align(alignment: Alignment.centerLeft, child: field),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField([double? maxWidth]) {
    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildMultiLineAddress() {
    return Column(
      children: [
        _buildTextField(), // Full width for address lines
        SizedBox(height: 8),
        _buildTextField(),
        SizedBox(height: 8),
        _buildTextField(),
      ],
    );
  }

  Widget _buildDropdown(
    String? value,
    Function(String?) onChanged, [
    double? maxWidth,
  ]) {
    return Container(
      constraints: maxWidth != null ? BoxConstraints(maxWidth: maxWidth) : null,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        hint: Text('Select one', style: TextStyle(color: Colors.grey.shade500)),
        items: [
          DropdownMenuItem(value: 'option1', child: Text('Option 1')),
          DropdownMenuItem(value: 'option2', child: Text('Option 2')),
        ],
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildGenderRadioGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile<String>(
          title: Text('Male'),
          value: 'Male',
          groupValue: selectedGender,
          onChanged: (value) => setState(() => selectedGender = value),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        RadioListTile<String>(
          title: Text('Female'),
          value: 'Female',
          groupValue: selectedGender,
          onChanged: (value) => setState(() => selectedGender = value),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        RadioListTile<String>(
          title: Text('Indeterminate/Intersex/Unspecified'),
          value: 'Indeterminate',
          groupValue: selectedGender,
          onChanged: (value) => setState(() => selectedGender = value),
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
      ],
    );
  }

  Widget _buildAuthorizationSection() {
    return Column(
      children: [
        _buildDivider(),
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Do you authorise an agent or representative to act for you in all matters concerned with this application?',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  // Mobile layout: stack radio buttons vertically
                  if (constraints.maxWidth < 400) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: authorizeAgent,
                              onChanged:
                                  (value) =>
                                      setState(() => authorizeAgent = value),
                            ),
                            Text('Yes'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: authorizeAgent,
                              onChanged:
                                  (value) =>
                                      setState(() => authorizeAgent = value),
                            ),
                            Text('No'),
                          ],
                        ),
                      ],
                    );
                  }

                  // Desktop layout: side by side (original layout)
                  return Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: authorizeAgent,
                        onChanged:
                            (value) => setState(() => authorizeAgent = value),
                      ),
                      Text('Yes'),
                      SizedBox(width: 24),
                      Radio<bool>(
                        value: false,
                        groupValue: authorizeAgent,
                        onChanged:
                            (value) => setState(() => authorizeAgent = value),
                      ),
                      Text('No'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildActionButtons() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile layout: stack buttons vertically
        if (constraints.maxWidth < 400) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Save & Exit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OccupationForm()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text('Continue', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        }

        // Desktop layout: side by side (original layout)
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text('Save & Exit', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OccupationForm()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
