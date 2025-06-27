import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/widgets/application_record.dart';
import 'package:vetassess/widgets/login_page_layout.dart';
import '../../providers/get_allforms_providers.dart';
import '../../providers/login_provider.dart';
import '../../widgets/application_nav.dart';

class DocumentUploadScreen extends ConsumerStatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  ConsumerState<DocumentUploadScreen> createState() =>
      _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends ConsumerState<DocumentUploadScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final isMediumScreen = size.width >= 600 && size.width < 1024;
    final isLargeScreen = size.width >= 1024;

    final loginid = ref.read(loginProvider).response?.userId;
    final data = ref.read(getAllformsProviders).users;
    final filteredData =
        data?.where((item) => item.userId == loginid).toList() ?? [];

    // Extract the applicant's name from the filtered data
    String applicantName = ''; // Default fallback
    if (filteredData.isNotEmpty && filteredData.first.givenNames != null) {
      applicantName = filteredData.first.givenNames!;
      // Optionally include surname as well
      if (filteredData.first.surname != null) {
        applicantName =
            '${filteredData.first.givenNames!} ${filteredData.first.surname!}';
      }
    }

    // Responsive dimensions
    final navWidth = isSmallScreen ? size.width * 0.2 : size.width * 0.3;
    final contentMargin = EdgeInsets.only(
      top: size.height * 0.02,
      left: isSmallScreen ? 8 : 16,
      bottom: size.height * 0.1,
      right: isSmallScreen ? 20 : (isMediumScreen ? 60 : 125),
    );
    final buttonWidth =
        isSmallScreen
            ? size.width * 0.9
            : (isMediumScreen ? size.width * 0.6 : size.width * 0.35);

    return LoginPageLayout(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: navWidth,
            child: const Align(
              alignment: Alignment.topRight,
              child: ApplicationNavWithProgress(
                  currentRoute: '/doc_upload',
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
          Expanded(
            child: Container(
              margin: contentMargin,
              padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  SizedBox(height: size.height * 0.025),
                  _buildReferenceCard(applicantName), // Pass the applicant name
                  SizedBox(height: size.height * 0.02),
                  _buildRequiredDocumentsCard(),
                  SizedBox(height: size.height * 0.02),
                  _buildContactInfo(),
                  SizedBox(height: size.height * 0.02),
                  _buildTranslationNote(),
                  SizedBox(height: size.height * 0.02),
                  _buildUploadButton(),
                  SizedBox(height: size.height * 0.025),
                  _buildEligibilitySection(),
                  SizedBox(height: size.height * 0.025),
                  _buildUploadedDocumentsSection(isSmallScreen),
                  SizedBox(height: size.height * 0.04),
                  _buildPreviewButton(),
                  SizedBox(height: size.height * 0.025),
                  _buildActionButtons(buttonWidth, isSmallScreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() => const Text(
    'Documents Upload',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Color(0xFF444444),
    ),
  );

  Widget _buildReferenceCard(String applicantName) => _buildCard(
    color: Colors.white,
    border: Colors.grey.shade300,
    child: IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Reference number:', ''),
          _buildInfoRow(
            'Applicant\'s name:',
            applicantName,
          ), // Use dynamic name
          _buildInfoRow(
            'Application Record:',
            'Click to download',
            isLink: true,
            onTap: () async {
              await PdfGenerationService.generateApplicationRecordPdf(
                context,
                ref,
              );
            },
          ),
        ],
      ),
    ),
  );

  Widget _buildRequiredDocumentsCard() => _buildCard(
    color: const Color(0xFFD9EDF7),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Before you can submit your application, please upload the following required documents and try again. Please make sure the correct document type is selected when uploading your documents.',
          style: TextStyle(color: Color(0xFF31708F)),
        ),
        const SizedBox(height: 10),
        ...requiredDocuments.map((doc) => _buildBulletPoint(doc)),
        const SizedBox(height: 10),
        _buildRichText([
          'Your application must include three forms of identification. For more information, click ',
          ('here', Colors.orange, true),
          '.',
        ], const Color(0xFF31708F)),
      ],
    ),
  );

  Widget _buildContactInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'If you require any additional information or further assistance with uploading your documents, please contact us at ',
        style: TextStyle(color: Color(0xFF444444)),
      ),
      const Text(
        'migrate@vetassess.com.au',
        style: TextStyle(
          color: Colors.orange,
          decoration: TextDecoration.underline,
        ),
      ),
    ],
  );

  Widget _buildTranslationNote() => _buildCard(
    color: const Color(0xFFFFF9E6),
    border: const Color(0xFFFFEBC8),
    child: const Text(
      'All documents must be high quality colour scans of the original document/s. If your documents are not issued in the English language, you must submit scans of both the original language documents as well as the English translations made by a Registered Translation services.',
      style: TextStyle(color: Color(0xFF8A6D3B)),
    ),
  );

  Widget _buildUploadButton() => SizedBox(
    height: 40,
    child: ElevatedButton(
      onPressed: () {
        context.go('/vetassess_upload');
      },
      style: _buttonStyle(),
      child: const Text('Upload'),
    ),
  );

  Widget _buildEligibilitySection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildRichText([
        'For a list of all required documents, refer to ',
        ('Eligibility Criteria', Colors.orange, true),
        '. You may consider ',
        ('Skills Assessment Support (SAS) services', Colors.orange, true),
        ' to get additional support for submitting an assessment-ready application.',
      ]),
      const SizedBox(height: 8),
      _buildRichText(
        [
          'Download and print the ',
          ('Applicant Declaration', Colors.orange, true),
        ],
        const Color(0xFF444444),
        FontWeight.bold,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              [
                'Sign by hand the \'Declaration\' section (mandatory)',
                'Sign by hand the \'Agent/Representative Signature\' section by the agent/ representative (if applicable)',
                'Upload the signed copy of the Applicant Declaration under Identification Documents',
              ].map(_buildCircleBulletText).toList(),
        ),
      ),
    ],
  );

  Widget _buildUploadedDocumentsSection(bool isSmallScreen) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Uploaded Documents',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xFF444444),
        ),
      ),
      const SizedBox(height: 16),
      ...[
        ('Identification Documents', Icons.person, null),
        ('Qualification Documents', Icons.school, 'Intermediate - TSBIE'),
        (
          'Employment Documents',
          Icons.work,
          'Flutter Developer - Go Code Designers',
        ),
        ('Licence Documents', Icons.card_membership, '1234567899 - Primary'),
        ('Fees and Payment Documents', Icons.receipt, null),
      ].map(
        (data) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _buildDocumentSection(data.$1, data.$2, subtitle: data.$3),
        ),
      ),
    ],
  );

  Widget _buildPreviewButton() => Center(
    child: SizedBox(
      height: 40,
      width: 250,
      child: ElevatedButton(
        onPressed: () {},
        style: _buttonStyle(),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.download, size: 18),
            SizedBox(width: 8),
            Text('Application preview'),
          ],
        ),
      ),
    ),
  );

  Widget _buildActionButtons(double buttonWidth, bool isSmallScreen) => Center(
    child: SizedBox(
      width: buttonWidth,
      child: Flex(
        direction: isSmallScreen ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            ['Back', 'Save & Exit', 'Continue']
                .asMap()
                .entries
                .map((entry) {
                  final isLast = entry.key == 2;
                  return [
                    ElevatedButton(
                      onPressed:
                          isLast
                              ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const DocumentUploadScreen(),
                                ),
                              )
                              : () {},
                      style: _buttonStyle(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 20,
                          vertical: isSmallScreen ? 8 : 10,
                        ),
                      ),
                      child: Text(entry.value),
                    ),
                    if (!isLast)
                      SizedBox(
                        width: isSmallScreen ? 0 : 15,
                        height: isSmallScreen ? 10 : 0,
                      ),
                  ];
                })
                .expand((x) => x)
                .toList(),
      ),
    ),
  );

  // Helper methods
  Widget _buildCard({required Widget child, Color? color, Color? border}) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: border != null ? Border.all(color: border) : null,
        ),
        padding: const EdgeInsets.all(16),
        child:
            color == Colors.white
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [child],
                )
                : child,
      );

  // Updated _buildInfoRow method with onTap functionality
  Widget _buildInfoRow(
    String label,
    String value, {
    bool isLink = false,
    VoidCallback? onTap,
  }) => Padding(
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
        isLink && onTap != null
            ? GestureDetector(
              onTap: onTap,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  value,
                  style: TextStyle(
                    color: isLink ? Colors.orange : const Color(0xFF444444),
                    decoration: isLink ? TextDecoration.underline : null,
                  ),
                ),
              ),
            )
            : Text(
              value,
              style: TextStyle(
                color: isLink ? Colors.orange : const Color(0xFF444444),
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
      ],
    ),
  );

  Widget _buildBulletPoint(String text) => Padding(
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

  Widget _buildCircleBulletText(String text) => Padding(
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

  Widget _buildRichText(
    List<dynamic> parts, [
    Color baseColor = const Color(0xFF444444),
    FontWeight? fontWeight,
  ]) => RichText(
    text: TextSpan(
      style: TextStyle(color: baseColor, fontWeight: fontWeight),
      children:
          parts.map((part) {
            if (part is String) {
              return TextSpan(text: part);
            } else if (part is (String, Color, bool)) {
              return TextSpan(
                text: part.$1,
                style: TextStyle(
                  color: part.$2,
                  decoration: part.$3 ? TextDecoration.underline : null,
                ),
              );
            }
            return const TextSpan();
          }).toList(),
    ),
  );

  Widget _buildDocumentSection(
    String title,
    IconData icon, {
    String? subtitle,
  }) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
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
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey.shade200,
                child: Text(
                  '0',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
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

  ButtonStyle _buttonStyle({EdgeInsets? padding}) => ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF008080),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    padding: padding,
  );
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
  'Employment [Flutter Developer - Go Code Designers] – Statement of services',
  'Employment [Flutter Developer - Go Code Designers] – Payment Evidence',
  'Licence / Professional Membership [1234567899 - Primary]',
];
