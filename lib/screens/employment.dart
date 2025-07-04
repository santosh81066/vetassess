import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/providers/employment_provider.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../widgets/application_nav.dart';



class EmploymentForm extends ConsumerStatefulWidget {
  const EmploymentForm({super.key});

  @override
  ConsumerState<EmploymentForm> createState() => _EmploymentFormState();
}

class _EmploymentFormState extends ConsumerState<EmploymentForm> {
  List<TextEditingController> taskControllers = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text controllers for form fields
  late TextEditingController businessNameController;
  late TextEditingController alternateBusinsessnameController;
  late TextEditingController streetaddressController;
  late TextEditingController suburbCityController;
  late TextEditingController stateController;
  late TextEditingController postCodeController;
  late TextEditingController countryController;
  late TextEditingController nameofemployerController;
  late TextEditingController daytimePHnoController;
  late TextEditingController faxnumberController;
  late TextEditingController mobileNoController;
  late TextEditingController emailaddressController;
  late TextEditingController webaddressController;
  late TextEditingController positionJobTitleController;
  late TextEditingController dateofemploymentstartedController;
  late TextEditingController dateofemploymentendedController;
  late TextEditingController totallengthofUnpaidLeaveController;
  late TextEditingController normalrequiredWorkinghoursController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    businessNameController = TextEditingController();
    alternateBusinsessnameController = TextEditingController();
    streetaddressController = TextEditingController();
    suburbCityController = TextEditingController();
    stateController = TextEditingController();
    postCodeController = TextEditingController();
    countryController = TextEditingController();
    nameofemployerController = TextEditingController();
    daytimePHnoController = TextEditingController();
    faxnumberController = TextEditingController();
    mobileNoController = TextEditingController();
    emailaddressController = TextEditingController();
    webaddressController = TextEditingController();
    positionJobTitleController = TextEditingController();
    dateofemploymentstartedController = TextEditingController();
    dateofemploymentendedController = TextEditingController();
    totallengthofUnpaidLeaveController = TextEditingController();
    normalrequiredWorkinghoursController = TextEditingController();

