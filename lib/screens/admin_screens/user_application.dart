import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vetassess/models/get_forms_model.dart';
import 'package:vetassess/providers/get_allforms_providers.dart';
import 'package:vetassess/screens/admin_screens/admin_download_appl_record.dart';
import 'package:vetassess/widgets/application_record.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  final Users user;
  const UserDetailsScreen({super.key, required this.user});
  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  String? selectedCertificatePath;
  String? selectedCertificateName;
  Uint8List? selectedCertificateBytes;
  bool isUploadingCertificate = false;

  // Check if application is finalized (approved or rejected)
  bool get isApplicationFinalized {
    final status = widget.user.applicationStatus?.toLowerCase();
    return status == 'approved' || status == 'rejected';
  }

  // Check if there's a pending file to upload
  bool get hasPendingFile {
    return selectedCertificateName != null && selectedCertificateBytes != null;
  }

  // Add these methods to your _UserDetailsScreenState class

  void _showConfirmationDialog(
      String title,
      String content,
      String confirmText,
      Color confirmColor,
      VoidCallback onConfirm,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold)
          ),
          content: Text(
              content,
              style: const TextStyle(height: 1.4)
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                onConfirm();
              },
              child: Text(
                  confirmText,
                  style: const TextStyle(color: Colors.white)
              ),
            ),
          ],
        );
      },
    );
  }

  void _showRejectionDialog(Function(String) onReject) {
    final TextEditingController reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Reject Application',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Are you sure you want to reject this application?',
                style: TextStyle(height: 1.4),
              ),
              const SizedBox(height: 16),
              const Text(
                'Rejection Reason:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  hintText: 'Enter reason for rejection...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                reasonController.dispose();
                Navigator.pop(dialogContext);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE57373),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final reason = reasonController.text.trim();
                if (reason.isEmpty) {
                  // Show validation error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a rejection reason'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }

                reasonController.dispose();
                Navigator.pop(dialogContext);
                onReject(reason);
              },
              child: const Text(
                'Reject',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildEnhancedHeader(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 16,
                vertical: 24,
              ),
              child: Column(
                children: [
                  // Enhanced status banner
                  if (isApplicationFinalized) _buildEnhancedStatusBanner(),

                  // Main content grid
                  if (isDesktop)
                    _buildDesktopLayout()
                  else
                    _buildMobileLayout(),

                  const SizedBox(height: 32),

                  // Action section
                  _buildActionSection(isDesktop),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        // Row 1: Basic Info + Quick Stats
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildEnhancedBasicInfo()),
            const SizedBox(width: 24),
            Expanded(flex: 1, child: _buildQuickStats()),
          ],
        ),
        const SizedBox(height: 24),

        // Row 2: Qualification + Employment
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildEnhancedQualification()),
            const SizedBox(width: 24),
            Expanded(child: _buildEnhancedEmployment()),
          ],
        ),
        const SizedBox(height: 24),

        // Row 3: Certificate Upload (full width)
        _buildEnhancedCertificateSection(),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildQuickStats(),
        const SizedBox(height: 24),
        _buildEnhancedBasicInfo(),
        const SizedBox(height: 24),
        _buildEnhancedQualification(),
        const SizedBox(height: 24),
        _buildEnhancedEmployment(),
        const SizedBox(height: 24),
        _buildEnhancedCertificateSection(),
      ],
    );
  }

  Widget _buildEnhancedHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F4C75),
            Color(0xFF3282B8),
            Color(0xFF0F4C75),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPatternPainter(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                // User avatar with status indicator
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: Text(
                          (widget.user.givenNames ?? 'U').substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ),

                    // Status indicator
                    if (widget.user.applicationStatus != null)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _getStatusColor(widget.user.applicationStatus!),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            _getStatusIcon(widget.user.applicationStatus!),
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // User name with enhanced typography
                Text(
                  widget.user.givenNames ?? 'Unknown User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // Qualification with icon
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.school, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        (widget.user.educationQualifications?.isNotEmpty ?? false)
                            ? widget.user.educationQualifications!.first.qualificationName ?? 'No Qualification'
                            : 'No Qualification',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.95),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedStatusBanner() {
    final status = widget.user.applicationStatus?.toLowerCase();
    final isApproved = status == 'approved';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isApproved
              ? [Colors.green.withOpacity(0.1), Colors.green.withOpacity(0.05)]
              : [Colors.red.withOpacity(0.1), Colors.red.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isApproved ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (isApproved ? Colors.green : Colors.red).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isApproved ? Colors.green : Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: (isApproved ? Colors.green : Colors.red).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                isApproved ? Icons.check_circle : Icons.cancel,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Application ${isApproved ? 'Approved' : 'Rejected'}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isApproved ? Colors.green[700] : Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'This application has been ${isApproved ? 'approved' : 'rejected'} and can no longer be modified.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    final hasEducation = widget.user.educationQualifications?.isNotEmpty ?? false;
    final hasEmployment = widget.user.employments?.isNotEmpty ?? false;
    final status = widget.user.applicationStatus ?? 'Pending';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics_outlined, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              const Text(
                'Quick Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildStatItem('Application Status', status, _getStatusColor(status), _getStatusIcon(status)),
          _buildStatItem('Education Records', hasEducation ? '1 Record' : 'Not Provided',
              hasEducation ? Colors.green : Colors.orange,
              hasEducation ? Icons.check_circle : Icons.warning),
          _buildStatItem('Employment Records', hasEmployment ? '1 Record' : 'Not Provided',
              hasEmployment ? Colors.green : Colors.orange,
              hasEmployment ? Icons.check_circle : Icons.warning),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedBasicInfo() {
    return _buildEnhancedCard(
      'Personal Information',
      Icons.person_outline,
      Colors.blue,
      [
        _buildEnhancedInfoRow('Full Name', widget.user.givenNames ?? 'N/A', Icons.person),
        _buildEnhancedInfoRow('Email Address', widget.user.email ?? 'N/A', Icons.email_outlined),
        _buildEnhancedInfoRow('Date of Birth', widget.user.dateOfBirth ?? 'N/A', Icons.cake_outlined),
      ],
    );
  }

  Widget _buildEnhancedQualification() {
    final hasQualification = widget.user.educationQualifications?.isNotEmpty ?? false;
    final qualification = hasQualification ? widget.user.educationQualifications!.first : null;

    return _buildEnhancedCard(
      'Education & Qualification',
      Icons.school_outlined,
      Colors.purple,
      [
        _buildEnhancedInfoRow(
            'Institution',
            qualification?.institutionName ?? 'Not provided',
            Icons.business_outlined
        ),
        _buildEnhancedInfoRow(
            'Qualification',
            qualification?.qualificationName ?? 'Not provided',
            Icons.workspace_premium_outlined
        ),
        _buildEnhancedInfoRow(
            'Start Date',
            qualification?.courseStartDate ?? 'Not provided',
            Icons.play_arrow_outlined
        ),
        _buildEnhancedInfoRow(
            'Completion Date',
            qualification?.courseStartDate ?? 'Not provided',
            Icons.flag_outlined
        ),
      ],
    );
  }

  Widget _buildEnhancedEmployment() {
    final hasEmployment = widget.user.employments?.isNotEmpty ?? false;
    final employment = hasEmployment ? widget.user.employments!.first : null;

    return _buildEnhancedCard(
      'Employment Details',
      Icons.work_outline,
      Colors.green,
      [
        _buildEnhancedInfoRow(
            'Business Name',
            employment?.businessName ?? 'Not provided',
            Icons.business_center_outlined
        ),
        _buildEnhancedInfoRow(
            'State',
            employment?.state ?? 'Not provided',
            Icons.location_on_outlined
        ),
        _buildEnhancedInfoRow(
            'Country',
            employment?.country ?? 'Not provided',
            Icons.public_outlined
        ),
        _buildEnhancedInfoRow(
            'Mobile Number',
            employment?.mobileNo?.toString() ?? 'Not provided',
            Icons.phone_outlined
        ),
      ],
    );
  }

  Widget _buildEnhancedCard(String title, IconData titleIcon, Color accentColor, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced header with gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accentColor.withOpacity(0.1), accentColor.withOpacity(0.05)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(titleIcon, color: accentColor, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: Colors.grey[600], size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedCertificateSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.withOpacity(0.1), Colors.orange.withOpacity(0.05)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.file_upload_outlined, color: Colors.orange[700], size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Certificate Upload',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show selected file with enhanced design
                if (selectedCertificateName != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: hasPendingFile
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: hasPendingFile
                            ? Colors.orange.withOpacity(0.3)
                            : Colors.green.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: hasPendingFile ? Colors.orange : Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            hasPendingFile ? Icons.schedule : Icons.check_circle,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedCertificateName!,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: hasPendingFile ? Colors.orange[700] : Colors.green[700],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                hasPendingFile ? 'Ready to upload' : 'Successfully uploaded',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              selectedCertificatePath = null;
                              selectedCertificateName = null;
                              selectedCertificateBytes = null;
                            });
                          },
                          icon: Icon(Icons.close, color: Colors.grey[600], size: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // File picker button with enhanced design
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _pickCertificateFile,
                    icon: const Icon(Icons.attach_file),
                    label: Text(
                      selectedCertificateName != null ? 'Change Certificate' : 'Select Certificate File',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0F4C75),
                      side: const BorderSide(color: Color(0xFF0F4C75), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

                // Send button with enhanced design
                if (hasPendingFile) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: isUploadingCertificate ? null : _uploadCertificateFile,
                      icon: isUploadingCertificate
                          ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : const Icon(Icons.send, color: Colors.white),
                      label: Text(
                        isUploadingCertificate ? 'Uploading...' : 'Upload Certificate',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(bool isDesktop) {
    return Column(
      children: [
        // Download button
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton.icon(
            onPressed: () => _showDialog(
              'Download Application',
              'Are you sure you want to download the complete application package?',
              'Download',
              const Color(0xFFFF8C42),
                  () async {
                _showSnackBar('Download started...', const Color(0xFF4CAF50));
                await PdfDownloadService.downloadApplicationRecordPdf(
                  context,
                  ref,
                  widget.user,
                );
              },
            ),
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text(
              'Download Application Package',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C42),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        ),

        // Action buttons
        _buildActionButtons(isDesktop),
      ],
    );
  }

  Widget _buildActionButtons(bool isDesktop) {
    Future<void> handleApplicationAction(String status, {String? rejectionReason}) async {
      final success = await ref.read(getAllformsProviders.notifier).updateApplicationStatus(
        userId: widget.user.userId!,
        status: status,
        rejectionReason: rejectionReason, // Pass rejection reason if provided
      );

      if (success) {
        _showSnackBar(
          'Application ${status == 'approved' ? 'approved' : 'rejected'} successfully.',
          status == 'approved' ? Colors.green : Colors.red,
        );
        setState(() {
          widget.user.applicationStatus = status;
          // Also update the rejection reason if provided
          if (rejectionReason != null) {
            widget.user.rejectionReason = rejectionReason;
          }
        });
      } else {
        _showSnackBar(
          'Failed to ${status == 'approved' ? 'approve' : 'reject'} application.',
          Colors.red,
        );
      }
    }

    // Hide buttons completely for finalized applications
    if (isApplicationFinalized) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.lock_outline, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'This application has been finalized and cannot be modified',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget approveButton = ElevatedButton.icon(
      onPressed: () {
        _showConfirmationDialog(
          'Approve Application',
          'Are you sure you want to approve this application?',
          'Approve',
          const Color(0xFF4CAF50),
              () => handleApplicationAction('approved'),
        );
      },
      icon: const Icon(Icons.check_circle, color: Colors.white),
      label: const Text(
        'Approve Application',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4CAF50),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );

    Widget rejectButton = ElevatedButton.icon(
      onPressed: () {
        _showRejectionDialog((reason) => handleApplicationAction('rejected', rejectionReason: reason));
      },
      icon: const Icon(Icons.cancel, color: Colors.white),
      label: const Text(
        'Reject Application',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE57373),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
    );

    return isDesktop
        ? Row(
      children: [
        Expanded(child: approveButton),
        const SizedBox(width: 16),
        Expanded(child: rejectButton),
      ],
    )
        : Column(
      children: [
        SizedBox(width: double.infinity, child: approveButton),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: rejectButton),
      ],
    );
  }

  // Modified to only select file, not upload immediately
  Future<void> _pickCertificateFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        final name = result.files.single.name;
        final bytes = result.files.single.bytes!;

        setState(() {
          selectedCertificateName = name;
          selectedCertificateBytes = bytes;
          selectedCertificatePath = null;
        });

        _showSnackBar('Certificate selected. Click "Upload Certificate" to proceed.', const Color(0xFFFF8C42));
      }
    } catch (e) {
      print('Error selecting file: $e');
      _showSnackBar('Error selecting certificate. Please try again.', Colors.red);
    }
  }

  // New method for actual upload
  Future<void> _uploadCertificateFile() async {
    if (selectedCertificateName == null || selectedCertificateBytes == null) {
      _showSnackBar('No file selected to upload.', Colors.red);
      return;
    }

    setState(() {
      isUploadingCertificate = true;
    });

    try {
      await ref.read(getAllformsProviders.notifier).uploadCertificateFile(
        userId: widget.user.userId.toString(),
        fileName: selectedCertificateName!,
        fileBytes: selectedCertificateBytes!,
      );

      setState(() {
        selectedCertificateBytes = null;
        isUploadingCertificate = false;
      });

      _showSnackBar('Certificate uploaded successfully!', const Color(0xFF4CAF50));
    } catch (e) {
      setState(() {
        isUploadingCertificate = false;
      });
      print('Error uploading certificate: $e');
      _showSnackBar('Error uploading certificate. Please try again.', Colors.red);
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF4CAF50);
      case 'under review':
        return const Color(0xFFFF8C42);
      case 'rejected':
        return const Color(0xFFE57373);
      default:
        return const Color(0xFF2E8B8B);
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'under review':
        return Icons.hourglass_bottom;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.pending;
    }
  }

  void _showSnackBar(String message, Color color, {bool showUndo = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: showUndo
            ? SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              widget.user.businessName = 'Under Review';
            });
          },
        )
            : null,
      ),
    );
  }

  void _showDialog(
      String title,
      String content,
      String confirmText,
      Color confirmColor,
      VoidCallback onConfirm,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(content, style: const TextStyle(height: 1.4)),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: confirmColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(confirmText, style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

// Custom painter for background pattern
class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;
    for (double i = 0; i < size.width + spacing; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i - spacing, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}