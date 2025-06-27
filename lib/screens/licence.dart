// Updated licence_form.dart with API integration

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/login_page_layout.dart';
import '../providers/category_country_provider.dart';
import '../providers/licence_provider.dart'; // Add this import
import '../models/category_country_models.dart';
import '../models/licence_models.dart'; // Add this import
import '../widgets/application_nav.dart';

class LicenceForm extends ConsumerStatefulWidget {
  const LicenceForm({super.key});

  @override
  ConsumerState<LicenceForm> createState() => _LicenceFormState();
}

class _LicenceFormState extends ConsumerState<LicenceForm> {
  String? _currentStatus;
  Category? _selectedCategory;
  Country? _selectedCountry;

  // Form controllers
  final _issuingBodyController = TextEditingController();
  final _licenceTypeController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _statusDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoriesProvider.notifier).fetchCategories();
      ref.read(countriesProvider.notifier).fetchCountries();
    });
  }

  @override
  void dispose() {
    _issuingBodyController.dispose();
    _licenceTypeController.dispose();
    _registrationNumberController.dispose();
    _expiryDateController.dispose();
    _statusDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;

    // Listen to licence provider state
    ref.listen<LicenceState>(licenceProvider, (previous, next) {
      if (next.error != null) {
        _showErrorSnackBar(next.error!);
        ref.read(licenceProvider.notifier).clearError();
      } else if (next.response != null) {
        _showSuccessSnackBar(next.response!.message);
        // Navigate to next page on success
        context.go('/app_priority_form');
        ref.read(licenceProvider.notifier).clearResponse();
      }
    });

    final licenceState = ref.watch(licenceProvider);

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation Panel
          SizedBox(
            width:
                isMobile
                    ? size.width * 0.25
                    : isTablet
                    ? size.width * 0.28
                    : size.width * 0.3,
            child: Align(
              alignment: Alignment.topRight,
               child: ApplicationNavWithProgress(
                  currentRoute: '/licence_form',
            completedRoutes: {
              '/personal_form',
              '/occupation_form',
              '/education_form',
             '/tertiary_education_form',
               '/employment_form',
              // '/licence_form',
              // '/app_priority_form',
            },
              )
            ),
          ),

          // Main Content
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: size.height * 0.02,
                left: size.width * (isMobile ? 0.01 : 0.02),
                bottom: size.height * 0.12,
                right: size.width * (isMobile ? 0.01 : 0.02),
              ),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(
                    size.width * (isMobile ? 0.015 : 0.025),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Licence',
                        style: TextStyle(
                          fontSize: isMobile ? 20 : 24,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4D4D4D),
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
                            size.width * (isMobile ? 0.02 : 0.03),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Required Fields
                              const Row(
                                children: [
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

                              Text(
                                'Complete details about licences / registrations / memberships.',
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  color: const Color(0xFF4D4D4D),
                                ),
                              ),
                              SizedBox(height: isMobile ? 16 : 20),
                              const Divider(
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                              SizedBox(height: isMobile ? 16 : 20),

                              // Form Fields
                              ...buildFormFields(),

                              SizedBox(height: isMobile ? 16 : 20),
                              const Divider(
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                              SizedBox(height: isMobile ? 16 : 20),

                              // Buttons
                              Center(
                                child:
                                    isMobile
                                        ? Column(
                                          children: [
                                            buildButton('Cancel', () {}),
                                            const SizedBox(height: 10),
                                            buildButton(
                                              'Save & Continue',
                                              licenceState.isLoading
                                                  ? null
                                                  : () => _saveAndContinue(),
                                              isLoading: licenceState.isLoading,
                                            ),
                                          ],
                                        )
                                        : Wrap(
                                          spacing: 15,
                                          runSpacing: 10,
                                          children: [
                                            buildButton('Cancel', () {}),
                                            buildButton(
                                              'Save & Continue',
                                              licenceState.isLoading
                                                  ? null
                                                  : () => _saveAndContinue(),
                                              isLoading: licenceState.isLoading,
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

  List<Widget> buildFormFields() {
    return [
      buildLabelledField('Category', buildCategoryDropdown(), isRequired: true),
      buildLabelledField(
        'Country of issuer',
        buildCountryDropdown(),
        isRequired: true,
      ),
      buildLabelledField(
        'Name of issuing body',
        buildTextField(_issuingBodyController),
        isRequired: true,
      ),
      buildLabelledField(
        'Type of licence / registration / membership',
        buildTextField(_licenceTypeController),
        isRequired: true,
      ),
      buildLabelledField(
        'Registration number',
        buildTextField(_registrationNumberController),
        isRequired: true,
      ),
      buildLabelledField('Date of expiry', buildDateField()),
      buildLabelledField(
        'Current status',
        buildCurrentStatusDropdown(),
        isRequired: true,
      ),
      if (_currentStatus == 'Other')
        buildLabelledField(
          'Current status detail',
          buildTextField(_statusDetailController),
          isRequired: true,
        ),
    ];
  }

  Widget buildCategoryDropdown() {
    final categoriesState = ref.watch(categoriesProvider);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;

    return SizedBox(
      width:
          isMobile
              ? double.infinity
              : isTablet
              ? 200
              : 250,
      height: 34,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<Category>(
              isExpanded: true,
              value: _selectedCategory,
              hint: Text(
                categoriesState.isLoading
                    ? 'Loading...'
                    : categoriesState.error != null
                    ? 'Error loading'
                    : 'Select category',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              ),
              icon:
                  categoriesState.isLoading
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Icon(Icons.arrow_drop_down),
              items:
                  categoriesState.categories
                      .map(
                        (category) => DropdownMenuItem<Category>(
                          value: category,
                          child: Text(
                            category.category,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
              onChanged:
                  categoriesState.isLoading
                      ? null
                      : (Category? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCountryDropdown() {
    final countriesState = ref.watch(countriesProvider);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;

    return SizedBox(
      width:
          isMobile
              ? double.infinity
              : isTablet
              ? 200
              : 250,
      height: 34,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<Country>(
              isExpanded: true,
              value: _selectedCountry,
              hint: Text(
                countriesState.isLoading
                    ? 'Loading...'
                    : countriesState.error != null
                    ? 'Error loading'
                    : 'Select country',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              ),
              icon:
                  countriesState.isLoading
                      ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Icon(Icons.arrow_drop_down),
              items:
                  countriesState.countries
                      .map(
                        (country) => DropdownMenuItem<Country>(
                          value: country,
                          child: Text(
                            country.country,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
              onChanged:
                  countriesState.isLoading
                      ? null
                      : (Country? newValue) {
                        setState(() {
                          _selectedCountry = newValue;
                        });
                      },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(
    String text,
    VoidCallback? onPressed, {
    bool isLoading = false,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SizedBox(
      width: isMobile ? double.infinity : null,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 16),
        ),
        child:
            isLoading
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                : Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
      ),
    );
  }

  Widget buildLabelledField(
    String label,
    Widget field, {
    bool isRequired = false,
  }) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;

    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 16.0 : 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
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

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width:
                    isTablet
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
              Align(alignment: Alignment.centerLeft, child: field),
            ],
          );
        },
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller, {
    String hintText = '',
    double? width,
  }) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;

    return SizedBox(
      width:
          width ??
          (isMobile
              ? double.infinity
              : isTablet
              ? 200
              : 250),
      height: 34,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
      ),
    );
  }

  Widget buildDateField() => GestureDetector(
    onTap: () => _selectDate(context),
    child: AbsorbPointer(
      child: buildTextField(
        _expiryDateController,
        hintText: 'yyyy-mm-dd',
        width: _getFieldWidth(isSmaller: true),
      ),
    ),
  );

  double _getFieldWidth({bool isSmaller = false}) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;

    if (isMobile) return double.infinity;
    if (isTablet) return isSmaller ? 150 : 200;
    return isSmaller ? 180 : 250;
  }

  Widget buildCurrentStatusDropdown() {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1024;

    const statusOptions = ['Active', 'Expired', 'Renewed', 'Other'];

    return SizedBox(
      width:
          isMobile
              ? double.infinity
              : isTablet
              ? 160
              : 180,
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
              value: _currentStatus,
              hint: Text(
                'Select one',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              items:
                  statusOptions
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(
                            status,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
              onChanged:
                  (newValue) => setState(() => _currentStatus = newValue),
            ),
          ),
        ),
      ),
    );
  }

  void _saveAndContinue() {
    // Validation
    if (_selectedCategory == null) {
      _showErrorSnackBar('Please select a category');
      return;
    }
    if (_selectedCountry == null) {
      _showErrorSnackBar('Please select a country');
      return;
    }
    if (_issuingBodyController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter the name of issuing body');
      return;
    }
    if (_licenceTypeController.text.trim().isEmpty) {
      _showErrorSnackBar(
        'Please enter the type of licence/registration/membership',
      );
      return;
    }
    if (_registrationNumberController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter the registration number');
      return;
    }
    if (_expiryDateController.text.trim().isNotEmpty) {
      final dateText = _expiryDateController.text.trim();
      if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateText)) {
        _showErrorSnackBar('Please enter date in yyyy-mm-dd format');
        return;
      }

      // Validate if it's a valid date
      try {
        DateTime.parse(dateText);
      } catch (e) {
        _showErrorSnackBar('Please enter a valid date');
        return;
      }
    }
    if (_currentStatus == null) {
      _showErrorSnackBar('Please select current status');
      return;
    }
    if (_currentStatus == 'Other' &&
        _statusDetailController.text.trim().isEmpty) {
      _showErrorSnackBar('Please enter current status detail');
      return;
    }

    // Create licence request
    final licenceRequest = LicenceRequest(
      categoryId: _selectedCategory!.id,
      countryId: _selectedCountry!.id,
      nameofIssuingBody: _issuingBodyController.text.trim(),
      typeOfLicence: _licenceTypeController.text.trim(),
      registrationNumber: _registrationNumberController.text.trim(),
      dateOfExpiry:
          _expiryDateController.text.trim().isEmpty
              ? null
              : _formatDate(_expiryDateController.text.trim()),
      currentStatus: _currentStatus!,
      currentStatusDetail:
          _currentStatus == 'Other'
              ? _statusDetailController.text.trim()
              : null,
    );

    // Call API
    ref.read(licenceProvider.notifier).addLicence(licenceRequest);
  }

  String _formatDateForDisplay(DateTime date) {
    return '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      helpText: 'Select expiry date',
      cancelText: 'Cancel',
      confirmText: 'OK',
    );

    if (picked != null) {
      setState(() {
        _expiryDateController.text = _formatDateForDisplay(picked);
      });
    }
  }

  // 3. Update the _formatDate method (for API submission)
  String _formatDate(String date) {
    // If date is already in yyyy-mm-dd format, return as is
    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(date)) {
      return date;
    }

    // Handle MM/yyyy format (legacy support)
    if (date.contains('/')) {
      final parts = date.split('/');
      if (parts.length == 2) {
        final month = parts[0].padLeft(2, '0');
        final year = parts[1];
        return '$year-$month-01';
      }
    }

    return date;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
