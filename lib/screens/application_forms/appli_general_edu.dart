import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/providers/educationform_provider.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/screens/application_forms/appli_priority.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../../widgets/application_nav.dart';
import '../tertiary_education.dart';

class EducationForm extends ConsumerStatefulWidget {
  const EducationForm({super.key});

  @override
  ConsumerState<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends ConsumerState<EducationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _primaryDateStartedController = TextEditingController();
  final TextEditingController _primaryDateFinishedController = TextEditingController();
  final TextEditingController _primaryNumberOfYearsController = TextEditingController();
  final TextEditingController _primaryCountryController = TextEditingController();
  String? _primaryYearCompleted;

  // Controllers for Secondary School
  final TextEditingController _secondaryDateStartedController = TextEditingController();
  final TextEditingController _secondaryDateFinishedController = TextEditingController();
  final TextEditingController _secondaryNumberOfYearsController = TextEditingController();
  final TextEditingController _secondaryCountryController = TextEditingController();
  final TextEditingController _certificateDetailsController = TextEditingController();
  String? _certificateYearObtained;

  @override
  void dispose() {
    // Dispose all controllers
    _primaryDateStartedController.dispose();
    _primaryDateFinishedController.dispose();
    _primaryNumberOfYearsController.dispose();
    _primaryCountryController.dispose();
    _secondaryDateStartedController.dispose();
    _secondaryDateFinishedController.dispose();
    _secondaryNumberOfYearsController.dispose();
    _secondaryCountryController.dispose();
    _certificateDetailsController.dispose();
    super.dispose();
  }

  // Get user ID from login state
  int? get _currentUserId {
    final loginState = ref.read(loginProvider);
    return loginState.response?.userId;
  }

  // Generate year options for dropdowns
  List<String> get _yearOptions {
    final currentYear = DateTime.now().year;
    final years = <String>[];
    for (int year = currentYear; year >= 1950; year--) {
      years.add(year.toString());
    }
    return years;
  }

  // Update provider state when text fields change
  void _updateProviderState() {
    final provider = ref.read(educationFormProvider.notifier);
    
    // Update primary school data
    provider.updatePrimarySchool(
      dateStarted: _primaryDateStartedController.text.isNotEmpty ? _primaryDateStartedController.text : null,
      dateFinished: _primaryDateFinishedController.text.isNotEmpty ? _primaryDateFinishedController.text : null,
      numberOfYears: int.tryParse(_primaryNumberOfYearsController.text) ?? 0,
      country: _primaryCountryController.text,
      yearCompleted: int.tryParse(_primaryYearCompleted ?? '0'),
    );

    // Update secondary school data
    provider.updateSecondarySchool(
      dateStarted: _secondaryDateStartedController.text.isNotEmpty ? _secondaryDateStartedController.text : null,
      dateFinished: _secondaryDateFinishedController.text.isNotEmpty ? _secondaryDateFinishedController.text : null,
      numberOfYears: int.tryParse(_secondaryNumberOfYearsController.text) ?? 0,
      country: _secondaryCountryController.text,
    );

    // Update highest schooling certificate data
    provider.updateHighestSchoolingCertificate(
      certificateDetails: _certificateDetailsController.text,
      yearObtained: int.tryParse(_certificateYearObtained ?? '0') ?? 0,
    );
  }

