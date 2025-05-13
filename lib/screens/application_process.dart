import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/BasePageLayout.dart';
import '../widgets/steps_section.dart';

class ApplicationProcess extends StatelessWidget {
  const ApplicationProcess({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 1100;

    // Color constants
    const Color tealColor = Color(0xFF0A594C);
    const Color yellowColor = Color(0xFFF9C700);
    const Color dottedLineColor = Color(0xFF008996);

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(screenHeight, screenWidth),
          _buildBreadcrumbs(),
          _buildMainContent(screenWidth, screenHeight),
          ProcessStepsSection(),

          _buildKeyTermsSection(
            'Key terms for Qualifications\nAssessment Criteria',
            [
              'What is a highly relevant area of study?',
              'What is study at the required educational level?',
            ],
            true,
            tealColor,
            yellowColor,
            dottedLineColor,
            context,
          ),
          SizedBox(height: 20),
          _buildKeyTermsSection(
            'Key terms for Employment\nAssessment Criteria',
            [
              'What is a highly relevant employment?',
              'What is pre- and post-qualification employment?',
              'What is Date Deemed Skilled?',
              'What is closely related employment?',
            ],
            false,
            tealColor,
            yellowColor,
            dottedLineColor,
            context,
          ),
          SizedBox(height: screenHeight / 6),
          _buildAfterApplicationSection(isLargeScreen),
          _buildFaqSection(
            'Explore FAQs',
            [
              'What is a highly relevant employment?',
              'What is pre- and post-qualification employment?',
              'What is Date Deemed Skilled?',
              'What is closely related employment?',
            ],
            false,
            tealColor,
            yellowColor,
            dottedLineColor,
            context,
          ),
          _buildPreparingApplSection(
            'Preparing your application',
            [
              'What is a highly relevant employment?',
              'What is pre- and post-qualification employment?',
              'What is Date Deemed Skilled?',
              'What is closely related employment?',
            ],
            false,
            tealColor,
            yellowColor,
            dottedLineColor,
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildAfterApplicationSection(bool isLargeScreen) {
    return Container(
      color: Color(0xfff2f2f2),
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen ? 170.0 : 20.0,
        vertical: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'After your application',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00565B),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'You can ask for a review or an appeal of a VETASSESS skills assessment outcome, and you can apply to \nhave your skills assessed against another occupation.',
            style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
          ),
          const SizedBox(height: 30),
          isLargeScreen ? _buildOptionsGrid() : _buildOptionsColumn(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildOptionsGrid() {
    final List<Map<String, String>> options = _getOptionData();

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1.05,
      children:
          options
              .map(
                (option) =>
                    _buildOptionCard(option['title']!, option['description']!),
              )
              .toList(),
    );
  }

  Widget _buildOptionsColumn() {
    final List<Map<String, String>> options = _getOptionData();

    return Column(
      children:
          options.map((option) {
            return Column(
              children: [
                _buildOptionCard(option['title']!, option['description']!),
                const SizedBox(height: 20),
              ],
            );
          }).toList(),
    );
  }

  List<Map<String, String>> _getOptionData() {
    return [
      {
        'title': 'Renew your Application',
        'description':
            'Find out how to renew your application before it expires.',
      },
      {
        'title': 'Apply for Review',
        'description':
            'If you disagree with your unsuccessful skills assessment outcome, you can ask for a review of the decision.',
      },
      {
        'title': 'Apply for Reassessment',
        'description':
            'You can apply for a reassessment with a change of occupation.',
      },
      {
        'title': 'Provide Feedback',
        'description':
            'The team at VETASSESS will gladly receive and respond to all feedback from customers in a professional, timely and respectful manner. We aim to respond to all feedback within ten business days.',
      },
    ];
  }

  Widget _buildOptionCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00565B),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
          ),
          Spacer(),
          _buildViewMoreButton(),
        ],
      ),
    );
  }

  Widget _buildViewMoreButton() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'View more',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00565B),
              ),
            ),
            Container(
              width: 90,
              height: 2,
              color: Color(0xFF00565B),
              margin: EdgeInsets.only(top: 3),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Color(0xFF00565B),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
        ),
      ],
    );
  }

  Widget _buildHeaderBanner(double screenHeight, double screenWidth) {
    return Container(
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.7,
            height: screenHeight * 0.64,
            decoration: const BoxDecoration(color: Color(0xFF0d5257)),
            padding: const EdgeInsets.only(top: 100, left: 170),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Application process for a \nprofessional or general \nskills application",
                    style: TextStyle(
                      color: Color(0xFFFFA000),
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Start your migration journey by applying for a skills assessment for your professional \noccupation.",
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
          Image.asset(
            'assets/images/img.png',
            width: screenWidth * 0.3,
            height: screenHeight * 0.64,
            fit: BoxFit.fitHeight,
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
            'Application process for a professional or general skills application',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(double screenWidth, double screenHeight) {
    return Container(
      padding: const EdgeInsets.only(
        top: 50,
        right: 170,
        left: 170,
        bottom: 100,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Application Process',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.only(bottom: 150),
            width: screenWidth * 0.55,
            child: const Column(
              children: [
                Text(
                  'A VETASSESS full skills assessment involves assessing your qualifications and employment against the suitability of your nominated occupation.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'We assess your qualification/s against the Australian Qualifications Framework (AQF) and to determine the relevance of your qualifications for your nominated occupation. Employment assessment involves determining whether your work experience - whether in Australia or overseas - is at an appropriate skill level to your nominated occupation.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'You need a positive assessment of both your qualifications and your employment for your skills assessment to be successful.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          _buildTradesBanner(screenHeight),
        ],
      ),
    );
  }

  Widget _buildTradesBanner(double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.25,
      decoration: const BoxDecoration(color: Color(0xFF0d5257)),
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/vet.svg',
            width: screenHeight * 0.1,
            height: screenHeight * 0.2,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Looking for the trades assessment process?',
                    style: TextStyle(
                      color: Color(0xFFFFA000),
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    width: 125,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA000),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        "Go Here",
                        style: TextStyle(color: Colors.black),
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

  Widget _buildKeyTermsSection(
    String sectionTitle,
    List<String> expandableTitles,
    bool includeParagraphs,
    Color tealColor,
    Color yellowColor,
    Color dottedLineColor,
    BuildContext context,
  ) {
    // Generate expandable sections
    List<Widget> expandableSections = _buildExpandableSections(
      expandableTitles,
      includeParagraphs,
      tealColor,
      dottedLineColor,
      context,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 150),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Yellow top divider
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 1,
            color: yellowColor,
          ),

          // Main content with two columns
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column - Title only
                Container(
                  width: 400,
                  padding: const EdgeInsets.fromLTRB(24, 24, 0, 24),
                  child: Column(
                    children: [
                      Text(
                        sectionTitle,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: tealColor,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right column - Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: expandableSections,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildExpandableSections(
    List<String> expandableTitles,
    bool includeParagraphs,
    Color tealColor,
    Color dottedLineColor,
    BuildContext context,
  ) {
    List<Widget> expandableSections = [];

    for (int i = 0; i < expandableTitles.length; i++) {
      // Add expandable tile
      expandableSections.add(
        Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(surfaceTint: Colors.transparent),
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.fromLTRB(24, i == 0 ? 24 : 12, 24, 12),
            title: Text(
              expandableTitles[i],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: tealColor,
              ),
            ),
            trailing: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: tealColor, width: 3),
              ),
              child: Icon(Icons.add, color: tealColor, size: 18, weight: 700),
            ),
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Text('Content for required educational level'),
              ),
            ],
          ),
        ),
      );

      // Add dotted line separator if not the last item
      if (i < expandableTitles.length - 1 || includeParagraphs) {
        expandableSections.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomPaint(
              painter: DottedLinePainter(color: dottedLineColor),
              size: const Size(double.infinity, 1),
            ),
          ),
        );
      }
    }

    // Add text paragraphs if required
    if (includeParagraphs) {
      const textStyle = TextStyle(
        fontSize: 15,
        color: Colors.black87,
        height: 1.5,
      );
      final List<String> paragraphs = [
        'Please note that we will not be assessing an Australian Graduate Diploma or comparable overseas postgraduate diploma, either alone or in combination with underpinning sub-degree qualifications, for comparability to the educational level of an Australian Bachelor degree.',
        'This is based on the different nature and learning outcomes of an Australian Bachelor degree compared to other qualifications on the AQF.',
        'Therefore, a qualification assessed at AQF Graduate Diploma level cannot be used to meet the requirements of occupations that require a minimum of an AQF Bachelor degree level.',
        'The Postgraduate Diploma may, however, be considered for assessment against the requirements of occupations which require a qualification at AQF Diploma or Advanced Diploma/ Associate degree level.',
      ];

      for (int i = 0; i < paragraphs.length; i++) {
        expandableSections.add(
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              24,
              24,
              i < paragraphs.length - 1 ? 0 : 24,
            ),
            child: Text(paragraphs[i], style: textStyle),
          ),
        );

        if (i < paragraphs.length - 1) {
          expandableSections.add(const SizedBox(height: 24));
        }
      }
    }

    return expandableSections;
  }

  Widget _buildFaqSection(
    String sectionTitle,
    List<String> expandableTitles,
    bool includeParagraphs,
    Color tealColor,
    Color yellowColor,
    Color dottedLineColor,
    BuildContext context,
  ) {
    // Actual FAQ items from the image
    final List<String> actualFaqTitles = [
      'How long will it take for my assessment to be completed?',
      'I am a recent graduate with no work experience. Can I apply for a full skills assessment?',
      'I have extensive work experience in a field highly relevant to my nominated occupation but no formal qualifications. Can I still apply for a skills assessment?',
      'Can I change my occupation while my application is pending?',
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 150),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - Only title and View all button
            Container(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore FAQs",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A594C),
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 24),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "View all",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0A594C),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xFF0A594C),
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
                  ),
                ],
              ),
            ),

            // Right column - FAQ accordions with more space
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 6),
                child: Column(
                  children:
                      actualFaqTitles.map((title) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Theme(
                            data: ThemeData(
                              dividerColor: Colors.transparent,
                              colorScheme: ColorScheme.light(
                                surfaceTint: Colors.transparent,
                                primary: Color(0xFF0A594C),
                              ),
                            ),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 0,
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              childrenPadding: EdgeInsets.only(
                                left: 50,
                                bottom: 16,
                                right: 20,
                              ),
                              leading: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF0A594C),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFF0A594C),
                                  size: 18,
                                ),
                              ),
                              title: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0A594C),
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
                          ),
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

  // Updated _buildPreparingApplSection method with dotted lines
  Widget _buildPreparingApplSection(
    String sectionTitle,
    List<String> expandableTitles,
    bool includeParagraphs,
    Color tealColor,
    Color yellowColor,
    Color dottedLineColor,
    BuildContext context,
  ) {
    // Actual navigation items from the image
    final List<String> actualLinks = [
      'The application process',
      'Acceptable documents you will need',
      'Fees & Charges',
      'Check your occupation',
      'FAQs',
      'Reviews, Reassessments, Appeals, Reissues & Feedback',
      'Priority Processing & Urgent Applications',
      'Points Test Advice',
      'Renewals',
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 150),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - Title and description
            Container(
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

            // Right column - Navigation links with dotted lines
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                child: Column(
                  children:
                      actualLinks.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final String link = entry.value;
                        return Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        link,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF0A594C),
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
                              ),
                              // Add dotted line for all items except the last one
                              if (index < actualLinks.length - 1)
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  child: CustomPaint(
                                    painter: DottedLinePainterTwo(
                                      color: Color(0xFFF9C700),
                                    ),
                                  ),
                                ),
                            ],
                          ),
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

class DottedLinePainterTwo extends CustomPainter {
  final Color color;

  DottedLinePainterTwo({required this.color});

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
