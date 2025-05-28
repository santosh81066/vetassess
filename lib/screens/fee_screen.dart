import 'dart:math' as math;

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
            _buildHeaderBanner(context),
            _buildBreadcrumbs(context),
            ..._buildProcessSteps(context),
            // Generate all fee sections
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Full Skills Assessment Fees'),

                  // Full Skills Assessment table
                  _buildResponsiveTable(
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
                  _buildResponsiveTable(
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

                  _buildResponsiveTable(
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

                  _buildResponsiveTable(
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
                  _buildReviewTable(context),

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

                  _buildResponsiveTable(
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

                  _buildResponsiveTable(
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

                  _buildResponsiveTable(
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

                  _buildResponsiveTable(
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
            _buildApplyBanner(),
            _buildPreparingApplSection(context),
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
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final Color sectionColor = Color(0xFF0A594C);
      
      // Responsive breakpoints
      final bool isMobile = screenWidth < 768;
      final bool isTablet = screenWidth >= 768 && screenWidth < 1024;
      final bool isDesktop = screenWidth >= 1024;
      
      // Responsive padding
      double horizontalPadding = isMobile 
          ? 20 
          : isTablet 
              ? 60 
              : 150;
              
      double verticalPadding = isMobile 
          ? 30 
          : isTablet 
              ? 45 
              : 60;
      
      // Responsive font sizes
      double titleFontSize = isMobile 
          ? 24 
          : isTablet 
              ? 28 
              : 32;
              
      double viewAllFontSize = isMobile ? 14 : 16;
      double itemFontSize = isMobile ? 16 : 18;
      double linkFontSize = isMobile ? 14 : 16;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: isMobile 
            ? _buildMobileLayout(
                title: title,
                items: items,
                isExpansionPanel: isExpansionPanel,
                sectionColor: sectionColor,
                titleFontSize: titleFontSize,
                viewAllFontSize: viewAllFontSize,
                itemFontSize: itemFontSize,
                linkFontSize: linkFontSize,
              )
            : _buildDesktopLayout(
                title: title,
                items: items,
                isExpansionPanel: isExpansionPanel,
                sectionColor: sectionColor,
                titleFontSize: titleFontSize,
                viewAllFontSize: viewAllFontSize,
                itemFontSize: itemFontSize,
                linkFontSize: linkFontSize,
              ),
      );
    },
  );
}

Widget _buildDesktopLayout({
  required String title,
  required List<String> items,
  required bool isExpansionPanel,
  required Color sectionColor,
  required double titleFontSize,
  required double viewAllFontSize,
  required double itemFontSize,
  required double linkFontSize,
}) {
  return Row(
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
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: sectionColor,
                height: 1.3,
              ),
            ),
            SizedBox(height: 24),
            _buildViewAllButton(sectionColor, viewAllFontSize),
          ],
        ),
      ),

      // Right column - Expansion panels or links
      Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.only(top: 6),
          child: Column(
            children: items.map((item) {
              if (isExpansionPanel) {
                return _buildExpansionItem(item, sectionColor, itemFontSize);
              } else {
                return _buildLinkItem(item, sectionColor, linkFontSize);
              }
            }).toList(),
          ),
        ),
      ),
    ],
  );
}

Widget _buildMobileLayout({
  required String title,
  required List<String> items,
  required bool isExpansionPanel,
  required Color sectionColor,
  required double titleFontSize,
  required double viewAllFontSize,
  required double itemFontSize,
  required double linkFontSize,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title section
      Text(
        title,
        style: TextStyle(
          fontSize: titleFontSize,
          fontWeight: FontWeight.w700,
          color: sectionColor,
          height: 1.3,
        ),
      ),
      SizedBox(height: 16),
      
      // View all button
      _buildViewAllButton(sectionColor, viewAllFontSize),
      SizedBox(height: 24),
      
      // Items section
      Column(
        children: items.map((item) {
          if (isExpansionPanel) {
            return _buildExpansionItem(item, sectionColor, itemFontSize);
          } else {
            return _buildLinkItem(item, sectionColor, linkFontSize);
          }
        }).toList(),
      ),
    ],
  );
}

Widget _buildViewAllButton(Color sectionColor, double fontSize) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "View all",
        style: TextStyle(
          fontSize: fontSize,
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
  );
}

Widget _buildCircleIcon(IconData icon, Color color, {double? size}) {
  final double iconSize = size ?? 32;
  return Container(
    width: iconSize,
    height: iconSize,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: color, width: 3),
    ),
    child: Icon(
      icon, 
      color: color, 
      size: iconSize * 0.5625, // Maintains proportion
      weight: 700,
    ),
  );
}

Widget _buildExpansionItem(String title, Color color, double fontSize) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final bool isMobile = MediaQuery.of(context).size.width < 768;
      
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
              tilePadding: EdgeInsets.symmetric(
                vertical: isMobile ? 12 : 20,
                horizontal: 0,
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: EdgeInsets.only(
                left: isMobile ? 30 : 50,
                bottom: 16,
                right: isMobile ? 10 : 20,
              ),
              leading: _buildCircleIcon(
                Icons.add,
                color,
                size: isMobile ? 28 : 32,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              trailing: SizedBox.shrink(),
              children: [
                Text(
                  'This is the answer to the FAQ question.',
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            _buildDottedLines(),
          ],
        ),
      );
    },
  );
}

