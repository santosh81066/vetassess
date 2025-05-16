import 'package:flutter/material.dart';
import 'package:vetassess/theme.dart';
import '../widgets/BasePageLayout.dart';

class FeeScreen extends StatelessWidget {
  const FeeScreen({super.key});

  static const Color tealColor = Color(0xFF00565B);
  static const Color dottedLineColor = Color(0xFF008996);

  @override
  Widget build(BuildContext context) {
    // Check if screen is small for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final screenHeight = MediaQuery.of(context).size.height;

    return BasePageLayout(
      child: Container(
        color: AppColors.color12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //hero
            _buildHeaderBanner(screenHeight, screenWidth),
            _buildBreadcrumbs(),
            ..._buildProcessSteps(screenWidth, screenHeight),
            // Generate all fee sections
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Full Skills Assessment Fees'),

                  // Full Skills Assessment table
                  _buildStandardTable(
                    context,
                    headerText:
                        'For both qualifications and employment - Australian or Overseas',
                    rows: [
                      TableRowInfo(
                        label: 'Online application',
                        australiaPrice: 'AUD \$1177.00',
                        overseasPrice: 'AUD \$1070.00',
                      ),
                      TableRowInfo(
                        label: '**Priority Processing Fee',
                        australiaPrice: 'AUD \$886.60',
                        overseasPrice: 'AUD \$806.00',
                        isLastRow: true,
                      ),
                    ],
                  ),

                  // Standard footnote for tax office
                  _buildTaxOfficeFootnote(context),

                  _buildFootnoteText(
                    context,
                    '**This fee is in addition to the Full Skills Assessment fee.',
                  ),

                  const SizedBox(height: 90),

                  // Points Test Advice section
                  _buildSectionTitle(
                    context,
                    'Points Test Advice only (for applicants with non VETASSESS Occupations)',
                  ),

                  // Click here link
                  _buildClickHereLink(context),

                  // Points Test Advice table
                  _buildStandardTable(
                    context,
                    headerText: 'Qualifications Online application',
                    rows: [
                      TableRowInfo(
                        label: 'Qualifications online application',
                        australiaPrice: 'AUD \$334.40',
                        overseasPrice: 'AUD \$304.00',
                        isLastRow: true,
                      ),
                    ],
                  ),

                  _buildTaxOfficeFootnote(context),

                  const SizedBox(height: 90),

                  // Post-Vocational Education Work Visa section
                  _buildSectionTitle(
                    context,
                    'Post-Vocational Education Work Visa (Subclass 485) visas',
                  ),

                  _buildStandardTable(
                    context,
                    headerText: 'Application Type',
                    rows: [
                      TableRowInfo(
                        label:
                            'Post-Vocational Education Work Visa (Subclass 485) visas',
                        australiaPrice: 'AUD \$446.60',
                        overseasPrice: 'AUD \$406.00',
                      ),
                      TableRowInfo(
                        label:
                            'Review – Post-Vocational Education Work Visa (Subclass 485) visas',
                        australiaPrice: 'AUD \$284.90',
                        overseasPrice: 'AUD \$259.00',
                      ),
                      TableRowInfo(
                        label:
                            'Change of Occupation – Post-Vocational Education Work Visa (Subclass 485) visas',
                        australiaPrice: 'AUD \$407.00',
                        overseasPrice: 'AUD \$370.00',
                        isLastRow: true,
                      ),
                    ],
                  ),

                  _buildTaxOfficeFootnote(context),

                  const SizedBox(height: 90),

                  // Post-485 section
                  _buildSectionTitle(
                    context,
                    'Post - 485 assessment under the same occupation',
                  ),

                  _buildStandardTable(
                    context,
                    headerText: 'Application Method',
                    rows: [
                      TableRowInfo(
                        label:
                            'Assessment of employment for final Skills Assessment',
                        australiaPrice: 'AUD \$915.20',
                        overseasPrice: 'AUD \$832.00',
                        isLastRow: true,
                      ),
                    ],
                  ),

                  _buildTaxOfficeFootnote(context),

                  const SizedBox(height: 40),

                  // Post-485 Different Occupation subsection
                  Text(
                    'Post - 485 assessment under a different occupation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF0d5257),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 8),

                  _buildFootnoteText(
                    context,
                    'If you are applying for a Post 485 assessment and wish to change your nominated occupation, you will need to lodge a new application online.',
                  ),

                  const SizedBox(height: 90),

                  // Review of assessment outcome section
                  _buildSectionTitle(context, 'Review of assessment outcome'),

                  // Review table has a complex structure, so keep it separate
                  _buildReviewTable(context, isSmallScreen),

                  _buildTaxOfficeFootnote(context),

                  _buildFootnoteText(
                    context,
                    '**You should hold sufficient years of highly relevant employment within last five years to compensate for the lack of a highly relevant major field of study.',
                  ),

                  _buildFootnoteText(
                    context,
                    'Review applications lodged outside of the 90-day timeframe will incur full skills assessment fees.',
                  ),

                  const SizedBox(height: 90),

                  // Reassessment section
                  _buildSectionTitle(
                    context,
                    'Reassessment - Change of Occupation (within 90-day timeframe)',
                  ),

                  _buildStandardTable(
                    context,
                    headerText: 'Application type',
                    rows: [
                      TableRowInfo(
                        label:
                            'Full skills assessment for change of occupation',
                        australiaPrice: 'AUD \$800.80',
                        overseasPrice: 'AUD \$728.00',
                        isLastRow: true,
                      ),
                    ],
                  ),

                  _buildFootnoteText(
                    context,
                    'Applicants may lodge a new skills assessment application outside the 90-day timeframe.',
                  ),

                  _buildTaxOfficeFootnote(context),

                  const SizedBox(height: 90),

                  // Reissue of Outcome Letter section
                  _buildSectionTitle(context, 'Reissue of Outcome Letter'),

                  _buildStandardTable(
                    context,
                    headerText: 'Purpose',
                    rows: [
                      TableRowInfo(
                        label: 'Reissue Outcome Letter',
                        australiaPrice: 'AUD \$80.30',
                        overseasPrice: 'AUD \$73.00',
                        isLastRow: true,
                      ),
                    ],
                  ),

                  _buildTaxOfficeFootnote(context),

                  const SizedBox(height: 90),

                  // Appeal section
                  _buildSectionTitle(context, 'Appeal'),

                  _buildStandardTable(
                    context,
                    headerText: 'Application method - Appeal',
                    rows: [
                      TableRowInfo(
                        label: 'Appeal of Negative Assessment Outcome',
                        australiaPrice: 'AUD \$1162.70',
                        overseasPrice: 'AUD \$1057.00',
                        isLastRow: true,
                      ),
                    ],
                  ),

                  _buildTaxOfficeFootnote(context),

                  const SizedBox(height: 90),

                  // Renewal section
                  _buildSectionTitle(
                    context,
                    'Renewal of Skills Assessment Application Fee',
                  ),

                  _buildStandardTable(
                    context,
                    headerText: 'Renewal of Skills Assessment',
                    rows: [
                      TableRowInfo(
                        label: 'Within 3 years',
                        australiaPrice: 'AUD \$508.20',
                        overseasPrice: 'AUD \$462.00',
                      ),
                      TableRowInfo(
                        label: 'Outside of 3 years',
                        australiaPrice: 'AUD \$1177.00',
                        overseasPrice: 'AUD \$1070.00',
                        isLastRow: true,
                      ),
                    ],
                  ),

                  _buildFootnoteText(
                    context,
                    'Renewal applications lodged outside of the 3-year timeframe will incur a full skills assessment fee, please lodge a new application',
                  ),

                  _buildTaxOfficeFootnote(context),

                  const SizedBox(height: 50),

                  _buildDivider(),

                  _buildStandardSection(context, 'Other Information', [
                    const Text(
                      'Withdrawal, Closure and Reopening of an Application ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    const Text(
                      'Withdrawal: ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(
                            text:
                                'If you request to withdraw an application before the assessment commences, a full refund will be considered, less an administration fee of AUD\$167. Please see our',
                          ),
                          TextSpan(
                            text: 'Refund Policy ',
                            style: const TextStyle(
                              color: Color(0xFF0d5257),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: 'for further details.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    const Text(
                      'Closure: ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(
                            text:
                                'You are expected to provide complete documentation at the time you submit your application.. Please find the list of documents under',
                          ),
                          TextSpan(
                            text: ' Required Documents. ',
                            style: const TextStyle(
                              color: Color(0xFF0d5257),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text:
                                ' If any information or documents are missing from the application, we will provide 15 calendar days to submit them. If the outstanding documents are not submitted within the given timeframe, a final notice will be issued giving seven additional days before the application is closed without further communication. Please note that refunds don'
                                't apply to closed applications',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Reopening:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'You may request to reopen an application after providing all required documents and information within 90 days of closure. A fee of \$167.00 will apply. Requests received after 90 days will not be accepted and you will need to lodge a new application and pay the full assessment fee.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                    ),
                    const SizedBox(height: 30),

                    const SizedBox(height: 20),
                    const Text(
                      'Making a payment',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    const Text(
                      'We have two payment options available. Payments must be:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                    ),
                    const SizedBox(height: 20),
                    _buildBulletPoints('Made payable to VETASSESS'),
                    const SizedBox(height: 10),
                    _buildBulletPoints('In Australian dollars '),
                    const SizedBox(height: 10),
                    _buildBulletPoints(
                      'Paid and cleared 7 days prior to your assessment',
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'You will be able to complete payment using any one of the following methods:',
                      style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                    ),
                    const SizedBox(height: 10),
                    _buildBulletPoints('MasterCard'),
                    const SizedBox(height: 10),
                    _buildBulletPoints('VISA'),
                    const SizedBox(height: 30),
                    const Text(
                      'Refunds',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0d5257),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(
                            text:
                                'You can find further information about our refund policy',
                          ),
                          TextSpan(
                            text: 'here',
                            style: const TextStyle(
                              color: Color(0xFF0d5257),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: 90),
                ],
              ),
            ),
            _buildFaqSection(
              title: 'Explore FAQs',
              items: [
                'How can VETASSESS be sure it can process my application in 10 business days?',
              ],
              isExpansionPanel: true,
            ),
            _buildApplyBanner(screenWidth, screenHeight),
            _buildPreparingApplSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqSection({
    required String title,
    required List<String> items,
    bool isExpansionPanel = false,
  }) {
    final Color sectionColor = Color(0xFF0A594C);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Title and View all button
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: sectionColor,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: sectionColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: sectionColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Right column - Expansion panels or links
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: 6),
              child: Column(
                children:
                    items.map((item) {
                      if (isExpansionPanel) {
                        return _buildExpansionItem(item, sectionColor);
                      } else {
                        return _buildLinkItem(item, sectionColor);
                      }
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, Color color) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 3),
      ),
      child: Icon(icon, color: color, size: 18, weight: 700),
    );
  }

  Widget _buildExpansionItem(String title, Color color) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        colorScheme: ColorScheme.light(
          surfaceTint: Colors.transparent,
          primary: color,
        ),
      ),
      child: Column(
        children: [
          ExpansionTile(
            tilePadding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.only(left: 50, bottom: 16, right: 20),
            leading: _buildCircleIcon(Icons.add, color),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            trailing: SizedBox.shrink(),
            children: [
              Text(
                'This is the answer to the FAQ question.',
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
            ],
          ),
          _buildDottedLine(),
        ],
      ),
    );
  }

  Widget _buildLinkItem(String title, Color color) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Icon(Icons.arrow_forward, color: color, size: 22),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          child: CustomPaint(
            painter: DottedLinePainter(color: Color(0xFFfd7e14)),
          ),
        ),
      ],
    );
  }

  Widget _buildPreparingApplSection() {
    final List<String> links = [
      'The application process',
      'Acceptable documents you will need',
      'Fees & Charges',
      'Check your occupation',
      'FAQs',
      'Reviews, Reassessments, Appeals,\nReissues & Feedback',
      'Priority Processing & Urgent\nApplications',
      'Points Test Advice',
      'Renewals',
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 150),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Title and description
          Expanded(
            flex: 2,
            child: Container(
              width: 450,
              padding: EdgeInsets.only(top: 40, bottom: 40, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Preparing your application",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A594C),
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'A VETASSESS Skills Assessment involves assessing both your qualifications and your employment experience. Your qualifications will be compared with the Australian Qualifications Framework (AQF) and your employment experience will be assessed to determine whether it is relevant and at an appropriate skill level.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right column - Navigation links with dotted lines
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:
                    links.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final String link = entry.value;
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  link,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF0A594C),
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (index < links.length - 1)
                            _buildDottedLine(color: Color(0xFFfd7e14)),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedLine({Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        height: 1,
        child: CustomPaint(
          painter: DottedLinePainter(color: color ?? dottedLineColor),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, double width) {
    return SizedBox(
      height: 50,
      width: width,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFA000),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        child: Text(text, style: TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _buildApplyBanner(double screenWidth, double screenHeight) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100, top: 50),
        child: Container(
          width: screenWidth * 0.78,
          height: screenHeight * 0.6,
          color: tealColor,
          child: Row(
            children: [
              // Left side with teal background and content
              Container(
                padding: EdgeInsets.only(top: 60, left: 110, bottom: 60),
                width: screenWidth * 0.52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Apply to get your skills assessed",
                      style: TextStyle(
                        color: Color(0xFFFFA000),
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Your application will be processed once payment & required documents are \nreceived. If we require any further documentation in order to proceed with this \napplication you will be notified via email.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Find out how this application is progressing by tracking your application online. ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildActionButton("Apply Online", 150),
                  ],
                ),
              ),
              // Right side with desert landscape image
              Image.asset(
                'assets/images/During_your_application.jpg',
                width: screenWidth * 0.26,
                height: 0.6,
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // HELPER METHODS
  Widget _buildHeaderBanner(double screenHeight, double screenWidth) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.5,
      decoration: const BoxDecoration(color: tealColor),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Image.asset(
              'assets/images/internal_page_banner.png',
              height: screenHeight * 0.5,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            width: screenWidth * 0.66,
            padding: const EdgeInsets.only(top: 100, left: 170),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Skills Assessment fees for \nProfessional Occupations",
                    style: TextStyle(
                      color: Color(0xFFFFA000),
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Professional Fees and Payments",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                      letterSpacing: 0.3,
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

  Widget _buildBreadcrumbs() {
    const TextStyle linkStyle = TextStyle(
      fontSize: 14,
      color: Color(0xFF0d5257),
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 150),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Home', style: linkStyle),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skills Assessment For Migration',
              style: linkStyle,
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skills Assessment for professional occupations',
              style: linkStyle,
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          Text(
            'Professional Fees and Payments',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProcessSteps(double screenWidth, double screenHeight) {
    // Define all step data in a list
    final List<Map<String, dynamic>> stepsData = [
      {
        'step': 'Fees and payments',
        //'title': 'Choose a professional occupation',
        'description':
            'Application fees include GST if you (the applicant) are an Australian resident for tax purposes. Please refer to the Australian Taxation Office website for information regarding tax residency.',
        'anzscoInfo':
            'The SAS services aim to provide additional and tailored support to applicants, agents and lawyers in submitting a sufficiently complete/ ready to assess skills assessment application.',
        'image': 'assets/images/fees_and_payments.jpg',
        'imageOnRight': false,
      },
    ];

    // Generate widgets for each step
    return stepsData.asMap().entries.map((entry) {
      final int index = entry.key;
      final Map<String, dynamic> stepData = entry.value;

      final Widget stepInfoColumn = Container(
        width: screenWidth * 0.3,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stepData['step'],
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            SizedBox(height: 40),
            Text(
              stepData['description'],
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      );

      final Widget imageWidget = Image.asset(
        stepData['image'],
        height: 440,
        width: 580,
        fit: BoxFit.fitHeight,
      );

      final List<Widget> rowChildren =
          stepData['imageOnRight']
              ? [stepInfoColumn, imageWidget]
              : [imageWidget, stepInfoColumn];

      return Container(
        color: Colors.white,
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: screenHeight / 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      );
    }).toList();
  }

  // Build the "Click Here" link for the Points Test Advice section
  Widget _buildClickHereLink(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // Add navigation or link functionality
          },
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'Click Here',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xFF0d5257),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text:
                      ' to apply or find out more about this application process',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Helper method to build standard sections for consistent layout
  Widget _buildStandardSection(
    BuildContext context,
    String title,
    List<Widget> content,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Title
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D5C63),
                  ),
                ),
              ],
            ),
          ),

          // Right column - Content
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create consistent dividers
  Widget _buildDivider() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          height: 1,
          color: const Color(0xFFF9D342), // Yellow color for the line
          width: double.infinity,
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildBulletPoints(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF5A5A5A),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
          ),
        ),
      ],
    );
  }

  // Build standard footnote text
  Widget _buildFootnoteText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  // Build the standard Tax Office footnote that appears throughout the page
  Widget _buildTaxOfficeFootnote(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(text: '*Refer to the '),
            TextSpan(
              text: 'Australian Taxation Office',
              style: TextStyle(
                color: const Color(0xFF0d5257),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: ' website for more information.'),
          ],
        ),
      ),
    );
  }

  // Build a standard table with consistent structure
  Widget _buildStandardTable(
    BuildContext context, {
    required String headerText,
    required List<TableRowInfo> rows,
  }) {
    List<TableRow> tableRows = [
      // Header Row
      TableRow(
        decoration: BoxDecoration(
          color: const Color(0xFF0d5257), // Dark teal header
        ),
        children: [
          _buildTableHeaderCell(headerText),
          _buildTableHeaderCell(
            'Applying from within Australia (includes GST)',
          ),
          _buildTableHeaderCell(
            'Applicant is not a resident of Australia for tax purposes (excludes GST)',
          ),
        ],
      ),
    ];

    // Add data rows
    for (var rowInfo in rows) {
      tableRows.add(
        _buildTableDataRow(
          label: rowInfo.label,
          australiaPrice: rowInfo.australiaPrice,
          overseasPrice: rowInfo.overseasPrice,
          isLastRow: rowInfo.isLastRow,
        ),
      );
    }

    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: tableRows,
    );
  }

