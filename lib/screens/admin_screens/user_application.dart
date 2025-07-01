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

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
     final allFormsModel = ref.watch(getAllformsProviders);
     final userList = allFormsModel.users ?? [];
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 100 : 16,
                vertical: 16,
              ),
              child: Column(
                children: [
                  _buildInfoCard('Basic Information', [
                    _buildInfoRow('Full Name', widget.user.givenNames ?? 'N/A'),
                    _buildInfoRow('Email', widget.user.email ?? 'N/A'),
                    _buildInfoRow('Date of Birth', widget.user.dateOfBirth ?? 'N/A'),
                  ]),
                  const SizedBox(height: 16),
                  _buildInfoCard('Qualification', [
                    _buildInfoRow(
                      'Institution:',
                      (widget.user.educationQualifications?.isNotEmpty ?? false)
                          ? widget.user.educationQualifications!.first.institutionName ?? 'N/A'
                          : 'N/A',
                    ),
                     _buildInfoRow(
                      ' Qualification:',
                      (widget.user.educationQualifications?.isNotEmpty ?? false)
                          ? widget.user.educationQualifications!.first.qualificationName ?? 'N/A'
                          : 'N/A',
                    ),
                     _buildInfoRow(
                      ' Date of joining:',
                      (widget.user.educationQualifications?.isNotEmpty ?? false)
                          ? widget.user.educationQualifications!.first.courseStartDate ?? 'N/A'
                          : 'N/A',
                    ),
                      _buildInfoRow(
                      ' Date of Complete Course:',
                      (widget.user.educationQualifications?.isNotEmpty ?? false)
                          ? widget.user.educationQualifications!.first.courseStartDate ?? 'N/A'
                          : 'N/A',
                    ),
                  ]),
                   const SizedBox(height: 16),
                  _buildInfoCard('Employment', [
                    _buildInfoRow(
                      'Business Name:',
                      (widget.user.employments?.isNotEmpty ?? false)
                          ? widget.user.employments!.first.businessName ?? 'N/A'
                          : 'N/A',
                    ),
                     _buildInfoRow(
                      ' State:',
                      (widget.user.employments?.isNotEmpty ?? false)
                          ? widget.user.employments!.first.state ?? 'N/A'
                          : 'N/A',
                    ),
                     _buildInfoRow(
                      ' Country:',
                      (widget.user.employments?.isNotEmpty ?? false)
                          ? widget.user.employments!.first.country ?? 'N/A'
                          : 'N/A',
                    ),
                      _buildInfoRow(
                      ' Mobile:',
                      (widget.user.employments?.isNotEmpty ?? false)
                          ? widget.user.employments!.first.mobileNo?.toString() ?? 'N/A'
                          : 'N/A',
                    ),
                  ]),
                  const SizedBox(height: 16),
                                 
                    _buildCertificateUploadSection(),
                    const SizedBox(height: 16),
                  
                  _buildDownloadButton(),
                  const SizedBox(height: 16),
                  _buildActionButtons(isDesktop),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF00565B),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40,
            child: Text(
              (widget.user.givenNames ?? 'U').substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF1B6B93),
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.user.givenNames ?? 'N/A',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            (widget.user.educationQualifications?.isNotEmpty ?? false)
                ? widget.user.educationQualifications!.first.qualificationName ?? ''
                : 'N/A',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
         
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) => _buildCard(
        title,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      );

  Widget _buildCard(String title, Widget content) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B6B93),
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildDownloadButton() {
    return SizedBox(
      width: double.infinity,
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
              widget.user, // ← pass the user object here               
              );
            },
          ),

        icon: const Icon(Icons.download, color: Colors.white),
        label: const Text(
          'Download Application',
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
    );
  }

Widget _buildActionButtons(bool isDesktop) {
  Future<void> handleApplicationAction(String status) async {
    final success = await ref.read(getAllformsProviders.notifier).updateApplicationStatus(
      userId: widget.user.userId!,
      status: status,
    );

    if (success) {
      _showSnackBar(
        'Application ${status == 'approved' ? 'approved' : 'rejected'} successfully.',
        status == 'approved' ? Colors.green : Colors.red,
      );
      setState(() {
        widget.user.applicationStatus = status;
      });
    } else {
      _showSnackBar(
        'Failed to ${status == 'approved' ? 'approve' : 'reject'} application.',
        Colors.red,
      );
    }
  }

  Widget approveButton = ElevatedButton.icon(
    onPressed: () {
      _showDialog(
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
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF4CAF50),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  Widget rejectButton = OutlinedButton.icon(
    onPressed: () {
      _showDialog(
        'Reject Application',
        'Are you sure you want to reject this application?',
        'Reject',
        const Color(0xFFE57373),
        () => handleApplicationAction('rejected'),
      );
    },
    icon: const Icon(Icons.cancel, color: Color(0xFFE57373)),
    label: const Text(
      'Reject',
      style: TextStyle(
        color: Color(0xFFE57373),
        fontWeight: FontWeight.w600,
      ),
    ),
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Color(0xFFE57373)),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  return isDesktop
      ? Row(
          children: [
            Expanded(child: approveButton),
            const SizedBox(width: 12),
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

 Widget _buildCertificateUploadSection() {
  return _buildCard(
    'Upload Certificate',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedCertificateName != null) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.file_present, color: Color(0xFF4CAF50), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedCertificateName!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedCertificatePath = null;
                      selectedCertificateName = null;
                    });
                  },
                  icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _pickCertificateFile,
            icon: const Icon(Icons.upload_file, color: Color(0xFF2E8B8B)),
            label: Text(
              selectedCertificateName != null ? 'Change Certificate' : 'Pick Certificate File',
              style: const TextStyle(color: Color(0xFF2E8B8B)),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF2E8B8B)),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<void> _pickCertificateFile() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
      withData: true, // Important for web
    );

    if (result != null && result.files.single.bytes != null) {
      final name = result.files.single.name;
      final bytes = result.files.single.bytes!;

      setState(() {
        selectedCertificateName = name;
        selectedCertificatePath = null; // no path in web
      });

      // ✅ Call the Riverpod provider method
      await ref.read(getAllformsProviders.notifier).uploadCertificateFile(
        userId: widget.user.userId.toString(),
        fileName: name,
        fileBytes: bytes,
      );

      _showSnackBar('Certificate uploaded successfully!', Colors.green);
    }
  } catch (e) {
    print('Error: $e');
    _showSnackBar('Error uploading certificate. Try again.', Colors.red);
  }
}

void _showSnackBar(String message, Color color, {bool showUndo = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
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
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(dialogContext),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
            ),
            onPressed: () {
             Navigator.pop(context); // Close the dialog first
              onConfirm(); // Then safely call confirm logic
            },
            child: Text(confirmText),
          ),
        ],
      );
    },
  );
}

}