Widget _buildLinkItem(String title, Color color, double fontSize) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final bool isMobile = MediaQuery.of(context).size.width < 768;
      
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 12 : 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: isMobile ? 2 : 1,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  color: color,
                  size: isMobile ? 20 : 22,
                ),
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
    },
  );
}
// Helper methods (add these if not already present)
bool _isMobiles(BuildContext context) {
  return MediaQuery.of(context).size.width < 600;
}

bool _isTablets(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width >= 600 && width < 1024;
}

double _getpreparingResponsiveFontSize(BuildContext context, double baseFontSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  if (screenWidth < 600) {
    // Mobile
    return baseFontSize * 0.8;
  } else if (screenWidth < 1024) {
    // Tablet
    return baseFontSize * 0.9;
  } else {
    // Desktop
    return baseFontSize;
  }
}

EdgeInsets _getpreparingResponsivePadding(BuildContext context, {
  double mobile = 16,
  double tablet = 32,
  double desktop = 50,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  if (screenWidth < 600) {
    return EdgeInsets.all(mobile);
  } else if (screenWidth < 1024) {
    return EdgeInsets.all(tablet);
  } else {
    return EdgeInsets.all(desktop);
  }
}

Widget _buildPreparingApplSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final isMobile = _isMobiles(context);
  final isTablet = _isTablets(context);

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

  // Mobile layout - stack vertically
  if (isMobile) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and description section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Preparing your application",
                  style: TextStyle(
                    fontSize: _getpreparingResponsiveFontSize(context, 28),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0A594C),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'A VETASSESS Skills Assessment involves assessing both your qualifications and your employment experience. Your qualifications will be compared with the Australian Qualifications Framework (AQF) and your employment experience will be assessed to determine whether it is relevant and at an appropriate skill level.',
                  style: TextStyle(
                    fontSize: _getpreparingResponsiveFontSize(context, 15),
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Links section
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: links.asMap().entries.map((entry) {
                final int index = entry.key;
                final String link = entry.value;
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              link,
                              style: TextStyle(
                                fontSize: _getpreparingResponsiveFontSize(context, 16),
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            margin: const EdgeInsets.only(left: 16),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF0A594C),
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index < links.length - 1)
                      _buildDottedLine(context, color: const Color(0xFFfd7e14)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Tablet and Desktop layout - side by side
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.symmetric(
      horizontal: isTablet ? screenWidth * 0.05 : screenWidth * 0.08,
      vertical: 40,
    ),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Title and description
          Flexible(
            flex: isTablet ? 6 : 5,
            child: Container(
              padding: EdgeInsets.only(
                top: 40,
                bottom: 40,
                right: isTablet ? 16 : 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Preparing your application",
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 28),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0A594C),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'A VETASSESS Skills Assessment involves assessing both your qualifications and your employment experience. Your qualifications will be compared with the Australian Qualifications Framework (AQF) and your employment experience will be assessed to determine whether it is relevant and at an appropriate skill level.',
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(context, 15),
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add some spacing between columns
          SizedBox(width: isTablet ? 16 : 24),

          // Right column - Navigation links with dotted lines
          Flexible(
            flex: isTablet ? 4 : 4,
            child: Container(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: links.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String link = entry.value;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                link,
                                style: TextStyle(
                                  fontSize: _getResponsiveFontSize(context, 16),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Container(
                              width: 32,
                              height: 32,
                              margin: const EdgeInsets.only(left: 16),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF0A594C),
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (index < links.length - 1)
                        _buildDottedLine(context, color: const Color(0xFFfd7e14)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDottedLine(BuildContext context, {Color? color}) {
  final isMobile = _isMobiles(context);
  
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
    child: SizedBox(
      width: double.infinity,
      height: 1,
      child: CustomPaint(
        painter: DottedLinePainter(color: color ?? const Color(0xFFCCCCCC)),
      ),
    ),
  );
}

  Widget _buildDottedLines({Color? color}) {
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

 Widget _buildApplyBanner() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 100, top: 50),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 768;
          final isTablet = screenWidth >= 768 && screenWidth < 1024;
          final isDesktop = screenWidth >= 1024;
          
          return Container(
            width: screenWidth * (isMobile ? 0.95 : 0.78),
            constraints: BoxConstraints(
              maxWidth: 1200, // Maximum width for very large screens
              minHeight: isMobile ? 300 : 400,
            ),
            color: tealColor,
            child: isMobile 
                ? _buildMobileLayouts(screenWidth)
                : _buildDesktopLayouts(screenWidth, isTablet),
          );
        },
      ),
    ),
  );
}

Widget _buildMobileLayouts(double screenWidth) {
  return Column(
    children: [
      // Content section
      Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Apply to get your skills assessed",
              style: TextStyle(
                color: const Color(0xFFFFA000),
                fontSize: screenWidth * 0.06, // Responsive font size
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Start the application process and if you have any questions, you can contact our customer support team at any stage.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 24),
            _buildActionButton("Apply Online", double.infinity),
          ],
        ),
      ),
      // Image section
      ClipRRect(
        child: Image.asset(
          'assets/images/During_your_application.jpg',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}

Widget _buildDesktopLayouts(double screenWidth, bool isTablet) {
  return Row(
    children: [
      // Left side with teal background and content
      Flexible(
        flex: isTablet ? 6 : 7,
        child: Container(
          padding: EdgeInsets.all(isTablet ? 40 : 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apply to get your skills assessed",
                style: TextStyle(
                  color: const Color(0xFFFFA000),
                  fontSize: isTablet ? 28 : 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Start the application process and if you have any questions, you can contact ${isTablet ? '' : '\n'}our customer support team at any stage.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 14 : 16,
                  height: 1.5,
                  letterSpacing: 0.3,
                ),
              ),
              _buildActionButton("Apply Online", isTablet ? 140 : 150),
            ],
          ),
        ),
      ),
      // Right side with desert landscape image
      Flexible(
        flex: isTablet ? 4 : 3,
        child: ClipRRect(
          child: Image.asset(
            'assets/images/During_your_application.jpg',
            width: double.infinity,
            height: isTablet ? 300 : 340,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}
 // Helper method to get responsive font size
double _getResponsiveFontSize(BuildContext context, double baseFontSize) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  if (screenWidth < 600) {
    // Mobile
    return baseFontSize * 0.8;
  } else if (screenWidth < 1024) {
    // Tablet
    return baseFontSize * 0.9;
  } else {
    // Desktop
    return baseFontSize;
  }
}

// Helper method to get responsive padding
EdgeInsets _getResponsivePadding(BuildContext context, {
  double mobile = 16,
  double tablet = 32,
  double desktop = 50,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  if (screenWidth < 600) {
    return EdgeInsets.all(mobile);
  } else if (screenWidth < 1024) {
    return EdgeInsets.all(tablet);
  } else {
    return EdgeInsets.all(desktop);
  }
}

// Helper method to check if device is mobile
bool _isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 600;
}

// Helper method to check if device is tablet
bool _isTablet(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width >= 600 && width < 1024;
}

Widget _buildHeaderBanner(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = _isMobile(context);
  final isTablet = _isTablet(context);
  
  return Container(
    width: screenWidth,
    height: isMobile ? screenHeight * 0.5 : screenHeight * 0.6,
    decoration: const BoxDecoration(color: tealColor),
    child: Stack(
      children: [
        // Background image - hide on mobile for better text readability
        if (!isMobile)
          Positioned(
            right: 0,
            child: Image.asset(
              'assets/images/internal_page_banner.png',
              height: isMobile ? screenHeight * 0.5 : screenHeight * 0.6,
              fit: BoxFit.fitHeight,
            ),
          ),
        Container(
          width: isMobile ? screenWidth * 0.9 : screenWidth * 0.66,
          padding: EdgeInsets.only(
            top: isMobile ? 60 : 100,
            left: isMobile ? 20 : (isTablet ? 30 : 50),
            right: isMobile ? 20 : 0,
          ),
          child: Align(
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: isMobile 
                  ? CrossAxisAlignment.center 
                  : CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Skills Assessment fees for \nProfessional Occupations",
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  style: TextStyle(
                    color: const Color(0xFFFFA000),
                    fontSize: _getResponsiveFontSize(context, 42),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: isMobile ? 15 : 20),
                Text(
                  "Professional Fees and Payments",
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _getResponsiveFontSize(context, 16),
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

Widget _buildBreadcrumbs(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = _isMobile(context);
  
  const TextStyle linkStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF0d5257),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  final responsiveLinkStyle = TextStyle(
    fontSize: _getResponsiveFontSize(context, 14),
    color: const Color(0xFF0d5257),
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  // For mobile, show simplified breadcrumbs or make them scrollable
  if (isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text('Home', style: responsiveLinkStyle),
            ),
            Text(' / ', style: TextStyle(color: Colors.grey, fontSize: 12)),
            TextButton(
              onPressed: () {},
              child: Text(
                'Skills Assessment',
                style: responsiveLinkStyle,
              ),
            ),
            Text(' / ', style: TextStyle(color: Colors.grey, fontSize: 14)),
        TextButton(
          onPressed: () {},
          child: Text(
            'Skills Assessment for professional occupations',
            style: responsiveLinkStyle,
          ),
        ),
            Text(' / ', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(
              'Professional Fees',
              style: TextStyle(
                color: Colors.grey[600], 
                fontSize: _getResponsiveFontSize(context, 14)
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 12, 
      horizontal: screenWidth < 1024 ? 30 : 50
    ),
    child: Wrap(
      children: [
        TextButton(
          onPressed: () {},
          child: Text('Home', style: responsiveLinkStyle),
        ),
        Text(' / ', style: TextStyle(color: Colors.grey, fontSize: 14)),
        TextButton(
          onPressed: () {},
          child: Text(
            'Skills Assessment For Migration',
            style: responsiveLinkStyle,
          ),
        ),
        Text(' / ', style: TextStyle(color: Colors.grey, fontSize: 14)),
        TextButton(
          onPressed: () {},
          child: Text(
            'Skills Assessment for professional occupations',
            style: responsiveLinkStyle,
          ),
        ),
        Text(' / ', style: TextStyle(color: Colors.grey, fontSize: 14)),
        Text(
          'Professional Fees and Payments',
          style: TextStyle(
            color: Colors.grey[600], 
            fontSize: _getResponsiveFontSize(context, 14)
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildProcessSteps(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final isMobile = _isMobile(context);
  final isTablet = _isTablet(context);

  // Define all step data in a list
  final List<Map<String, dynamic>> stepsData = [
    {
      'step': 'Fees and payments',
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

    final Widget stepInfoColumn = Flexible(
      flex: isMobile ? 1 : (isTablet ? 5 : 4),
      child: Container(
        constraints: BoxConstraints(
          minHeight: isMobile ? 200 : 400,
        ),
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: isMobile 
              ? CrossAxisAlignment.center 
              : CrossAxisAlignment.start,
          children: [
            Text(
              stepData['step'],
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 28),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF006064),
              ),
            ),
            SizedBox(height: isMobile ? 20 : 40),
            Text(
              stepData['description'],
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 16),
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );

    final Widget imageWidget = Flexible(
      flex: isMobile ? 1 : (isTablet ? 5 : 6),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: isMobile ? 250 : (isTablet ? 350 : 440),
        ),
        child: Image.asset(
          stepData['image'],
          fit: BoxFit.contain,
          width: double.infinity,
        ),
      ),
    );

    // For mobile, stack vertically
    if (isMobile) {
      return Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: Column(
          children: [
            imageWidget,
            const SizedBox(height: 30),
            stepInfoColumn,
          ],
        ),
      );
    }

    // For tablet and desktop, use row layout with Flexible widgets
    final List<Widget> rowChildren = stepData['imageOnRight']
        ? [stepInfoColumn, const SizedBox(width: 20), imageWidget]
        : [imageWidget, const SizedBox(width: 20), stepInfoColumn];

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? screenWidth * 0.05 : screenWidth * 0.1,
        vertical: screenHeight / (isMobile ? 15 : 10),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: rowChildren,
        ),
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

 // Build a responsive table that adapts to screen size
Widget _buildResponsiveTable(
  BuildContext context, {
  required String headerText,
  required List<TableRowInfo> rows,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isTablet = screenWidth >= 768;
  final isMobile = screenWidth < 600;
  
  // For very small screens, use a card-based layout instead of table
  if (screenWidth < 480) {
    return _buildCardLayout(context, headerText: headerText, rows: rows);
  }
  
  return ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: screenWidth,
    ),
    child: Table(
      border: TableBorder.all(
        color: Colors.grey.shade300,
        width: isMobile ? 0.5 : 1.0,
      ),
      columnWidths: _getResponsiveColumnWidths(screenWidth),
      children: _buildResponsiveTableRows(
        context,
        headerText: headerText,
        rows: rows,
        isMobile: isMobile,
        isTablet: isTablet,
      ),
    ),
  );
}

// Get responsive column widths based on screen size
Map<int, TableColumnWidth> _getResponsiveColumnWidths(double screenWidth) {
  if (screenWidth < 600) {
    // Mobile: More space for description, less for prices
    return const {
      0: FlexColumnWidth(3),
      1: FlexColumnWidth(2),
      2: FlexColumnWidth(2),
    };
  } else if (screenWidth < 900) {
    // Tablet: Balanced layout
    return const {
      0: FlexColumnWidth(2.5),
      1: FlexColumnWidth(1.5),
      2: FlexColumnWidth(1.5),
    };
  } else {
    // Desktop: Even more space for readability
    return const {
      0: FlexColumnWidth(3),
      1: FlexColumnWidth(2),
      2: FlexColumnWidth(2),
    };
  }
}

// Build responsive table rows
List<TableRow> _buildResponsiveTableRows(
  BuildContext context, {
  required String headerText,
  required List<TableRowInfo> rows,
  required bool isMobile,
  required bool isTablet,
}) {
  List<TableRow> tableRows = [
    // Header Row
    TableRow(
      decoration: const BoxDecoration(
        color: Color(0xFF0d5257), // Dark teal header
      ),
      children: [
        _buildResponsiveHeaderCell(headerText, isMobile, isTablet),
        _buildResponsiveHeaderCell(
          isMobile 
            ? 'Australia\n(inc. GST)'
            : 'Applying from within Australia (includes GST)',
          isMobile,
          isTablet,
        ),
        _buildResponsiveHeaderCell(
          isMobile 
            ? 'Overseas\n(exc. GST)'
            : 'Applicant is not a resident of Australia for tax purposes (excludes GST)',
          isMobile,
          isTablet,
        ),
      ],
    ),
  ];

  // Add data rows
  for (var rowInfo in rows) {
    tableRows.add(
      _buildResponsiveDataRow(
        label: rowInfo.label,
        australiaPrice: rowInfo.australiaPrice,
        overseasPrice: rowInfo.overseasPrice,
        isLastRow: rowInfo.isLastRow,
        isMobile: isMobile,
        isTablet: isTablet,
      ),
    );
  }

  return tableRows;
}

// Responsive table header cell
Widget _buildResponsiveHeaderCell(String text, bool isMobile, bool isTablet) {
  return Padding(
    padding: EdgeInsets.all(isMobile ? 6.0 : isTablet ? 10.0 : 12.0),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: isMobile ? 12 : isTablet ? 14 : 16,
        height: 1.2,
      ),
      textAlign: TextAlign.center,
      maxLines: isMobile ? 3 : 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

// Responsive table data row
TableRow _buildResponsiveDataRow({
  required String label,
  required String australiaPrice,
  required String overseasPrice,
  bool isLastRow = false,
  required bool isMobile,
  required bool isTablet,
}) {
  final fontSize = isMobile ? 13.0 : isTablet ? 15.0 : 16.0;
  final padding = isMobile ? 8.0 : isTablet ? 12.0 : 16.0;
  
  return TableRow(
    decoration: isLastRow
        ? null
        : BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: isMobile ? 0.5 : 1.0,
              ),
            ),
          ),
    children: [
      Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            height: 1.3,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          australiaPrice,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          overseasPrice,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

// Card-based layout for very small screens
Widget _buildCardLayout(
  BuildContext context, {
  required String headerText,
  required List<TableRowInfo> rows,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Header card
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF0d5257),
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Text(
          headerText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      // Data cards
      ...rows.map((rowInfo) => _buildDataCard(rowInfo)).toList(),
    ],
  );
}

// Individual data card for mobile layout
Widget _buildDataCard(TableRowInfo rowInfo) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300),
        left: BorderSide(color: Colors.grey.shade300),
        right: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rowInfo.label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0d5257),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Australia (inc. GST)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rowInfo.australiaPrice,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0d5257),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overseas (exc. GST)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rowInfo.overseasPrice,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0d5257),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


 // Enhanced responsive review table with proper media queries
Widget _buildReviewTable(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  // Define responsive breakpoints
  final isExtraSmall = screenWidth < 480;
  final isSmall = screenWidth < 600;
  final isMedium = screenWidth >= 600 && screenWidth < 900;
  final isLarge = screenWidth >= 900 && screenWidth < 1200;
  final isExtraLarge = screenWidth >= 1200;
  
  // Return appropriate layout based on screen size
  if (isExtraSmall) {
    return _buildCompactMobileReviewTable(context);
  } else if (isSmall) {
    return _buildMobileReviewTable(context);
  } else if (isMedium) {
    return _buildTabletReviewTable(context);
  } else {
    return _buildDesktopReviewTable(context);
  }
}

// Extra compact layout for very small screens
Widget _buildCompactMobileReviewTable(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Header
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: const BoxDecoration(
          color: Color(0xFF0d5257),
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Text(
          'Review Application Fees',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      
      // Group A and E
      _buildCompactGroupSection(context, 'Group A and E', [
        _buildCompactReviewCard(context, 'Qualification only', 'AUD \$365.20', 'AUD \$332.00'),
        _buildCompactReviewCard(context, 'Employment only', 'AUD \$654.50', 'AUD \$595.00'),
        _buildCompactReviewCard(context, 'Both', 'AUD \$981.20', 'AUD \$892.00'),
      ]),
      
      // Group B, C, D and F
      _buildCompactGroupSection(context, 'Group B, C, D and F', [
        _buildCompactReviewCard(context, 'Qualification only', 'AUD \$365.20', 'AUD \$332.00'),
        _buildCompactReviewCard(context, 'Employment only', 'AUD \$654.50', 'AUD \$595.00'),
        _buildCompactReviewCard(context, 'Both', 'AUD \$981.20', 'AUD \$892.00'),
      ]),
    ],
  );
}

Widget _buildCompactGroupSection(BuildContext context, String groupName, List<Widget> cards) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  return Column(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.025,
          horizontal: screenWidth * 0.03,
        ),
        color: const Color(0xFFE6F2F5),
        child: Text(
          groupName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.038,
            color: const Color(0xFF005F73),
          ),
        ),
      ),
      ...cards,
    ],
  );
}

Widget _buildCompactReviewCard(BuildContext context, String type, String inclGST, String exclGST) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(screenWidth * 0.03),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.035,
            color: const Color(0xFF0d5257),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Inc. GST: $inclGST',
                style: TextStyle(fontSize: screenWidth * 0.03),
              ),
            ),
            Expanded(
              child: Text(
                'Exc. GST: $exclGST',
                style: TextStyle(fontSize: screenWidth * 0.03),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Enhanced mobile layout for small screens
Widget _buildMobileReviewTable(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Group A and E
      _buildResponsiveMobileGroupHeader(context, 'Group A and E'),
      _buildResponsiveMobileReviewRow(
        context: context,
        reviewType: 'Qualification only',
        qualOutcome: 'Negative (not highly relevant or not at the required level)',
        empOutcome: 'Negative due to qualification',
        evidence: 'Qualification',
        feeIncl: 'AUD \$365.20',
        feeExcl: 'AUD \$332.00',
      ),
      _buildResponsiveMobileReviewRow(
        context: context,
        reviewType: 'Employment only',
        qualOutcome: 'Positive',
        empOutcome: 'Negative due to any reason (except qualification)',
        evidence: 'Employment',
        feeIncl: 'AUD \$654.50',
        feeExcl: 'AUD \$595.00',
      ),
      _buildResponsiveMobileReviewRow(
        context: context,
        reviewType: 'Both Qualification and Employment',
        qualOutcome: 'Negative (not highly relevant or not at the required level)',
        empOutcome: 'Negative due to any reason (including qualification)',
        evidence: 'Qualification and Employment',
        feeIncl: 'AUD \$981.20',
        feeExcl: 'AUD \$892.00',
        isLastInGroup: true,
      ),

      // Group B, C, D and F
      _buildResponsiveMobileGroupHeader(context, 'Group B, C, D and F'),
      _buildResponsiveMobileReviewRow(
        context: context,
        reviewType: 'Qualification only',
        qualOutcome: 'Negative (not highly relevant or not at the required level)',
        empOutcome: 'Negative due to qualification',
        evidence: 'Qualification',
        feeIncl: 'AUD \$365.20',
        feeExcl: 'AUD \$332.00',
      ),
      _buildResponsiveMobileReviewRow(
        context: context,
        reviewType: 'Employment only',
        qualOutcome: 'Negative (not highly relevant and you are not contesting the relevance)',
        empOutcome: 'Negative due to any reason (except qualification not at the required level)**',
        evidence: 'Employment',
        feeIncl: 'AUD \$654.50',
        feeExcl: 'AUD \$595.00',
      ),
      _buildResponsiveMobileReviewRow(
        context: context,
        reviewType: 'Employment only',
        qualOutcome: 'Positive',
        empOutcome: 'Negative due to any reason (except qualification)',
        evidence: 'Employment',
        feeIncl: 'AUD \$654.50',
        feeExcl: 'AUD \$595.00',
      ),
      _buildResponsiveMobileReviewRow(
        context: context,
        reviewType: 'Both Qualification and Employment',
        qualOutcome: 'Negative (not highly relevant or not at the required level)',
        empOutcome: 'Negative due to any reason (including qualification)',
        evidence: 'Qualification and Employment',
        feeIncl: 'AUD \$981.20',
        feeExcl: 'AUD \$892.00',
        isLastInGroup: true,
      ),
    ],
  );
}

// Responsive mobile group header
Widget _buildResponsiveMobileGroupHeader(BuildContext context, String text) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      vertical: screenHeight * 0.015,
      horizontal: screenWidth * 0.025,
    ),
    color: const Color(0xFFE6F2F5),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: screenWidth * 0.042,
        color: const Color(0xFF005F73),
        letterSpacing: 0.5,
      ),
    ),
  );
}

// Responsive mobile review row
Widget _buildResponsiveMobileReviewRow({
  required BuildContext context,
  required String reviewType,
  required String qualOutcome,
  required String empOutcome,
  required String evidence,
  required String feeIncl,
  required String feeExcl,
  bool isLastInGroup = false,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(screenWidth * 0.025),
    decoration: BoxDecoration(
      border: Border(
        bottom: isLastInGroup
            ? BorderSide.none
            : BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildResponsiveMobileInfoRow(context, 'Review type:', reviewType),
        SizedBox(height: screenHeight * 0.008),
        _buildResponsiveMobileInfoRow(context, 'Qualification outcome:', qualOutcome),
        SizedBox(height: screenHeight * 0.008),
        _buildResponsiveMobileInfoRow(context, 'Employment outcome:', empOutcome),
        SizedBox(height: screenHeight * 0.008),
        _buildResponsiveMobileInfoRow(context, 'Required evidence:', evidence),
        SizedBox(height: screenHeight * 0.01),
        Row(
          children: [
            Expanded(
              child: _buildResponsiveMobileInfoRow(context, 'Incl. GST:', feeIncl),
            ),
            Expanded(
              child: _buildResponsiveMobileInfoRow(context, 'Excl. GST:', feeExcl),
            ),
          ],
        ),
      ],
    ),
  );
}

// Responsive mobile info row
Widget _buildResponsiveMobileInfoRow(BuildContext context, String label, String value) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontSize: screenWidth * 0.035,
        color: Colors.black,
        height: 1.4,
      ),
      children: [
        TextSpan(
          text: '$label ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: value),
      ],
    ),
  );
}

