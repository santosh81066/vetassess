import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vetassess/providers/get_allforms_providers.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/models/get_forms_model.dart';

class ReviewAndConfirm extends ConsumerStatefulWidget {
  const ReviewAndConfirm({super.key});

  @override
  ConsumerState<ReviewAndConfirm> createState() => _ReviewAndConfirmState();
}

class _ReviewAndConfirmState extends ConsumerState<ReviewAndConfirm> {
  int? currentUserId;
  bool isLoading = true;

  // Add editing state and controllers
  bool isEditingMode = false;
  Map<String, TextEditingController> controllers = {};

  // 4. Helper method to get or create controller
  TextEditingController _getController(String key, String initialValue) {
    if (!controllers.containsKey(key)) {
      controllers[key] = TextEditingController(text: initialValue);
    }
    return controllers[key]!;
  }

  Map<String, bool> checkboxValues = {};

  bool _getCheckboxValue(String key, bool defaultValue) {
    return checkboxValues[key] ?? defaultValue;
  }

  void _setCheckboxValue(String key, bool value) {
    checkboxValues[key] = value;
  }

  @override
  void dispose() {
    // Don't forget to dispose controllers
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchformsCategories();
    });
  }

  Future<void> _fetchformsCategories() async {
    await ref.read(getAllformsProviders.notifier).fetchallCategories();
    setState(() {
      isLoading = false;
    });
  }

  Map<String, dynamic> _buildUpdateRequestBody(Users currentUser) {
    return {
      "userId": currentUser.userId,
      "personalDetails":
          currentUser.personalDetails?.isNotEmpty == true
              ? currentUser.personalDetails!.first.toJson()
              : null,
      "educationQualifications":
          currentUser.educationQualifications
              ?.map((eq) => eq.toJson())
              .toList(),
      "educations": currentUser.educations?.map((e) => e.toJson()).toList(),
      "employments":
          currentUser.employments?.map((emp) => emp.toJson()).toList(),
      "uploadedDocuments":
          currentUser.uploadedDocuments?.map((doc) => doc.toJson()).toList(),
      "userVisas": currentUser.userVisas?.map((visa) => visa.toJson()).toList(),
      "userOccupations":
          currentUser.userOccupations?.map((occ) => occ.toJson()).toList(),
      "licences": currentUser.licences?.map((lic) => lic.toJson()).toList(),
      "priorityProcess":
          currentUser.priorityProcess?.isNotEmpty == true
              ? currentUser.priorityProcess!.first.toJson()
              : null,
    };
  }

  Future<void> _deleteFormSection(String sectionType, int itemId) async {
    final confirmed = await _showDeleteConfirmationDialog(sectionType);
    if (confirmed) {
      // Implement delete API call here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$sectionType deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      // Refresh data after deletion
      _fetchformsCategories();
    }
  }

  Future<bool> _showDeleteConfirmationDialog(String sectionType) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete $sectionType'),
              content: Text(
                'Are you sure you want to delete this $sectionType?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  // void _editAllForms(Users userData) {
  //   // Navigate to edit page for all forms
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => EditAllFormsPage(
  //         userData: userData,
  //       ),
  //     ),
  //   ).then((_) {
  //     // Refresh data after editing
  //     _fetchformsCategories();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final loginid = ref.read(loginProvider).response?.userId;
    final data = ref.read(getAllformsProviders).users;
    final filteredData =
        data?.where((item) => item.userId == loginid).toList() ?? [];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Review & Confirm',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00565B),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchformsCategories,
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00565B)),
                ),
              )
              : filteredData.isEmpty
              ? _buildEmptyState()
              : _buildFormsList(filteredData),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No forms found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start by filling out your first form',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildFormsList(List<Users> users) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: users.map((user) => _buildUserCard(user)).toList(),
      ),
    );
  }

  Widget _buildUserCard(Users user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserHeader(user),
            const SizedBox(height: 16),
            _buildSectionsList(user),
            const SizedBox(height: 16),
            // Overall Edit Button
            // _buildOverallEditButton(user),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader(Users user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00565B), Color(0xFF00565B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Text(
              (user.givenNames?.isNotEmpty == true &&
                      user.surname?.isNotEmpty == true)
                  ? '${user.givenNames![0]}${user.surname![0]}'
                  : 'U',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF00565B),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.givenNames ?? ''} ${user.surname ?? ''}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.email ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildOverallEditButton(Users user) {
  //   return Container(
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       onPressed: () => _editAllForms(user),
  //       icon: const Icon(Icons.edit, color: Colors.white),
  //       label: const Text(
  //         'Edit All Forms',
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //           color: Colors.white,
  //         ),
  //       ),
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(0xFF1976D2),
  //         padding: const EdgeInsets.symmetric(vertical: 16),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         elevation: 2,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSectionsList(Users user) {
    return Column(
      children: [
        if (user.personalDetails?.isNotEmpty == true)
          _buildSection(
            'Personal Details',
            Icons.person,
            user.personalDetails!.length,
            Colors.blue,
            () => _showPersonalDetailsDialog(user.personalDetails!),
          ),
        if (user.educationQualifications?.isNotEmpty == true)
          _buildSection(
            'Education Qualifications',
            Icons.school,
            user.educationQualifications!.length,
            Colors.green,
            () => _showEducationQualificationsDialog(
              user.educationQualifications!,
            ),
          ),
        if (user.educations?.isNotEmpty == true)
          _buildSection(
            'Educations',
            Icons.cast_for_education,
            user.educations!.length,
            Colors.orange,
            () => _showEducationsDialog(user.educations!),
          ),
        if (user.employments?.isNotEmpty == true)
          _buildSection(
            'Employments',
            Icons.work,
            user.employments!.length,
            Colors.purple,
            () => _showEmploymentsDialog(user.employments!),
          ),
        if (user.uploadedDocuments?.isNotEmpty == true)
          _buildSection(
            'Uploaded Documents',
            Icons.file_upload,
            user.uploadedDocuments!.length,
            Colors.teal,
            () => _showDocumentsDialog(user.uploadedDocuments!),
          ),
        if (user.userVisas?.isNotEmpty == true)
          _buildSection(
            'Visas',
            Icons.flight_takeoff,
            user.userVisas!.length,
            Colors.indigo,
            () => _showVisasDialog(user.userVisas!),
          ),
        if (user.userOccupations?.isNotEmpty == true)
          _buildSection(
            'Occupations',
            Icons.business_center,
            user.userOccupations!.length,
            Colors.brown,
            () => _showOccupationsDialog(user.userOccupations!),
          ),
        if (user.licences?.isNotEmpty == true)
          _buildSection(
            'Licences',
            Icons.verified,
            user.licences!.length,
            Colors.red,
            () => _showLicencesDialog(user.licences!),
          ),
        if (user.priorityProcess?.isNotEmpty == true)
          _buildSection(
            'Priority Process',
            Icons.priority_high,
            user.priorityProcess!.length,
            Colors.deepOrange,
            () => _showPriorityProcessDialog(user.priorityProcess!),
          ),
      ],
    );
  }

  Widget _buildSection(
    String title,
    IconData icon,
    int count,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$count item${count > 1 ? 's' : ''}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dialog methods for each section (now only with delete functionality)
  void _showPersonalDetailsDialog(List<PersonalDetails> details) {
    _showItemsDialog(
      'Personal Details',
      details,
      (item, isEditing) => _buildPersonalDetailsItem(item, isEditing),
      (item) =>
          _deleteFormSection('Personal Details', item.personalDetailsId ?? 0),
      (item) => _savePersonalDetails(item), // Add save method
    );
  }

  void _showEducationQualificationsDialog(
    List<EducationQualifications> qualifications,
  ) {
    _showItemsDialog(
      'Education Qualifications',
      qualifications,
      (item, isEditing) => _buildEducationQualificationItem(item, isEditing),
      (item) =>
          _deleteFormSection('Education Qualifications', item.educationId ?? 0),
      (item) => _saveEducationQualification(item),
    );
  }

  // Educations
  void _showEducationsDialog(List<Educations> educations) {
    _showItemsDialog(
      'Educations',
      educations,
      (item, isEditing) => _buildEducationItem(item, isEditing),
      (item) => _deleteFormSection('Educations', item.educationId ?? 0),
      (item) => _saveEducation(item),
    );
  }

  void _showEmploymentsDialog(List<Employments> employments) {
    _showItemsDialog(
      'Employments',
      employments,
      (item, isEditing) => _buildEmploymentItem(item, isEditing),
      (item) => _deleteFormSection('Employments', item.id ?? 0),
      (item) => _saveEmployment(item),
    );
  }

  void _showDocumentsDialog(List<UploadedDocuments> documents) {
    _showItemsDialog(
      'Uploaded Documents',
      documents,
      (item, isEditing) => _buildDocumentItem(item, isEditing),
      (item) => _deleteFormSection('Uploaded Documents', item.id ?? 0),
      (item) => _saveDocument(item),
    );
  }

  // User Visas
  void _showVisasDialog(List<UserVisas> visas) {
    _showItemsDialog(
      'Visas',
      visas,
      (item, isEditing) => _buildVisaItem(item, isEditing),
      (item) => _deleteFormSection('Visas', item.id ?? 0),
      (item) => _saveVisa(item),
    );
  }

  // User Occupations
  void _showOccupationsDialog(List<UserOccupations> occupations) {
    _showItemsDialog(
      'Occupations',
      occupations,
      (item, isEditing) => _buildOccupationItem(item, isEditing),
      (item) => _deleteFormSection('Occupations', item.id ?? 0),
      (item) => _saveOccupation(item),
    );
  }

  void _showLicencesDialog(List<Licences> licences) {
    _showItemsDialog(
      'Licences',
      licences,
      (item, isEditing) => _buildLicenceItem(item, isEditing),
      (item) => _deleteFormSection('Licences', item.id ?? 0),
      (item) => _saveLicence(item),
    );
  }

  void _showPriorityProcessDialog(List<PriorityProcess> processes) {
    _showItemsDialog(
      'Priority Process',
      processes,
      (item, isEditing) => _buildPriorityProcessItem(item, isEditing),
      (item) => _deleteFormSection('Priority Process', item.id ?? 0),
      (item) => _savePriorityProcess(item),
    );
  }

  // 2. Modified _showItemsDialog to support editing
  void _showItemsDialog<T>(
    String title,
    List<T> items,
    Widget Function(T, bool) itemBuilder, // Added isEditing parameter
    void Function(T) onDelete,
    void Function(T) onSave, // Added save callback
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Changed to StatefulBuilder for local state
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 600,
                  maxWidth: 500,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isEditingMode ? Icons.save : Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setDialogState(() {
                                isEditingMode = !isEditingMode;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                itemBuilder(
                                  item,
                                  isEditingMode,
                                ), // Pass editing state
                                _buildActionButtons(
                                  onDelete: () => onDelete(item),
                                  onSave:
                                      isEditingMode ? () => onSave(item) : null,
                                  isEditing: isEditingMode,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // 3. Updated action buttons
  Widget _buildActionButtons({
    required VoidCallback onDelete,
    VoidCallback? onSave,
    required bool isEditing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isEditing && onSave != null)
            TextButton.icon(
              onPressed: onSave,
              icon: const Icon(Icons.save, size: 16),
              label: const Text('Save'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          if (isEditing && onSave != null) const SizedBox(width: 8),
          TextButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete, size: 16),
            label: const Text('Delete'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  // 6. Updated item builder (example for Personal Details)
  Widget _buildPersonalDetailsItem(PersonalDetails item, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Given Names',
            item.givenNames ?? '',
            'given_names_${item.personalDetailsId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Surname',
            item.surname ?? '',
            'surname_${item.personalDetailsId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Email',
            item.emailAddress ?? '',
            'email_${item.personalDetailsId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Gender',
            item.gender ?? '',
            'gender_${item.personalDetailsId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Date of Birth',
            item.dateOfBirth ?? '',
            'dob_${item.personalDetailsId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Country of Birth',
            item.countryOfBirth ?? '',
            'country_birth_${item.personalDetailsId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Mobile',
            item.mobileNumber ?? '',
            'mobile_${item.personalDetailsId}',
            isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationQualificationItem(
    EducationQualifications item,
    bool isEditing,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Qualification Name',
            item.qualificationName ?? '',
            'qual_name_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Major Field',
            item.majorField ?? '',
            'major_field_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Institution Name',
            item.institutionName ?? '',
            'institution_name_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Institution Country',
            item.institutionCountry ?? '',
            'institution_country_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Course Start Date',
            item.courseStartDate ?? '',
            'course_start_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Course End Date',
            item.courseEndDate ?? '',
            'course_end_${item.educationId}',
            isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(Educations item, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Level',
            item.level?.toString() ?? '',
            'level_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Country',
            item.country ?? '',
            'country_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Date Started',
            item.dateStarted ?? '',
            'date_started_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Date Finished',
            item.dateFinished ?? '',
            'date_finished_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Number of Years',
            item.numberOfYears?.toString() ?? '',
            'num_years_${item.educationId}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Certificate Details',
            item.certificateDetails ?? '',
            'cert_details_${item.educationId}',
            isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildEmploymentItem(Employments item, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Business Name',
            item.businessName ?? '',
            'business_name_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Position/Job Title',
            item.positionJobTitle ?? '',
            'position_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Name of Employer',
            item.nameofemployer ?? '',
            'employer_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Country',
            item.country ?? '',
            'emp_country_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Employment Start Date',
            item.dateofemploymentstarted ?? '',
            'emp_start_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Employment End Date',
            item.dateofemploymentended ?? '',
            'emp_end_${item.id}',
            isEditing,
          ),
          _buildEditableCheckboxRow(
            'Currently Employed',
            item.isapplicantemployed == true,
            'currently_employed_${item.id}',
            isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(UploadedDocuments item, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Category',
            item.categorys?.documentCategory ?? '',
            'doc_category_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Type',
            item.type?.name ?? '',
            'doc_type_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Description',
            item.description ?? '',
            'doc_description_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'File Name',
            item.uploadfile ?? '',
            'doc_filename_${item.id}',
            isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildVisaItem(UserVisas item, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Visa Name',
            item.visa?.visaName ?? '',
            'visa_name_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Category',
            item.visa?.category ?? '',
            'visa_category_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Assessment Type',
            item.visa?.assessmentType?.toString() ?? '',
            'assessment_type_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Created At',
            item.createdAt ?? '',
            'visa_created_${item.id}',
            isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildOccupationItem(UserOccupations item, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Occupation Name',
            item.occupation?.occupationName ?? '',
            'occupation_name_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'ANZSCO Code',
            item.occupation?.anzscoCode ?? '',
            'anzsco_code_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Skills Requirement',
            item.occupation?.skillsRequirement ?? '',
            'skills_req_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Created At',
            item.createdAt ?? '',
            'occupation_created_${item.id}',
            isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildLicenceItem(Licences item, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Issuing Body',
            item.nameofIssuingBody ?? '',
            'issuing_body_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Type of Licence',
            item.typeOfLicence ?? '',
            'licence_type_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Registration Number',
            item.registrationNumber ?? '',
            'reg_number_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Date of Expiry',
            item.dateOfExpiry ?? '',
            'expiry_date_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Current Status',
            item.currentStatus ?? '',
            'current_status_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Country',
            item.country?.country ?? '',
            'licence_country_${item.id}',
            isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityProcessItem(PriorityProcess item, bool isEditing) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditableInfoRow(
            'Standard Application',
            item.standardApplication ?? '',
            'standard_app_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Priority Processing',
            item.priorityProcessing ?? '',
            'priority_proc_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Other Description',
            item.otherDescription ?? '',
            'other_desc_${item.id}',
            isEditing,
          ),
          _buildEditableInfoRow(
            'Created At',
            item.createdAt ?? '',
            'priority_created_${item.id}',
            isEditing,
          ),
        ],
      ),
    );
  }

  // 7. New editable info row widget
  Widget _buildEditableInfoRow(
    String label,
    String value,
    String controllerKey,
    bool isEditing,
  ) {
    if (!isEditing && value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          if (isEditing)
            TextFormField(
              controller: _getController(controllerKey, value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF1976D2),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                isDense: true,
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                value.isEmpty ? 'No data' : value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: value.isEmpty ? Colors.grey[500] : Colors.black87,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // 8. Save method example
  Future<void> _savePersonalDetails(PersonalDetails item) async {
    // Get updated values from controllers
    final updatedItem = PersonalDetails(
      personalDetailsId: item.personalDetailsId,
      givenNames:
          _getController('given_names_${item.personalDetailsId}', '').text,
      surname: _getController('surname_${item.personalDetailsId}', '').text,
      emailAddress: _getController('email_${item.personalDetailsId}', '').text,
      gender: _getController('gender_${item.personalDetailsId}', '').text,
      dateOfBirth: _getController('dob_${item.personalDetailsId}', '').text,
      countryOfBirth:
          _getController('country_birth_${item.personalDetailsId}', '').text,
      mobileNumber: _getController('mobile_${item.personalDetailsId}', '').text,
    );

    try {
      final loginid = ref.read(loginProvider).response?.userId;
      final state = ref.read(getAllformsProviders);
      final currentUser = state.users?.firstWhere(
        (user) => user.userId == loginid,
      );

      if (currentUser == null) return;

      // Create updated personal details
      final updatedItem = PersonalDetails(
        personalDetailsId: item.personalDetailsId,
        givenNames:
            _getController('given_names_${item.personalDetailsId}', '').text,
        surname: _getController('surname_${item.personalDetailsId}', '').text,
        emailAddress:
            _getController('email_${item.personalDetailsId}', '').text,
        gender: _getController('gender_${item.personalDetailsId}', '').text,
        dateOfBirth: _getController('dob_${item.personalDetailsId}', '').text,
        countryOfBirth:
            _getController('country_birth_${item.personalDetailsId}', '').text,
        mobileNumber:
            _getController('mobile_${item.personalDetailsId}', '').text,
      );

      // Create a copy of current user with updated details
      final updatedUser = currentUser.copyWith(personalDetails: [updatedItem]);

      // Build request body
      final requestBody = _buildUpdateRequestBody(updatedUser);

      // Call provider update method
      await ref
          .read(getAllformsProviders.notifier)
          .updateUserForms(requestBody);
      // Make API call to save the updated data
      // final response = await yourApiService.updatePersonalDetails(updatedItem);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Personal details updated successfully'),
          backgroundColor: Colors.green,
        ),
      );

      // Refresh the data
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating personal details: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveEducationQualification(EducationQualifications item) async {
    final updatedItem = EducationQualifications(
      educationId: item.educationId,
      qualificationName:
          _getController('qual_name_${item.educationId}', '').text,
      majorField: _getController('major_field_${item.educationId}', '').text,
      institutionName:
          _getController('institution_name_${item.educationId}', '').text,
      institutionCountry:
          _getController('institution_country_${item.educationId}', '').text,
      courseStartDate:
          _getController('course_start_${item.educationId}', '').text,
      courseEndDate: _getController('course_end_${item.educationId}', '').text,
    );

    try {
      // API call here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Education qualification updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating education qualification: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveEducation(Educations item) async {
    final updatedItem = Educations(
      educationId: item.educationId,
      level: int.tryParse(_getController('level_${item.educationId}', '').text),
      country: _getController('country_${item.educationId}', '').text,
      dateStarted: _getController('date_started_${item.educationId}', '').text,
      dateFinished:
          _getController('date_finished_${item.educationId}', '').text,
      numberOfYears: int.tryParse(
        _getController('num_years_${item.educationId}', '').text,
      ),
      certificateDetails:
          _getController('cert_details_${item.educationId}', '').text,
    );

    try {
      // API call here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Education updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating education: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveEmployment(Employments item) async {
    final updatedItem = Employments(
      id: item.id,
      businessName: _getController('business_name_${item.id}', '').text,
      positionJobTitle: _getController('position_${item.id}', '').text,
      nameofemployer: _getController('employer_${item.id}', '').text,
      country: _getController('emp_country_${item.id}', '').text,
      dateofemploymentstarted: _getController('emp_start_${item.id}', '').text,
      dateofemploymentended: _getController('emp_end_${item.id}', '').text,
      isapplicantemployed: _getCheckboxValue(
        'currently_employed_${item.id}',
        false,
      ),
    );

    try {
      // API call here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Employment updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating employment: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveDocument(UploadedDocuments item) async {
    try {
      // Note: File upload might need special handling
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating document: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveVisa(UserVisas item) async {
    try {
      // API call here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Visa updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating visa: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveOccupation(UserOccupations item) async {
    try {
      // API call here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Occupation updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating occupation: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveLicence(Licences item) async {
    final updatedItem = Licences(
      id: item.id,
      nameofIssuingBody: _getController('issuing_body_${item.id}', '').text,
      typeOfLicence: _getController('licence_type_${item.id}', '').text,
      registrationNumber: _getController('reg_number_${item.id}', '').text,
      dateOfExpiry: _getController('expiry_date_${item.id}', '').text,
      currentStatus: _getController('current_status_${item.id}', '').text,
      // country: Note - might need special handling for nested objects
    );

    try {
      // API call here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Licence updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating licence: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _savePriorityProcess(PriorityProcess item) async {
    final updatedItem = PriorityProcess(
      id: item.id,
      standardApplication: _getController('standard_app_${item.id}', '').text,
      priorityProcessing: _getController('priority_proc_${item.id}', '').text,
      otherDescription: _getController('other_desc_${item.id}', '').text,
      createdAt: _getController('priority_created_${item.id}', '').text,
    );

    try {
      // API call here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Priority process updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchformsCategories();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating priority process: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildEditableCheckboxRow(
    String label,
    bool value,
    String key,
    bool isEditing,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          if (isEditing)
            Checkbox(
              value: _getCheckboxValue(key, value),
              onChanged: (newValue) {
                setState(() {
                  _setCheckboxValue(key, newValue ?? false);
                });
              },
              activeColor: const Color(0xFF1976D2),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: value ? Colors.green[50] : Colors.grey[50],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: value ? Colors.green[200]! : Colors.grey[200]!,
                ),
              ),
              child: Text(
                value ? 'Yes' : 'No',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: value ? Colors.green[700] : Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
