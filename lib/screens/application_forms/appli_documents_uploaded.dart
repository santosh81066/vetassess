import 'package:flutter/material.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

import '../../widgets/application_nav.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({Key? key}) : super(key: key);

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final buttonDirection = isSmallScreen ? Axis.vertical : Axis.horizontal;
    final buttonSpacing = isSmallScreen ? 10.0 : 15.0;
    final buttonWidth = isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.35;

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
                top: 16,
                left: 16,
                bottom: 100,
                right: 125,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Documents Upload',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF444444),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Reference Info Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center, // Center the column within the container
                      children: [
                        // Use an IntrinsicWidth to contain the column so it takes only the needed width
                        IntrinsicWidth(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start, // Keep text aligned to the start
                            children: [
                              _buildInfoRow('Reference number:', ''),
                              _buildInfoRow(
                                'Applicant\'s name:',
                                'GCD Designers',
                              ),
                              _buildInfoRow(
                                'Application Record:',
                                'Click to download',
                                isLink: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Required Documents Info Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9EDF7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Before you can submit your application, please upload the following required documents and try again. Please make sure the correct document type is selected when uploading your documents.',
                          style: TextStyle(color: Color(0xFF31708F)),
                        ),
                        const SizedBox(height: 10),
                        ...requiredDocuments.map(
                          (doc) => _buildBulletPoint(doc),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Color(0xFF31708F)),
                            children: [
                              const TextSpan(
                                text:
                                    'Your application must include three forms of identification. For more information, click ',
                              ),
                              TextSpan(
                                text: 'here',
                                style: const TextStyle(
                                  color: Colors.orange,
                                  decoration: TextDecoration.underline,
                                ),
                                // Add onTap if needed
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Contact Info
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Color(0xFF444444)),
                      children: [
                        TextSpan(
                          text:
                              'If you require any additional information or further assistance with uploading your documents, please contact us at ',
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'migrate@vetassess.com.au',
                    style: TextStyle(
                      color: Colors.orange,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Translation Note Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9E6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFFEBC8)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'All documents must be high quality colour scans of the original document/s. If your documents are not issued in the English language, you must submit scans of both the original language documents as well as the English translations made by a Registered Translation Service.',
                      style: TextStyle(color: Color(0xFF8A6D3B)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Upload Button
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF008080),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('Upload'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Required Documents Section with Eligibility Criteria
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Color(0xFF444444)),
                          children: [
                            TextSpan(
                              text:
                                  'For a list of all required documents, refer to ',
                            ),
                            TextSpan(
                              text: 'Eligibility Criteria',
                              style: TextStyle(
                                color: Colors.orange,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(text: '. You may consider '),
                            TextSpan(
                              text: 'Skills Assessment Support (SAS) services',
                              style: TextStyle(
                                color: Colors.orange,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' to get additional support for submitting an assessment-ready application.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(text: 'Download and print the '),
                            TextSpan(
                              text: 'Applicant Declaration',
                              style: TextStyle(
                                color: Colors.orange,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCircleBulletText(
                              'Sign by hand the \'Declaration\' section (mandatory)',
                            ),
                            _buildCircleBulletText(
                              'Sign by hand the \'Agent/Representative Signature\' section by the agent/ representative (if applicable)',
                            ),
                            _buildCircleBulletText(
                              'Upload the signed copy of the Applicant Declaration under Identification Documents',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Uploaded Documents Section
                  const Text(
                    'Uploaded Documents',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF444444),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Document Category Sections
                  _buildDocumentSection(
                    'Identification Documents',
                    Icons.person,
                  ),
                  const SizedBox(height: 10),
                  _buildDocumentSection(
                    'Qualification Documents',
                    Icons.school,
                    subtitle: 'Intermediate - TSBIE',
                  ),
                  const SizedBox(height: 10),
                  _buildDocumentSection(
                    'Employment Documents',
                    Icons.work,
                    subtitle: 'Flutter Developer - Go Code Designers',
                  ),
                  const SizedBox(height: 10),
                  _buildDocumentSection(
                    'Licence Documents',
                    Icons.card_membership,
                    subtitle: '1234567899 - Primary',
                  ),
                  const SizedBox(height: 10),
                  _buildDocumentSection(
                    'Fees and Payment Documents',
                    Icons.receipt,
                  ),
                  const SizedBox(height: 30),
                  // Bottom Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 250,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF008080),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.download, size: 18),
                              SizedBox(width: 8),
                              Text('Application preview'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Final Action Buttons
                  Center(
                    child: SizedBox(
                      width: buttonWidth,
                      child: Flex(
                        direction: buttonDirection,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 12 : 20,
                                vertical: isSmallScreen ? 8 : 10,
                              ),
                            ),
                            child: const Text('Back'),
                          ),
                          SizedBox(
                            width: isSmallScreen ? 0 : buttonSpacing,
                            height: isSmallScreen ? buttonSpacing : 0,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 12 : 20,
                                vertical: isSmallScreen ? 8 : 10,
                              ),
                            ),
                            child: const Text('Save & Exit'),
                          ),
                          SizedBox(
                            width: isSmallScreen ? 0 : buttonSpacing,
                            height: isSmallScreen ? buttonSpacing : 0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DocumentUploadScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 12 : 20,
                                vertical: isSmallScreen ? 8 : 10,
                              ),
                            ),
                            child: const Text('Continue'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
              ),
            ),
          ),
          isLink
              ? Text(
                value,
                style: const TextStyle(
                  color: Colors.orange,
                  decoration: TextDecoration.underline,
                ),
              )
              : Text(value, style: const TextStyle(color: Color(0xFF444444))),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Color(0xFF31708F))),
          Expanded(
            child: Text(text, style: const TextStyle(color: Color(0xFF31708F))),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleBulletText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('○ ', style: TextStyle(color: Color(0xFF444444))),
          Expanded(
            child: Text(text, style: const TextStyle(color: Color(0xFF444444))),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentSection(
    String title,
    IconData icon, {
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(icon, color: Colors.grey.shade600, size: 18),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Subtitle if provided
          if (subtitle != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.remove, size: 18, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          // Empty state
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'No documents have been uploaded',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}

// Required documents list
final List<String> requiredDocuments = [
  'Passport-size Photograph',
  'Passport Bio Page',
  'Birth Certificate',
  'National Identity Card',
  'Driver\'s licence',
  'Other – Secondary ID Documents',
  'Qualification CV',
  'Signed Applicant Declaration',
  'Qualification [Intermediate] – Transcript / Diploma Supplement',
  'Qualification [Intermediate] – Award Certificate',
  'Employment [Flutter Developer - Go Code Designers] – Statement of Service',
  'Employment [Flutter Developer - Go Code Designers] – Payment Evidence',
  'Licence / Professional Membership [1234567899 - Primary]',
];