// Tablet layout for medium screens
Widget _buildTabletReviewTable(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      width: math.max(screenWidth, 800), // Minimum width for tablet
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Table(
        columnWidths: _getTabletColumnWidths(),
        border: TableBorder.all(color: Colors.grey.shade300),
        children: _buildTabletTableRows(context),
      ),
    ),
  );
}

// Get tablet-specific column widths
Map<int, TableColumnWidth> _getTabletColumnWidths() {
  return const {
    0: FlexColumnWidth(1.2), // Occupation Group
    1: FlexColumnWidth(1.8), // Review application type
    2: FlexColumnWidth(2.2), // Qualification outcome
    3: FlexColumnWidth(2.2), // Employment outcome
    4: FlexColumnWidth(1.8), // Additional Supporting Evidence
    5: FlexColumnWidth(1), // Fees (including GST)
    6: FlexColumnWidth(1), // Fees (excluding GST)
  };
}

// Build tablet table rows
List<TableRow> _buildTabletTableRows(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 600;
  final isTablet = screenWidth >= 600 && screenWidth < 900;
  
  return [
    // Header Row
    TableRow(
      decoration: const BoxDecoration(
        color: Color(0xFF0d5257),
      ),
      children: [
        _buildResponsiveHeaderCell('Occupation Group', isMobile, isTablet),
        _buildResponsiveHeaderCell('Review application type', isMobile, isTablet),
        _buildResponsiveHeaderCell('Qualification outcome for initial application', isMobile, isTablet),
        _buildResponsiveHeaderCell('Employment outcome for initial application', isMobile, isTablet),
        _buildResponsiveHeaderCell('Additional Supporting Evidence required', isMobile, isTablet),
        _buildResponsiveHeaderCell('Fees (including GST)*', isMobile, isTablet),
        _buildResponsiveHeaderCell('Fees (excluding GST)*', isMobile, isTablet),
      ],
    ),
    // Add all data rows here (similar to your existing structure)
    // Group A and E rows...
    _buildTabletDataRow(context, 'Group\nA and E', 'Qualification only', 
        'Negative\n(not highly relevant or\nnot at the required level)',
        'Negative due to qualification', 'Qualification', 'AUD \$365.20', 'AUD \$332.00'),
    // Add more rows as needed...
  ];
}

