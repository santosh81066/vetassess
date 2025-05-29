import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UserDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const UserDetailsScreen({super.key, required this.user});
  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String? selectedCertificatePath;
  String? selectedCertificateName;

  @override
  Widget build(BuildContext context) {
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
                    _buildInfoRow(
                      'Application ID',
                      widget.user['applicationId'],
                    ),
                    _buildInfoRow('Email', widget.user['email']),
                    _buildInfoRow(
                      'Submission Date',
                      widget.user['submissionDate'],
                    ),
                    _buildInfoRow('Experience', widget.user['experience']),
                  ]),
                  const SizedBox(height: 16),
                  _buildInfoCard('Qualification', [
                    _buildInfoRow(
                      'Primary Qualification',
                      widget.user['qualification'],
                    ),
                    _buildInfoRow('Occupation', widget.user['occupation']),
                  ]),
                  const SizedBox(height: 16),
                  _buildDocumentsCard(),
                  const SizedBox(height: 16),
                  _buildProgressCard(),
                  const SizedBox(height: 24),
                  if (widget.user['status'].toLowerCase() ==
                      'under review') ...[
                    _buildCertificateUploadCard(),
                    const SizedBox(height: 16),
                  ],
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
              widget.user['name'][0].toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF1B6B93),
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.user['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.user['occupation'],
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _getStatusColor(widget.user['status']),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.user['status'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
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
        onPressed:
            () => _showDialog(
              'Download Application',
              'Are you sure you want to download the complete application package?',
              'Download',
              const Color(0xFFFF8C42),
              () =>
                  _showSnackBar('Download started...', const Color(0xFF4CAF50)),
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
    if (widget.user['status'].toLowerCase() == 'under review') {
      return isDesktop
          ? Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed:
                      selectedCertificatePath != null
                          ? _showApproveDialog
                          : null,
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text(
                    'Approve Application',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedCertificatePath != null
                            ? const Color(0xFF4CAF50)
                            : Colors.grey[400],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _showRejectDialog,
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
                ),
              ),
            ],
          )
          : Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      selectedCertificatePath != null
                          ? _showApproveDialog
                          : null,
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text(
                    'Approve Application',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        selectedCertificatePath != null
                            ? const Color(0xFF4CAF50)
                            : Colors.grey[400],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _showRejectDialog,
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
                ),
              ),
            ],
          );
    }
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.message, color: Color(0xFF2E8B8B)),
        label: const Text(
          'Send Message',
          style: TextStyle(color: Color(0xFF2E8B8B)),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF2E8B8B)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildCertificateUploadCard() {
    return _buildCard(
      'Upload Assessment Certificate',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload the skills assessment certificate to approve this application.',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          if (selectedCertificateName != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.file_present,
                    color: Color(0xFF4CAF50),
                    size: 20,
                  ),
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
                    onPressed:
                        () => setState(() {
                          selectedCertificatePath = null;
                          selectedCertificateName = null;
                        }),
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
                selectedCertificateName != null
                    ? 'Change Certificate'
                    : 'Select Certificate File',
                style: const TextStyle(color: Color(0xFF2E8B8B)),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2E8B8B)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickCertificateFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
      );
      if (result?.files.single.path != null) {
        setState(() {
          selectedCertificatePath = result!.files.single.path;
          selectedCertificateName = result.files.single.name;
        });
      }
    } catch (e) {
      _showSnackBar('Error selecting file. Please try again.', Colors.red);
    }
  }

  void _showApproveDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Text(
              'Approve Application',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure you want to approve ${widget.user['name']}\'s application?',
                ),
                if (selectedCertificateName != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.file_present,
                          size: 16,
                          color: Color(0xFF4CAF50),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedCertificateName!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _updateStatus(
                    'Approved',
                    '${widget.user['name']}\'s application has been approved!',
                    const Color(0xFF4CAF50),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                ),
                child: const Text(
                  'Approve',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _showRejectDialog() {
    _showDialog(
      'Reject Application',
      'Are you sure you want to reject ${widget.user['name']}\'s application?',
      'Reject',
      const Color(0xFFE57373),
      () => _updateStatus(
        'Rejected',
        '${widget.user['name']}\'s application has been rejected.',
        const Color(0xFFE57373),
      ),
    );
  }

  void _showDialog(
    String title,
    String content,
    String actionText,
    Color color,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(backgroundColor: color),
                child: Text(
                  actionText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _updateStatus(String status, String message, Color color) {
    setState(() => widget.user['status'] = status);
    _showSnackBar(message, color, showUndo: true);
  }

  void _showSnackBar(String message, Color color, {bool showUndo = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        action:
            showUndo
                ? SnackBarAction(
                  label: 'Undo',
                  textColor: Colors.white,
                  onPressed:
                      () => setState(
                        () => widget.user['status'] = 'Under Review',
                      ),
                )
                : null,
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
      child:
          isDesktop
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

  Widget _buildDocumentsCard() {
    return _buildCard(
      'Submitted Documents',
      Column(
        children:
            widget.user['documents']
                .map<Widget>((doc) => _buildDocumentItem(doc))
                .toList(),
      ),
    );
  }

  Widget _buildDocumentItem(String documentName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.description, color: Color(0xFF2E8B8B), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              documentName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Icon(Icons.verified, color: Colors.green[600], size: 18),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return _buildCard(
      'Assessment Progress',
      Column(
        children: [
          _buildProgressStep('Application Submitted', true, true),
          _buildProgressStep('Document Verification', true, false),
          _buildProgressStep(
            'Skills Assessment',
            widget.user['status'] == 'Approved',
            false,
          ),
          _buildProgressStep(
            'Final Review',
            widget.user['status'] == 'Approved',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStep(String title, bool isCompleted, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color:
                  isCompleted
                      ? const Color(0xFF4CAF50)
                      : isActive
                      ? const Color(0xFFFF8C42)
                      : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : Icons.circle,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:
                  isCompleted || isActive ? Colors.black87 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
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
}