  // Method to show date picker and return formatted date
  Future<void> _selectDate(TextEditingController controller, {bool isRequired = false}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Select Date',
      cancelText: 'Cancel',
      confirmText: 'OK',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.teal,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Format the date as dd/mm/yyyy
      final formattedDate = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      controller.text = formattedDate;
    }
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if user ID is available
    final userId = _currentUserId;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in. Please login again.')),
      );
      return;
    }
    
    _updateProviderState();
    
    // Validate form using provider
    if (!ref.read(educationFormProvider.notifier).validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields correctly.')),
      );
      return;
    }

    // Submit the form
    final success = await ref.read(educationFormProvider.notifier).submitEducationDetails(
      userId: userId,
    );
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Education details submitted successfully!')),
      );
      context.go('/tertiary_education_form');
    } else {
      final errorMessage = ref.read(educationFormProvider).errorMessage ?? 'Failed to submit. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final educationState = ref.watch(educationFormProvider);

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

                      // Form Container - WRAPPED IN FORM WIDGET
                      Form(
                        key: _formKey,
                        child: Container(
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
                                  buildDateField(_primaryDateStartedController),
                                ),
                                buildLabelledField(
                                  'Date finished',
                                  buildDateField(_primaryDateFinishedController),
                                ),
                                buildLabelledField(
                                  'Number of years',
                                  buildNumberField(_primaryNumberOfYearsController, isRequired: true),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Country(s)',
                                  buildCountryField(_primaryCountryController, isRequired: true),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Year completed',
                                  buildYearDropdown(
                                    value: _primaryYearCompleted,
                                    onChanged: (value) {
                                      setState(() {
                                        _primaryYearCompleted = value;
                                      });
                                    },
                                  ),
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
                                  buildDateField(_secondaryDateStartedController),
                                ),
                                buildLabelledField(
                                  'Date finished',
                                  buildDateField(_secondaryDateFinishedController),
                                ),
                                buildLabelledField(
                                  'Number of years',
                                  buildNumberField(_secondaryNumberOfYearsController, isRequired: true),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Country(s)',
                                  buildCountryField(_secondaryCountryController, isRequired: true),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Highest schooling\ncertificate obtained',
                                  buildCertificateField(_certificateDetailsController, isRequired: true),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Year obtained',
                                  buildYearDropdown(
                                    value: _certificateYearObtained,
                                    onChanged: (value) {
                                      setState(() {
                                        _certificateYearObtained = value;
                                      });
                                    },
                                    isRequired: true,
                                  ),
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
                                          onPressed: () {
                                            // Add your back navigation logic here
                                            context.pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                          onPressed: educationState.isLoading ? null : () {
                                            _updateProviderState();
                                            // Add save and exit logic here
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Data saved successfully!')),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                          onPressed: educationState.isLoading ? null : _continue,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                          ),
                                          child: educationState.isLoading
                                              ? const SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : const Text(
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
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

  Widget buildDateField(TextEditingController controller) {
    return SizedBox(
      width: 200, // Increased width to accommodate dd/mm/yyyy format
      height: 34,
      child: TextFormField(
        controller: controller,
        readOnly: true, // Make it read-only so users can't type
        onTap: () => _selectDate(controller), // Open calendar on tap
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: 'dd/mm/yyyy',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          suffixIcon: Icon(
            Icons.calendar_today,
            size: 16,
            color: Colors.grey.shade600,
          ),
        ),
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
            if (!regex.hasMatch(value)) {
              return 'Use dd/mm/yyyy format';
            }
          }
          return null;
        },
      ),
    );
  }

  Widget buildNumberField(TextEditingController controller, {bool isRequired = false}) {
    return SizedBox(
      width: 80,
      height: 34,
      child: TextFormField( // Changed from TextField to TextFormField
        controller: controller,
        validator: isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'Required';
          }
          // Additional validation for numbers
          if (int.tryParse(value) == null) {
            return 'Enter valid number';
          }
          return null;
        } : null,
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

  Widget buildCountryField(TextEditingController controller, {bool isRequired = false}) {
    return SizedBox(
      width: 250,
      height: 34,
      child: TextFormField( // Changed from TextField to TextFormField
        controller: controller,
        validator: isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'Country is required';
          }
          return null;
        } : null,
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

  Widget buildCertificateField(TextEditingController controller, {bool isRequired = false}) {
    return SizedBox(
      width: 250,
      height: 34,
      child: TextFormField( // Changed from TextField to TextFormField
        controller: controller,
        validator: isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'Certificate details required';
          }
          return null;
        } : null,
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

  Widget buildYearDropdown({
    String? value,
    required Function(String?) onChanged,
    bool isRequired = false,
  }) {
    return SizedBox(
      width: 200,
      height: 34,
      child: DropdownButtonFormField<String>( // Changed to DropdownButtonFormField
        value: value,
        validator: isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'Year is required';
          }
          return null;
        } : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        hint: Text(
          'Please pick a year',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
        icon: const Icon(Icons.arrow_drop_down),
        items: _yearOptions.map((String year) {
          return DropdownMenuItem<String>(
            value: year,
            child: Text(year),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}