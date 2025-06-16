import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:vetassess/providers/get_allforms_providers.dart';
import 'package:vetassess/providers/login_provider.dart';
import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../providers/update_forms.dart';

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

  @override
  Widget build(BuildContext context) {
    final loginid = ref.read(loginProvider).response?.userId;
    final data = ref.read(getAllformsProviders).users;
    final filteredData =
        data?.where((item) => item.userId == loginid).toList() ?? [];

    return LoginPageLayout(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Color(0xFF00565B),
            child: Center(
              child: Text(
                "Review & Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            child:
                isLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF00565B),
                        ),
                      ),
                    )
                    : filteredData.isEmpty
                    ? _buildEmptyState()
                    : _buildFormsList(filteredData),
          ),
        ],
      ),
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

  Widget _buildSectionsList(Users user) {
    return Column(
      children: [
        if (user.personalDetails?.isNotEmpty == true)
          _buildSection(
            'Personal Details',
            Icons.person,
            user.personalDetails!.length,
            Colors.grey.shade600,
            () => _showPersonalDetailsDialog(user.personalDetails!),
          ),
        if (user.educationQualifications?.isNotEmpty == true)
          _buildSection(
            'Education Qualifications',
            Icons.school,
            user.educationQualifications!.length,
            Colors.grey.shade600,
            () => _showEducationQualificationsDialog(
              user.educationQualifications!,
            ),
          ),
        if (user.educations?.isNotEmpty == true)
          _buildSection(
            'Educations',
            Icons.cast_for_education,
            user.educations!.length,
            Colors.grey.shade600,
            () => _showEducationsDialog(user.educations!),
          ),
        if (user.employments?.isNotEmpty == true)
          _buildSection(
            'Employments',
            Icons.work,
            user.employments!.length,
            Colors.grey.shade600,
            () => _showEmploymentsDialog(user.employments!),
          ),
        if (user.uploadedDocuments?.isNotEmpty == true)
          _buildSection(
            'Uploaded Documents',
            Icons.file_upload,
            user.uploadedDocuments!.length,
            Colors.grey.shade600,
            () => _showDocumentsDialog(user.uploadedDocuments!),
          ),
        if (user.userVisas?.isNotEmpty == true)
          _buildSection(
            'Visas',
            Icons.flight_takeoff,
            user.userVisas!.length,
            Colors.grey.shade600,
            () => _showVisasDialog(user.userVisas!),
          ),

        if (user.userOccupations?.isNotEmpty == true)
          _buildSection(
            'Occupations',
            Icons.business_center,
            user.userOccupations!.length,
            Colors.grey.shade600,
            () => _showOccupationsDialog(user.userOccupations!),
          ),
        if (user.licences?.isNotEmpty == true)
          _buildSection(
            'Licences',
            Icons.verified,
            user.licences!.length,
            Colors.grey.shade600,
            () => _showLicencesDialog(user.licences!),
          ),
        if (user.priorityProcess?.isNotEmpty == true)
          _buildSection(
            'Priority Process',
            Icons.priority_high,
            user.priorityProcess!.length,
            Colors.grey.shade600,
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
                        color: Color(0xFF00565B),
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

  Future<void> _savePersonalDetails(PersonalDetails item) async {
    // Get updated values from controllers
    final updatedItem = PersonalDetails(
      personalDetailsId: item.personalDetailsId,
      status: item.status,
      preferredTitle: item.preferredTitle,
      surname:
          _getController(
            'surname_${item.personalDetailsId}',
            item.surname ?? '',
          ).text,
      givenNames:
          _getController(
            'given_names_${item.personalDetailsId}',
            item.givenNames ?? '',
          ).text,
      gender:
          _getController(
            'gender_${item.personalDetailsId}',
            item.gender ?? '',
          ).text,
      previousSurname: item.previousSurname,
      previousGivenNames: item.previousGivenNames,
      dateOfBirth:
          _getController(
            'dob_${item.personalDetailsId}',
            item.dateOfBirth ?? '',
          ).text,
      countryOfBirth:
          _getController(
            'country_birth_${item.personalDetailsId}',
            item.countryOfBirth ?? '',
          ).text,
      countryOfCurrentResidency: item.countryOfCurrentResidency,
      citizenshipCountry: item.citizenshipCountry,
      currentPassportNumber: item.currentPassportNumber,
      datePassportIssued: item.datePassportIssued,
      otherCitizenshipCountry: item.otherCitizenshipCountry,
      otherPassportNumber: item.otherPassportNumber,
      otherDatePassportIssued: item.otherDatePassportIssued,
      emailAddress:
          _getController(
            'email_${item.personalDetailsId}',
            item.emailAddress ?? '',
          ).text,
      daytimeTelephoneNumber: item.daytimeTelephoneNumber,
      faxNumber: item.faxNumber,
      mobileNumber:
          _getController(
            'mobile_${item.personalDetailsId}',
            item.mobileNumber ?? '',
          ).text,
      postalStreetAddress: item.postalStreetAddress,
      postalStreetAddressLine2: item.postalStreetAddressLine2,
      postalStreetAddressLine3: item.postalStreetAddressLine3,
      postalStreetAddressLine4: item.postalStreetAddressLine4,
      postalSuburbCity: item.postalSuburbCity,
      postalState: item.postalState,
      postalPostCode: item.postalPostCode,
      postalCountry: item.postalCountry,
      homeStreetAddress: item.homeStreetAddress,
      homeStreetAddressLine2: item.homeStreetAddressLine2,
      homeStreetAddressLine3: item.homeStreetAddressLine3,
      homeStreetAddressLine4: item.homeStreetAddressLine4,
      homeSuburbCity: item.homeSuburbCity,
      homeState: item.homeState,
      homePostCode: item.homePostCode,
      homeCountry: item.homeCountry,
      isAgentAuthorized: item.isAgentAuthorized,
      agentSurname: item.agentSurname,
      agentGivenNames: item.agentGivenNames,
      agentCompanyName: item.agentCompanyName,
      agentMaraNumber: item.agentMaraNumber,
      agentEmailAddress: item.agentEmailAddress,
      agentDaytimeTelephoneNumber: item.agentDaytimeTelephoneNumber,
      agentFaxNumber: item.agentFaxNumber,
      agentMobileNumber: item.agentMobileNumber,
      agentStreetAddress: item.agentStreetAddress,
      agentStreetAddressLine2: item.agentStreetAddressLine2,
      agentStreetAddressLine3: item.agentStreetAddressLine3,
      agentStreetAddressLine4: item.agentStreetAddressLine4,
      agentSuburbCity: item.agentSuburbCity,
      agentState: item.agentState,
      agentPostCode: item.agentPostCode,
      agentCountry: item.agentCountry,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updatePersonalDetails(
        userId: userId,
        authToken: authToken,
        personalDetails: updatedItem,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Personal details updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        // Refresh the data
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update personal details');
      }
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
      studentRegistrationNumber: item.studentRegistrationNumber,
      qualificationName:
          _getController(
            'qual_name_${item.educationId}',
            item.qualificationName ?? '',
          ).text,
      majorField:
          _getController(
            'major_field_${item.educationId}',
            item.majorField ?? '',
          ).text,
      awardingBodyName: item.awardingBodyName,
      awardingBodyCountry: item.awardingBodyCountry,
      campusAttended: item.campusAttended,
      institutionName:
          _getController(
            'institution_name_${item.educationId}',
            item.institutionName ?? '',
          ).text,
      streetAddress1: item.streetAddress1,
      streetAddress2: item.streetAddress2,
      suburbCity: item.suburbCity,
      state: item.state,
      postCode: item.postCode,
      institutionCountry:
          _getController(
            'institution_country_${item.educationId}',
            item.institutionCountry ?? '',
          ).text,
      normalEntryRequirement: item.normalEntryRequirement,
      entryBasis: item.entryBasis,
      courseLengthYearsOrSemesters: item.courseLengthYearsOrSemesters,
      semesterLengthWeeksOrMonths: item.semesterLengthWeeksOrMonths,
      courseStartDate:
          _getController(
            'course_start_${item.educationId}',
            item.courseStartDate ?? '',
          ).text,
      courseEndDate:
          _getController(
            'course_end_${item.educationId}',
            item.courseEndDate ?? '',
          ).text,
      qualificationAwardedDate: item.qualificationAwardedDate,
      studyMode: item.studyMode,
      hoursPerWeek: item.hoursPerWeek,
      internshipWeeks: item.internshipWeeks,
      thesisWeeks: item.thesisWeeks,
      majorProjectWeeks: item.majorProjectWeeks,
      activityDetails: item.activityDetails,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updateEducationQualifications(
        userId: userId,
        authToken: authToken,
        educationQualifications: [updatedItem],
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Education qualification updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update education qualification');
      }
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
      level: int.tryParse(
        _getController(
          'level_${item.educationId}',
          item.level?.toString() ?? '',
        ).text,
      ),
      dateStarted:
          _getController(
            'date_started_${item.educationId}',
            item.dateStarted ?? '',
          ).text,
      dateFinished:
          _getController(
            'date_finished_${item.educationId}',
            item.dateFinished ?? '',
          ).text,
      numberOfYears: int.tryParse(
        _getController(
          'num_years_${item.educationId}',
          item.numberOfYears?.toString() ?? '',
        ).text,
      ),
      country:
          _getController(
            'country_${item.educationId}',
            item.country ?? '',
          ).text,
      yearCompleted: item.yearCompleted,
      certificateDetails:
          _getController(
            'cert_details_${item.educationId}',
            item.certificateDetails ?? '',
          ).text,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updateEducations(
        userId: userId,
        authToken: authToken,
        educations: [updatedItem],
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Education updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update education');
      }
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
      businessName:
          _getController(
            'business_name_${item.id}',
            item.businessName ?? '',
          ).text,
      alternateBusinsessname: item.alternateBusinsessname,
      streetaddress: item.streetaddress,
      suburbCity: item.suburbCity,
      state: item.state,
      postCode: item.postCode,
      country:
          _getController('emp_country_${item.id}', item.country ?? '').text,
      nameofemployer:
          _getController('employer_${item.id}', item.nameofemployer ?? '').text,
      datytimePHno: item.datytimePHno,
      faxnumber: item.faxnumber,
      mobileNo: item.mobileNo,
      emailaddress: item.emailaddress,
      webaddress: item.webaddress,
      positionJobTitle:
          _getController(
            'position_${item.id}',
            item.positionJobTitle ?? '',
          ).text,
      dateofemploymentstarted:
          _getController(
            'emp_start_${item.id}',
            item.dateofemploymentstarted ?? '',
          ).text,
      isapplicantemployed: _getCheckboxValue(
        'currently_employed_${item.id}',
        item.isapplicantemployed ?? false,
      ),
      dateofemploymentended:
          _getController(
            'emp_end_${item.id}',
            item.dateofemploymentended ?? '',
          ).text,
      totallengthofUnpaidLeave: item.totallengthofUnpaidLeave,
      normalrequiredWorkinghours: item.normalrequiredWorkinghours,
      task1: item.task1,
      task2: item.task2,
      task3: item.task3,
      task4: item.task4,
      task5: item.task5,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updateEmployments(
        userId: userId,
        authToken: authToken,
        employments: [updatedItem],
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employment updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update employment');
      }
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
    final updatedItem = UploadedDocuments(
      id: item.id,
      docCategoryid: item.docCategoryid,
      docTypeid: item.docTypeid,
      description:
          _getController(
            'doc_description_${item.id}',
            item.description ?? '',
          ).text,
      uploadfile: item.uploadfile, // File uploads need special handling
      categorys: item.categorys,
      type: item.type,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updateDocuments(
        userId: userId,
        authToken: authToken,
        documents: [updatedItem],
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update document');
      }
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
    final updatedItem = UserVisas(
      id: item.id,
      visaId: item.visaId,
      userId: item.userId,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
      visa: item.visa,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updateVisas(
        userId: userId,
        authToken: authToken,
        visas: [updatedItem],
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Visa updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update visa');
      }
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
    final updatedItem = UserOccupations(
      id: item.id,
      occupationId: item.occupationId,
      userId: item.userId,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
      occupation: item.occupation,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updateOccupations(
        userId: userId,
        authToken: authToken,
        occupations: [updatedItem],
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Occupation updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update occupation');
      }
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
      categoryId: item.categoryId,
      countryId: item.countryId,
      nameofIssuingBody:
          _getController(
            'issuing_body_${item.id}',
            item.nameofIssuingBody ?? '',
          ).text,
      typeOfLicence:
          _getController(
            'licence_type_${item.id}',
            item.typeOfLicence ?? '',
          ).text,
      registrationNumber:
          _getController(
            'reg_number_${item.id}',
            item.registrationNumber ?? '',
          ).text,
      dateOfExpiry:
          _getController(
            'expiry_date_${item.id}',
            item.dateOfExpiry ?? '',
          ).text,
      currentStatus:
          _getController(
            'current_status_${item.id}',
            item.currentStatus ?? '',
          ).text,
      currentStatusDetail: item.currentStatusDetail,
      country: item.country,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updateLicences(
        userId: userId,
        authToken: authToken,
        licences: [updatedItem],
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Licence updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update licence');
      }
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
      standardApplication:
          _getController(
            'standard_app_${item.id}',
            item.standardApplication ?? '',
          ).text,
      priorityProcessing:
          _getController(
            'priority_proc_${item.id}',
            item.priorityProcessing ?? '',
          ).text,
      otherDescription:
          _getController(
            'other_desc_${item.id}',
            item.otherDescription ?? '',
          ).text,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );

    try {
      final loginResponse = ref.read(loginProvider).response;
      final userId = loginResponse?.userId ?? 0;
      final authToken = loginResponse?.accessToken ?? '';

      final success = await FormsApiService.updatePriorityProcess(
        userId: userId,
        authToken: authToken,
        priorityProcess: updatedItem,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Priority process updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        await _fetchformsCategories();
      } else {
        throw Exception('Failed to update priority process');
      }
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