    // Initialize task controllers with initial tasks from provider
    taskControllers = List.generate(5, (index) => TextEditingController());
  }

  @override
  void dispose() {
    // Dispose all controllers
    businessNameController.dispose();
    alternateBusinsessnameController.dispose();
    streetaddressController.dispose();
    suburbCityController.dispose();
    stateController.dispose();
    postCodeController.dispose();
    countryController.dispose();
    nameofemployerController.dispose();
    daytimePHnoController.dispose();
    faxnumberController.dispose();
    mobileNoController.dispose();
    emailaddressController.dispose();
    webaddressController.dispose();
    positionJobTitleController.dispose();
    dateofemploymentstartedController.dispose();
    dateofemploymentendedController.dispose();
    totallengthofUnpaidLeaveController.dispose();
    normalrequiredWorkinghoursController.dispose();

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
    
    final employmentState = ref.watch(employmentProvider);

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Navigation sidebar
          Container(
            width: isMobile ? 0 : MediaQuery.of(context).size.width * 0.3,
            child: isMobile ? const SizedBox.shrink() : Align(
              alignment: Alignment.topRight,
               child: ApplicationNavWithProgress(
                  currentRoute: '/employment_form',
            completedRoutes: {
              '/personal_form',
              '/occupation_form',
              '/education_form',
             '/tertiary_education_form',
              // '/employment_form',
              // '/licence_form',
              // '/app_priority_form',
            },
              ),
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
                  child: Form(
                    key: _formKey,
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

                        // Error display
                        if (employmentState.error != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.red.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline, color: Colors.red.shade800),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    employmentState.error!,
                                    style: TextStyle(color: Colors.red.shade800),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => ref.read(employmentProvider.notifier).clearError(),
                                ),
                              ],
                            ),
                          ),

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
                                  buildTextField(
                                    controller: businessNameController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateBusinessName(value),
                                  isRequired: true,
                                  ),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Alternate/Former name(s) of the business',
                                  buildTextField(
                                    controller: alternateBusinsessnameController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateAlternateBusinsessname(value),
                                  //  isRequired: true,
                                  ),
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
                                  buildTextField(
                                    controller: streetaddressController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateStreetaddress(value),
                                   isRequired: true,
                                  ),
                                  isRequired: true,
                                ),
                                
                                buildLabelledField(
                                  'Suburb/City',
                                  buildTextField(
                                    controller: suburbCityController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateSuburbCity(value),
                                  isRequired: true,
                                  ),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'State',
                                  buildTextField(
                                    controller: stateController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateState(value),
                                  //  isRequired: true,
                                  ),
                                ),
                                buildLabelledField(
                                  'Post code',
                                  buildTextField(
                                    controller: postCodeController,
                                    width: _getFieldWidth(screenWidth, 150),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updatePostCode(value),
                                    // isRequired: true,
                                  ),
                                ),
                                buildLabelledField(
                                  'Country',
                                  buildDropdownField(width: _getFieldWidth(screenWidth, 250),isRequired: true),
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
                                  buildTextField(
                                    controller: nameofemployerController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateNameofemployer(value),
                                 isRequired: true,
                                  ),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Daytime telephone number',
                                  buildTextField(
                                    controller: daytimePHnoController,
                                    width: _getFieldWidth(screenWidth, 200),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateDaytimePHno(value),
                                  isRequired: true,
                                  ),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Fax number',
                                  buildTextField(
                                    controller: faxnumberController,
                                    width: _getFieldWidth(screenWidth, 200),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateFaxnumber(value),
                                  //  isRequired: true,
                                  ),
                                ),
                                buildLabelledField(
                                  'Mobile number',
                                  buildTextField(
                                    controller: mobileNoController,
                                    width: _getFieldWidth(screenWidth, 200),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateMobileNo(value),
                                  //  isRequired: true,
                                  ),
                                ),
                                buildLabelledField(
                                  'Email address',
                                  buildTextField(
                                    controller: emailaddressController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateEmailaddress(value),
                                  isRequired: true,
                                  ),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Web address',
                                  buildTextField(
                                    controller: webaddressController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateWebaddress(value),
                                  //  isRequired: true,
                                  ),
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
                                  buildTextField(
                                    controller: positionJobTitleController,
                                    width: _getFieldWidth(screenWidth, 250),
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updatePositionJobTitle(value),
                                 isRequired: true,
                                  ),
                                  isRequired: true,
                                ),
                                buildLabelledField(
                                  'Date employment started',
                                  buildDateField(
                                    controller: dateofemploymentstartedController,
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateDateofemploymentstarted(value),
                                   
                                  ),
                                  isRequired: true,
                                ),

                                // Current employment radio buttons
                                buildLabelledField(
                                  'Is applicant currently employed in this position?',
                                  buildRadioButtons(employmentState.isapplicantemployed),
                                  isRequired: true,
                                ),

                                 if (!employmentState.isapplicantemployed)
  buildLabelledField(
    'Date employment ended',
    buildDateField(
      controller: dateofemploymentendedController,
      onChanged: (value) =>
          ref.read(employmentProvider.notifier).updateDateofemploymentended(value),
      isRequired: true,
    ),
    isRequired: true,
  ),


                                // Unpaid leave row
                                buildLabelledField(
                                  'Total length of unpaid leave',
                                  buildNumberWithLabel(
                                    'day(s)',
                                    controller: totallengthofUnpaidLeaveController,
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateTotallengthofUnpaidLeave(value),
                                  
                                  ),
                                ),

                                // Working hours row
                                buildLabelledField(
                                  'Normal required working hours',
                                  buildNumberWithLabel(
                                    'hours per week',
                                    controller: normalrequiredWorkinghoursController,
                                    onChanged: (value) => ref.read(employmentProvider.notifier).updateNormalrequiredWorkinghours(value),
                                  
                                  ),
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
                                buildTasksTable(employmentState.tasks),

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
                                        ref.read(employmentProvider.notifier).addTask();
                                        taskControllers.add(TextEditingController());
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
                                        backgroundColor: Colors.grey,
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: isMobile ? 16 : 20,
                                          vertical: isMobile ? 8 : 12,
                                        ),
                                      ),
                                      onPressed: employmentState.isLoading ? null : () {
                                        ref.read(employmentProvider.notifier).resetForm();
                                        _clearAllControllers();
                                      },
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
                                     onPressed: employmentState.isLoading ? null : () async {
                                        if (_formKey.currentState!.validate()) {
                                          final success = await ref.read(employmentProvider.notifier).submitEmployment();

                                          if (success) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Success'),
                                                content: const Text('Employment data submitted successfully!'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      context.go('/licence_form');
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Submission Failed'),
                                                content: Text(
                                                  employmentState.error ?? 'Something went wrong. Please try again.',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (context) => const AlertDialog(
                                              title: Text('Incomplete Form'),
                                              content: Text('Please fill all required fields before continuing.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: null,
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },

                                      child: employmentState.isLoading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text('Save & Continue'),
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
          ),
        ],
      ),
    );
  }

  void _clearAllControllers() {
    businessNameController.clear();
    alternateBusinsessnameController.clear();
    streetaddressController.clear();
    suburbCityController.clear();
    stateController.clear();
    postCodeController.clear();
    countryController.clear();
    nameofemployerController.clear();
    daytimePHnoController.clear();
    faxnumberController.clear();
    mobileNoController.clear();
    emailaddressController.clear();
    webaddressController.clear();
    positionJobTitleController.clear();
    dateofemploymentstartedController.clear();
    dateofemploymentendedController.clear();
    totallengthofUnpaidLeaveController.clear();
    normalrequiredWorkinghoursController.clear();
    
    for (var controller in taskControllers) {
      controller.clear();
    }
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

  Widget buildTasksTable(List<String> tasks) {
    // Ensure we have enough controllers for all tasks
    while (taskControllers.length < tasks.length) {
      taskControllers.add(TextEditingController());
    }
    
    // Set the text for each controller
    for (int i = 0; i < tasks.length && i < taskControllers.length; i++) {
      if (taskControllers[i].text != tasks[i]) {
        taskControllers[i].text = tasks[i];
      }
    }

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
          ...List.generate(tasks.length, (index) => buildTaskRow(index + 1, index)),
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
                onChanged: (value) {
                  ref.read(employmentProvider.notifier).updateTask(index, value);
                },
                validator: (value) {
                  if (index < 5 && (value == null || value.trim().isEmpty)) {
                    return 'This field is required';
                  }
                  return null;
                },
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
                    // Dispose the controller before removing it
                    taskControllers[index].dispose();
                    taskControllers.removeAt(index);
                    ref.read(employmentProvider.notifier).removeTask(index);
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

  Widget buildTextField({
    required double width,
    required TextEditingController controller,
    required Function(String) onChanged,
    bool isRequired = false,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: width,
      height: 60,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
         validator: validator ?? (isRequired
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return 'This field is required';
              }
              return null;
            }
          : null),
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
            helperText: ' ', // Reserve space for error message
        errorStyle: const TextStyle(fontSize: 12, height: 1),
        ),
      ),
    );
  }

  Widget buildDateField({
    required TextEditingController controller,
    required Function(String) onChanged,
     bool isRequired = false,
  }) {
    return SizedBox(
      width: 150,
      height: 60,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
         validator: (value) {
         if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Date is required';
        }
        return null;
      },
        decoration: InputDecoration(
          hintText: 'yyy-mm-dd',
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
          helperText: ' ',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
        // validator: (value) {
        //   if (value == null || value.trim().isEmpty) {
        //     return 'Date is required';
        //   }
        //   return null;
        // },
      ),
    );
  }

 Widget buildDropdownField({
  required double width,
  bool isRequired = false,
}) {
  return SizedBox(
    width: width,
    height: 60,
    child: DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.teal.shade400),
        ),
        helperText: ' ',
        errorStyle: const TextStyle(fontSize: 12, height: 1),
      ),
      hint: Text(
        'Select one',
        style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      items: ['Australia', 'India', 'USA', 'UK', 'Canada']
          .map((country) => DropdownMenuItem(
                value: country,
                child: Text(country),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          ref.read(employmentProvider.notifier).updateCountry(value);
        }
      },
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Country is required';
              }
              return null;
            }
          : null,
    ),
  );
}

  Widget buildRadioButtons(bool currentValue) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<bool>(
          value: true,
          groupValue: currentValue,
          onChanged: (value) {
            if (value != null) {
              ref.read(employmentProvider.notifier).updateIsapplicantemployed(value);
            }
          },
          activeColor: Colors.teal,
        ),
        const Text('Yes'),
        const SizedBox(width: 20),
        Radio<bool>(
          value: false,
          groupValue: currentValue,
          onChanged: (value) {
            if (value != null) {
              ref.read(employmentProvider.notifier).updateIsapplicantemployed(value);
            }
          },
          activeColor: Colors.teal,
        ),
        const Text('No'),
      ],
    );
  }

  Widget buildNumberWithLabel(
    String label, {
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80,
          height: 60,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
             keyboardType: TextInputType.number,
    validator: label.contains('hours per week')
        ? (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Required';
            }
            return null;
          }
        : null,
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
               helperText: ' ',
               errorStyle: const TextStyle(fontSize: 12, height: 1),
            ),
           
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}