// Enhanced desktop layout
Widget _buildDesktopReviewTable(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Table(
      columnWidths: _getDesktopColumnWidths(screenWidth),
      border: TableBorder.all(color: Colors.grey.shade300),
      children: _buildDesktopTableRows(context),
    ),
  );
}

// Get responsive desktop column widths
Map<int, TableColumnWidth> _getDesktopColumnWidths(double screenWidth) {
  if (screenWidth > 1400) {
    // Extra large screens
    return const {
      0: FlexColumnWidth(1.2),
      1: FlexColumnWidth(1.5),
      2: FlexColumnWidth(2),
      3: FlexColumnWidth(2),
      4: FlexColumnWidth(1.8),
      5: FlexColumnWidth(1),
      6: FlexColumnWidth(1),
    };
  } else {
    // Standard desktop
    return const {
      0: FlexColumnWidth(1),
      1: FlexColumnWidth(1.2),
      2: FlexColumnWidth(1.5),
      3: FlexColumnWidth(1.5),
      4: FlexColumnWidth(1),
      5: FlexColumnWidth(0.8),
      6: FlexColumnWidth(0.8),
    };
  }
}

// Build desktop table rows with responsive sizing
List<TableRow> _buildDesktopTableRows(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 600;
  final isTablet = screenWidth >= 600 && screenWidth < 900;
  
  return [
    // Header Row
    TableRow(
      decoration: const BoxDecoration(
        color: Color(0xFF0d5257),
      ),
      children: [
        _buildResponsiveHeaderCell('Occupation Group', isMobile, isTablet),
        _buildResponsiveHeaderCell('Review application type', isMobile, isTablet),
        _buildResponsiveHeaderCell('Qualification outcome for initial application', isMobile, isTablet),
        _buildResponsiveHeaderCell('Employment outcome for initial application', isMobile, isTablet),
        _buildResponsiveHeaderCell('Additional Supporting Evidence required', isMobile, isTablet),
        _buildResponsiveHeaderCell('Fees (including GST)*', isMobile, isTablet),
        _buildResponsiveHeaderCell('Fees (excluding GST)*', isMobile, isTablet),
      ],
    ),
    
    // Group A and E - Qualification only
    TableRow(
      children: [
        _buildMultiRowCell('Group\nA and E', 3, TextAlign.center),
        _buildResponsiveDataCell(context, 'Qualification only'),
        _buildResponsiveDataCell(context, 'Negative\n(not highly relevant or\nnot at the required level)'),
        _buildResponsiveDataCell(context, 'Negative due to qualification'),
        _buildResponsiveDataCell(context, 'Qualification'),
        _buildResponsiveDataCell(context, 'AUD \$365.20', TextAlign.center),
        _buildResponsiveDataCell(context, 'AUD \$332.00', TextAlign.center),
      ],
    ),

    // Group A and E - Employment only
    TableRow(
      children: [
        _buildHiddenCell(),
        _buildResponsiveDataCell(context, 'Employment only'),
        _buildResponsiveDataCell(context, 'Positive'),
        _buildResponsiveDataCell(context, 'Negative due to any reason\n(except qualification)'),
        _buildResponsiveDataCell(context, 'Employment'),
        _buildResponsiveDataCell(context, 'AUD \$654.50', TextAlign.center),
        _buildResponsiveDataCell(context, 'AUD \$595.00', TextAlign.center),
      ],
    ),

    // Group A and E - Both
    TableRow(
      children: [
        _buildHiddenCell(),
        _buildResponsiveDataCell(context, 'Both\nQualification and Employment'),
        _buildResponsiveDataCell(context, 'Negative\n(not highly relevant or\nnot at the required level)'),
        _buildResponsiveDataCell(context, 'Negative due to any reason\n(including qualification)'),
        _buildResponsiveDataCell(context, 'Qualification and Employment'),
        _buildResponsiveDataCell(context, 'AUD \$981.20', TextAlign.center),
        _buildResponsiveDataCell(context, 'AUD \$892.00', TextAlign.center),
      ],
    ),

    // Group B, C, D and F - First row
    TableRow(
      children: [
        _buildMultiRowCell('Group\nB, C, D and F', 4, TextAlign.center),
        _buildResponsiveDataCell(context, 'Qualification only'),
        _buildResponsiveDataCell(context, 'Negative\n(not highly relevant or\nnot at the required level)'),
        _buildResponsiveDataCell(context, 'Negative due to qualification'),
        _buildResponsiveDataCell(context, 'Qualification'),
        _buildResponsiveDataCell(context, 'AUD \$365.20', TextAlign.center),
        _buildResponsiveDataCell(context, 'AUD \$332.00', TextAlign.center),
      ],
    ),

    // Group B, C, D and F - Employment only (first)
    TableRow(
      children: [
        _buildHiddenCell(),
        _buildResponsiveDataCell(context, 'Employment only'),
        _buildResponsiveDataCell(context, 'Negative\n(not highly relevant and\nyou are not contesting\nthe relevance)'),
        _buildResponsiveDataCell(context, 'Negative due to any reason\n(except qualification not at\nthe required level)**'),
        _buildResponsiveDataCell(context, 'Employment'),
        _buildResponsiveDataCell(context, 'AUD \$654.50', TextAlign.center),
        _buildResponsiveDataCell(context, 'AUD \$595.00', TextAlign.center),
      ],
    ),

    // Group B, C, D and F - Employment only (second)
    TableRow(
      children: [
        _buildHiddenCell(),
        _buildResponsiveDataCell(context, 'Employment only'),
        _buildResponsiveDataCell(context, 'Positive'),
        _buildResponsiveDataCell(context, 'Negative due to any reason\n(except qualification)'),
        _buildResponsiveDataCell(context, 'Employment'),
        _buildResponsiveDataCell(context, 'AUD \$654.50', TextAlign.center),
        _buildResponsiveDataCell(context, 'AUD \$595.00', TextAlign.center),
      ],
    ),

    // Group B, C, D and F - Both
    TableRow(
      children: [
        _buildHiddenCell(),
        _buildResponsiveDataCell(context, 'Both\nQualification and Employment'),
        _buildResponsiveDataCell(context, 'Negative\n(not highly relevant or\nnot at the required level)'),
        _buildResponsiveDataCell(context, 'Negative due to any reason\n(including qualification)'),
        _buildResponsiveDataCell(context, 'Qualification and Employment'),
        _buildResponsiveDataCell(context, 'AUD \$981.20', TextAlign.center),
        _buildResponsiveDataCell(context, 'AUD \$892.00', TextAlign.center),
      ],
    ),
  ];
}



// Responsive data cell builder
Widget _buildResponsiveDataCell(BuildContext context, String text, [TextAlign align = TextAlign.start]) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  return Container(
    padding: EdgeInsets.all(screenWidth * 0.008),
    child: Text(
      text,
      style: TextStyle(
        fontSize: _getResponsiveFontSize( context, 16),
        height: 1.3,
      ),
      textAlign: align,
    ),
  );
}

// Tablet data row builder
TableRow _buildTabletDataRow(BuildContext context, String group, String reviewType, 
    String qualOutcome, String empOutcome, String evidence, String feeIncl, String feeExcl) {
  return TableRow(
    children: [
      _buildResponsiveDataCell(context, group, TextAlign.center),
      _buildResponsiveDataCell(context, reviewType),
      _buildResponsiveDataCell(context, qualOutcome),
      _buildResponsiveDataCell(context, empOutcome),
      _buildResponsiveDataCell(context, evidence),
      _buildResponsiveDataCell(context, feeIncl, TextAlign.center),
      _buildResponsiveDataCell(context, feeExcl, TextAlign.center),
    ],
  );
}

// Add missing helper methods from your original code

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
