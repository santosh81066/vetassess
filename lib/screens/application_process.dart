import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/BasePageLayout.dart';

class ApplicationProcess extends StatelessWidget {
  const ApplicationProcess({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isLargeScreen = width > 1100;
    // Color constants
    const Color tealColor = Color(0xFF0A594C);
    const Color yellowColor = Color(0xFFF9C700);
    const Color dottedLineColor = Color(0xFF008996);

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(screenHeight),
          _buildBreadcrumbs(),
          _buildMainContent(screenWidth, screenHeight),
          ..._buildProcessSteps(screenWidth),
          _buildKeyTermsSection(
            'Key terms for Qualifications\nAssessment Criteria',
            [
              'What is a highly relevant area of study?',
              'What is study at the required educational level?',
            ],
            true,
            // Include paragraphs
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
            // No paragraphs
            tealColor,
            yellowColor,
            dottedLineColor,
            context,
          ),
          SizedBox(height: screenHeight / 6),
          Container(
            color: Color(0xfff2f2f2),
            padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen ? 170.0 : 20.0,
              vertical: 40.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Text(
                  'After your application',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00565B),
                  ),
                ),
                const SizedBox(height: 16),
                // Description text
                Text(
                  'You can ask for a review or an appeal of a VETASSESS skills assessment outcome, and you can apply to \nhave your skills assessed against another occupation.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                // Options grid
                isLargeScreen ? _buildOptionsGrid() : _buildOptionsColumn(),

                const SizedBox(height: 40),
              ],
            ),
          ),
          _buildFaqSection(
            'Explore FAQs',
            [
              'What is a highly relevant employment?',
              'What is pre- and post-qualification employment?',
              'What is Date Deemed Skilled?',
              'What is closely related employment?',
            ],
            false,
            // No paragraphs
            tealColor,
            yellowColor,
            dottedLineColor,
            context,
          ),
        ],
      ),
    );
  }

  //After your application SECTION
  Widget _buildOptionsGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1.05,
      // Adjust this to match the image aspect ratio
      children: [
        _buildOptionCard(
          'Renew your Application',
          'Find out how to renew your application before it expires.',
        ),
        _buildOptionCard(
          'Apply for Review',
          'If you disagree with your unsuccessful skills assessment outcome, you can ask for a review of the decision.',
        ),
        _buildOptionCard(
          'Apply for Reassessment',
          'You can apply for a reassessment with a change of occupation.',
        ),
        _buildOptionCard(
          'Provide Feedback',
          'The team at VETASSESS will gladly receive and respond to all feedback from customers in a professional, timely and respectful manner. We aim to respond to all feedback within ten business days.',
        ),
      ],
    );
  }

  Widget _buildOptionsColumn() {
    return Column(
      children: [
        _buildOptionCard(
          'Renew your Application',
          'Find out how to renew your application before it expires.',
        ),
        const SizedBox(height: 20),
        _buildOptionCard(
          'Apply for Review',
          'If you disagree with your unsuccessful skills assessment outcome, you can ask for a review of the decision.',
        ),
        const SizedBox(height: 20),
        _buildOptionCard(
          'Apply for Reassessment',
          'You can apply for a reassessment with a change of occupation.',
        ),
        const SizedBox(height: 20),
        _buildOptionCard(
          'Provide Feedback',
          'The team at VETASSESS will gladly receive and respond to all feedback from customers in a professional, timely and respectful manner. We aim to respond to all feedback within ten business days.',
        ),
      ],
    );
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

  //hero
  Widget _buildHeaderBanner(double screenHeight) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/internal_banner.svg',
          width: screenHeight * 0.5,
          height: screenHeight * 0.5,
        ),
        Container(
          width: double.infinity,
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
      ],
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

  // APPLICATION PROCESS
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

  //STEPS
  List<Widget> _buildProcessSteps(double screenWidth) {
    // Define all step data in a list
    final List<Map<String, dynamic>> stepsData = [
      {
        'step': 'Step 1',
        'title': 'Choose a professional occupation',
        'description':
            'Select an occupation that aligns with your qualifications and work experience. Your nomination should reflect your skills and expertise accurately for the best assessment outcome.',
        'anzscoInfo':
            'Review the Australian and New Zealand Standard Classification of Occupations (ANZSCO) to ensure your chosen occupation matches your skills and qualifications.',
        'image': 'assets/images/lady_1_occupation.jpg',
        'imageOnRight': false,
      },
      {
        'step': 'Step 2',
        'title': 'Check eligibility requirements',
        'description':
            'Verify that you meet the minimum qualification and work experience requirements for your nominated occupation. Different occupations have different eligibility criteria.',
        'anzscoInfo':
            'Each occupation has specific skill requirements outlined in the ANZSCO. Ensure you understand these requirements before proceeding with your application.',
        'image': 'assets/images/management_consultant.png',
        'imageOnRight': true,
      },
      {
        'step': 'Step 3',
        'title': 'Create an account with VETASSESS',
        'description':
            'Register on the VETASSESS portal to begin your skills assessment process. You will need to provide personal details and create login credentials.',
        'anzscoInfo':
            'Have your ANZSCO occupation code ready when creating your account to streamline the application process.',
        'image': 'assets/images/Create_account_with_VETASSESS _1.jpg',
        'imageOnRight': false,
      },
      {
        'step': 'Step 4',
        'title': 'Submit your application and documents',
        'description':
            'Complete the online application form and upload all required documentation, including qualifications, employment evidence, and identification documents.',
        'anzscoInfo':
            'Ensure your documentation clearly demonstrates how your skills and experience align with your nominated ANZSCO occupation.',
        'image': 'assets/images/general_skills_application.jpg',
        'imageOnRight': true,
      },
      {
        'step': 'Step 5',
        'title': 'Application processing',
        'description':
            'Your application will be reviewed by VETASSESS assessors. You may be contacted for additional information or clarification during this stage.',
        'anzscoInfo':
            'VETASSESS assessors will compare your qualifications and experience against the ANZSCO standards for your nominated occupation.',
        'image': 'assets/images/During_your_application.jpg',
        'imageOnRight': false,
      },
      {
        'step': 'Step 6',
        'title': 'Receive assessment outcome',
        'description':
            'Once assessment is complete, you will receive an outcome letter indicating whether your skills have been positively assessed for your nominated occupation.',
        'anzscoInfo':
            'If successful, you can use your skills assessment for migration purposes as specified in the Department of Home Affairs requirements.',
        'image': 'assets/images/Application_Outcome.jpg',
        'imageOnRight': true,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stepData['step'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            Text(
              stepData['title'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            Text(
              stepData['description'],
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
            const Text(
              'Information on the ANZSCO description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            Text(
              stepData['anzscoInfo'],
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
        height: 400,
        width: 600,
      );

      final List<Widget> rowChildren =
          stepData['imageOnRight']
              ? [stepInfoColumn, imageWidget]
              : [imageWidget, stepInfoColumn];

      return Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: index == 0 ? 0 : 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      );
    }).toList();
  }

  //KEY TERMS
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

  Widget _buildFaqSection(
    String sectionTitle,
    List<String> expandableTitles,
    bool includeParagraphs,
    Color tealColor,
    Color yellowColor,
    Color dottedLineColor,
    BuildContext context,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Generate expandable sections
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
            tilePadding: EdgeInsets.fromLTRB(24, i == 0 ? 24 : 20, 24, 20),
            title: Text(
              expandableTitles[i],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: tealColor,
              ),
            ),
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: tealColor, width: 3),
              ),
              child: Icon(Icons.add, color: tealColor, size: 22, weight: 700),
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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 150,
        vertical: screenHeight / 6,
      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sectionTitle,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: tealColor,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildViewMoreButton(),
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