  // Helper method to create table header cells
  Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Helper method to create table data rows
  TableRow _buildTableDataRow({
    required String label,
    required String australiaPrice,
    required String overseasPrice,
    bool isLastRow = false,
  }) {
    return TableRow(
      decoration:
          isLastRow
              ? null
              : BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            australiaPrice,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            overseasPrice,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  // Special case: Review table with responsive design
  Widget _buildReviewTable(BuildContext context, bool isSmallScreen) {
    return isSmallScreen
        ? _buildMobileReviewTable(context)
        : _buildDesktopReviewTable(context);
  }

  // Desktop version of the review table
  Widget _buildDesktopReviewTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1), // Occupation Group
          1: FlexColumnWidth(1.2), // Review application type
          2: FlexColumnWidth(1.5), // Qualification outcome
          3: FlexColumnWidth(1.5), // Employment outcome
          4: FlexColumnWidth(1), // Additional Supporting Evidence
          5: FlexColumnWidth(0.8), // Fees (including GST)
          6: FlexColumnWidth(0.8), // Fees (excluding GST)
        },
        border: TableBorder.all(color: Colors.grey.shade300),
        children: [
          // Header Row
          TableRow(
            decoration: BoxDecoration(
              color:const Color(0xFF0d5257), // Dark teal header
            ),
            children: [
              _buildTableHeaderCell('Occupation Group'),
              _buildTableHeaderCell('Review application type'),
              _buildTableHeaderCell(
                'Qualification outcome for initial application',
              ),
              _buildTableHeaderCell(
                'Employment outcome for initial application',
              ),
              _buildTableHeaderCell('Additional Supporting Evidence required'),
              _buildTableHeaderCell('Fees (including GST)*'),
              _buildTableHeaderCell('Fees (excluding GST)*'),
            ],
          ),

          // Group A and E - Qualification only
          TableRow(
            children: [
              _buildMultiRowCell('Group\nA and E', 3, TextAlign.center),
              _buildTableDataCell('Qualification only'),
              _buildTableDataCell(
                'Negative\n(not highly relevant or\nnot at the required level)',
              ),
              _buildTableDataCell('Negative due to qualification'),
              _buildTableDataCell('Qualification'),
              _buildTableDataCell('AUD \$365.20', TextAlign.center),
              _buildTableDataCell('AUD \$332.00', TextAlign.center),
            ],
          ),

          // Group A and E - Employment only
          TableRow(
            children: [
              _buildHiddenCell(), // Hidden because it's part of rowspan
              _buildTableDataCell('Employment only'),
              _buildTableDataCell('Positive'),
              _buildTableDataCell(
                'Negative due to any reason\n(except qualification)',
              ),
              _buildTableDataCell('Employment'),
              _buildTableDataCell('AUD \$654.50', TextAlign.center),
              _buildTableDataCell('AUD \$595.00', TextAlign.center),
            ],
          ),

          // Group A and E - Both
          TableRow(
            children: [
              _buildHiddenCell(), // Hidden because it's part of rowspan
              _buildTableDataCell('Both\nQualification and Employment'),
              _buildTableDataCell(
                'Negative\n(not highly relevant or\nnot at the required level)',
              ),
              _buildTableDataCell(
                'Negative due to any reason\n(including qualification)',
              ),
              _buildTableDataCell('Qualification and Employment'),
              _buildTableDataCell('AUD \$981.20', TextAlign.center),
              _buildTableDataCell('AUD \$892.00', TextAlign.center),
            ],
          ),

          // Group B, C, D and F - First Employment only row
          TableRow(
            children: [
              _buildMultiRowCell('Group\nB, C, D and F', 3, TextAlign.center),
              _buildTableDataCell('Qualification only'),
              _buildTableDataCell(
                'Negative\n(not highly relevant or\nnot at the required level)',
              ),
              _buildTableDataCell('Negative due to qualification'),
              _buildTableDataCell('Qualification'),
              _buildTableDataCell('AUD \$365.20', TextAlign.center),
              _buildTableDataCell('AUD \$332.00', TextAlign.center),
            ],
          ),

          TableRow(
            children: [
              _buildHiddenCell(),
              _buildTableDataCell('Employment only'),
              _buildTableDataCell(
                'Negative\n(not highly relevant and\nyou are not contesting\nthe relevance)',
              ),
              _buildTableDataCell(
                'Negative due to any reason\n(except qualification not at\nthe required level)**',
              ),
              _buildTableDataCell('Employment'),
              _buildTableDataCell('AUD \$654.50', TextAlign.center),
              _buildTableDataCell('AUD \$595.00', TextAlign.center),
            ],
          ),

          // Group B, C, D and F - Second Employment only row
          TableRow(
            children: [
              _buildHiddenCell(), // Hidden because it's part of rowspan
              _buildTableDataCell('Employment only'),
              _buildTableDataCell('Positive'),
              _buildTableDataCell(
                'Negative due to any reason\n(except qualification)',
              ),
              _buildTableDataCell('Employment'),
              _buildTableDataCell('AUD \$654.50', TextAlign.center),
              _buildTableDataCell('AUD \$595.00', TextAlign.center),
            ],
          ),

          // Group B, C, D and F - Both
          TableRow(
            children: [
              _buildHiddenCell(), // Hidden because it's part of rowspan
              _buildTableDataCell('Both\nQualification and Employment'),
              _buildTableDataCell(
                'Negative\n(not highly relevant or\nnot at the required level)',
              ),
              _buildTableDataCell(
                'Negative due to any reason\n(including qualification)',
              ),
              _buildTableDataCell('Qualification and Employment'),
              _buildTableDataCell('AUD \$981.20', TextAlign.center),
              _buildTableDataCell('AUD \$892.00', TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }

  // Mobile version of the review table with better formatting for small screens
  Widget _buildMobileReviewTable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group A and E
        _buildMobileGroupHeader(context, 'Group A and E'),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Qualification only',
          qualOutcome:
              'Negative (not highly relevant or not at the required level)',
          empOutcome: 'Negative due to qualification',
          evidence: 'Qualification',
          feeIncl: 'AUD \$365.20',
          feeExcl: 'AUD \$332.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Employment only',
          qualOutcome: 'Positive',
          empOutcome: 'Negative due to any reason (except qualification)',
          evidence: 'Employment',
          feeIncl: 'AUD \$654.50',
          feeExcl: 'AUD \$595.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Both',
          qualOutcome:
              'Negative (not highly relevant or not at the required level)',
          empOutcome: 'Negative due to any reason (including qualification)',
          evidence: 'Qualification and Employment',
          feeIncl: 'AUD \$981.20',
          feeExcl: 'AUD \$892.00',
          isLastInGroup: true,
        ),

        // Group B, C, D and F
        _buildMobileGroupHeader(context, 'Group B, C, D and F'),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Qualification only',
          qualOutcome:
              'Negative (not highly relevant or not at the required level)',
          empOutcome: 'Negative due to qualification',
          evidence: 'Qualification',
          feeIncl: 'AUD \$365.20',
          feeExcl: 'AUD \$332.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Employment only',
          qualOutcome:
              'Negative (not highly relevant and you are not contesting the relevance)',
          empOutcome:
              'Negative due to any reason (except qualification not at the required level)**',
          evidence: 'Employment',
          feeIncl: 'AUD \$654.50',
          feeExcl: 'AUD \$595.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Employment only',
          qualOutcome: 'Positive',
          empOutcome: 'Negative due to any reason (except qualification)',
          evidence: 'Employment',
          feeIncl: 'AUD \$654.50',
          feeExcl: 'AUD \$595.00',
        ),
        _buildMobileReviewRow(
          context: context,
          reviewType: 'Both Qualification and Employment',
          qualOutcome:
              'Negative (not highly relevant or not at the required level)',
          empOutcome: 'Negative due to any reason (including qualification)',
          evidence: 'Qualification and Employment',
          feeIncl: 'AUD \$981.20',
          feeExcl: 'AUD \$892.00',
          isLastInGroup: true,
        ),
      ],
    );
  }

  // Helper method for mobile review table's group headers
  Widget _buildMobileGroupHeader(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: const Color(0xFFE6F2F5), // Light teal background
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF005F73),
        ),
      ),
    );
  }

  // Helper method for mobile review table's rows
  Widget _buildMobileReviewRow({
    required BuildContext context,
    required String reviewType,
    required String qualOutcome,
    required String empOutcome,
    required String evidence,
    required String feeIncl,
    required String feeExcl,
    bool isLastInGroup = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom:
              isLastInGroup
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMobileInfoRow('Review type:', reviewType),
          _buildMobileInfoRow('Qualification outcome:', qualOutcome),
          _buildMobileInfoRow('Employment outcome:', empOutcome),
          _buildMobileInfoRow('Required evidence:', evidence),
          Row(
            children: [
              Expanded(child: _buildMobileInfoRow('Incl. GST:', feeIncl)),
              Expanded(child: _buildMobileInfoRow('Excl. GST:', feeExcl)),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method for mobile review info rows
  Widget _buildMobileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  // Helper methods for the desktop review table

  // Helper method for multi-row cells (rowspan)
  Widget _buildMultiRowCell(String text, int rowSpan, TextAlign align) {
    return Container(
      height: 60.0 * rowSpan, // Approximate height
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(text, textAlign: align, style: const TextStyle(fontSize: 14)),
    );
  }

  // Helper method for hidden cells (used with rowspan)
  Widget _buildHiddenCell() {
    return const SizedBox.shrink();
  }

  // Helper method for regular table cells
  Widget _buildTableDataCell(String text, [TextAlign align = TextAlign.start]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: const TextStyle(fontSize: 14), textAlign: align),
    );
  }
}

// Helper class to store table row data
class TableRowInfo {
  final String label;
  final String australiaPrice;
  final String overseasPrice;
  final bool isLastRow;

  TableRowInfo({
    required this.label,
    required this.australiaPrice,
    required this.overseasPrice,
    this.isLastRow = false,
  });
}

// Build a standard section title with consistent styling
Widget _buildSectionTitle(BuildContext context, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0d5257),
          fontSize: 30,
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

// Custom painter for dotted line
class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;

    const double dashWidth = 3;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
