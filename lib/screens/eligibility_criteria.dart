import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

// Constants for reusable colors
const Color kTealColor = Color(0xFF00565B);
const Color kYellowColor = Color(0xFFF9C700);
const Color kDottedLineColor = Color(0xFF008996);
const Color kAccentGreen = Color(0xFF0A594C);
const Color kAccentGold = Color(0xFFFFA000);

class EligibilityCriteria extends StatelessWidget {
  const EligibilityCriteria({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 768;

    return BasePageLayout(
      child: Column(
        children: [
          // Main header banner section - kept exactly as original
          _buildHeaderBanner(screenHeight, screenWidth, isSmallScreen),

          // Breadcrumbs navigation
          _buildBreadcrumbs(isSmallScreen),

          // Skills assessment information section
          ..._buildProcessSteps(screenWidth, isSmallScreen),

          // Document gathering guide section
          _buildGatherDocSection(isSmallScreen),

          // Occupation search section
          _buildSearchSection(screenHeight, screenWidth, isSmallScreen),

          // FAQ section
          _buildFaqSection(isSmallScreen),
        ],
      ),
    );
  }

  // Header banner with text and image - keeping this exactly as in the original code
  Widget _buildHeaderBanner(
    double screenHeight,
    double screenWidth,
    bool isSmallScreen,
  ) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.64,
      decoration: const BoxDecoration(color: kTealColor),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Image.asset(
              'assets/images/internal_page_banner.png',
              height: screenHeight * 0.64,
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
      ),
    );
  }

  // Breadcrumbs navigation links
  Widget _buildBreadcrumbs(bool isSmallScreen) {
    const TextStyle linkStyle = TextStyle(
      fontSize: 14,
      color: Color(0xFF0d5257),
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );

    // List of breadcrumb items with their respective link text
    final List<Map<String, String>> breadcrumbs = [
      {'text': 'Home', 'isActive': 'false'},
      {'text': 'Skills Assessment For Migration', 'isActive': 'false'},
      {
        'text': 'Skills Assessment for professional occupations',
        'isActive': 'false',
      },
      {'text': 'Am I eligible to apply?', 'isActive': 'true'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: isSmallScreen ? 20 : 150,
      ),
      child:
          isSmallScreen
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildBreadcrumbItems(breadcrumbs, linkStyle),
              )
              : Row(children: _buildBreadcrumbItems(breadcrumbs, linkStyle)),
    );
  }

  // Generate breadcrumb item widgets
  List<Widget> _buildBreadcrumbItems(
    List<Map<String, String>> items,
    TextStyle linkStyle,
  ) {
    List<Widget> widgets = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final bool isActive = item['isActive'] == 'true';

      widgets.add(
        isActive
            ? Text(
              item['text']!,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            )
            : TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: Text(item['text']!, style: linkStyle),
            ),
      );

      // Add separator except after the last item
      if (i < items.length - 1) {
        widgets.add(const Text(' / ', style: TextStyle(color: Colors.grey)));
      }
    }

    return widgets;
  }

  // Professional occupation information section
  List<Widget> _buildProcessSteps(double screenWidth, bool isSmallScreen) {
    // Define step data
    final Map<String, dynamic> stepData = {
      'step':
          'We provide skills assessments \nfor the largest range of \noccupations in Australia.',
      'description':
          "The Australian Government has authorised us to provide skills assessments for 341 professional and other non-trade occupations. If you're a professional needing a skills assessment to migrate to Australia, we can offer you a service that understands and can assess your experience and qualifications.",
      'image': 'assets/images/skiil_assesment_support.jpg',
      'imageOnRight': true,
    };

    final Widget stepInfoColumn = Container(
      width: isSmallScreen ? screenWidth * 0.9 : screenWidth * 0.4,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepData['step'],
            style: TextStyle(
              fontSize: isSmallScreen ? 24 : 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF006064),
            ),
          ),
          SizedBox(height: 20),
          Text(
            stepData['description'],
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );

    final Widget imageWidget = Image.asset(
      stepData['image'],
      height: isSmallScreen ? 300 : 450,
      width: isSmallScreen ? screenWidth * 0.9 : 600,
      fit: BoxFit.cover,
    );

    // Layout differently based on screen size
    return [
      Container(
        color: Colors.white,
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? screenWidth * 0.05 : screenWidth * 0.1,
          vertical: isSmallScreen ? 30 : screenWidth * 0.06,
        ),
        child:
            isSmallScreen
                ? Column(
                  children: [stepInfoColumn, SizedBox(height: 20), imageWidget],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      stepData['imageOnRight']
                          ? [stepInfoColumn, imageWidget]
                          : [imageWidget, stepInfoColumn],
                ),
      ),
    ];
  }

  // Document gathering section with expandable items
  Widget _buildGatherDocSection(bool isSmallScreen) {
    // List of document requirements
    final List<String> documentItems = [
      'Resume / curriculum vitae (CV)',
      'Photograph',
      "Proof of identity",
      'Change of name',
      'Qualification evidence',
      "Employment Evidence",
      'Supplying a Statutory Declaration or Affidavit',
      'Application fee',
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : 150,
        vertical: isSmallScreen ? 30 : 60,
      ),
      child:
          isSmallScreen
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGatherDocTitle(),
                  SizedBox(height: 30),
                  _buildAccordionList(documentItems),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column - Title and description
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: _buildGatherDocTitle(),
                    ),
                  ),
                  // Right column - Expandable document items
                  Expanded(flex: 2, child: _buildAccordionList(documentItems)),
                ],
              ),
    );
  }

  // Title and description for document gathering section
  Widget _buildGatherDocTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gather the documents you will need",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: kAccentGreen,
            height: 1.3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100),
          child: Column(
            children: const [
              SizedBox(height: 20),
              Text(
                "In this section you will find a list of documents that you will need to submit with your application. It's important that you include all the documentation we require, so that your application is complete.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We are under no obligation to seek further information from you and can make a decision based on the evidence you provided with your application. ",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "All documents must be high quality colour scans of the original documents. If your documents are not issued in English, you must submit scans of both the original language documents and English translations made by a registered translation service.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Search occupation section
  Widget _buildSearchSection(
    double screenHeight,
    double screenWidth,
    bool isSmallScreen,
  ) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 100, top: 50),
        child: Container(
          width: isSmallScreen ? screenWidth * 0.9 : screenWidth * 0.6,
          height: isSmallScreen ? screenHeight * 0.5 : screenHeight * 0.44,
          color: kTealColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Search For Your Occupation And Check \nEligibility Here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kAccentGold,
                  fontSize: isSmallScreen ? 24 : 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.46,
                child: const _SearchBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FAQ section with expandable items
  Widget _buildFaqSection(bool isSmallScreen) {
    // List of FAQ questions
    final List<String> faqItems = [
      'What if I do not meet the requirements for my nominated occupation?',
      'How long will it take to process my application?',
      'What if my occupation is not listed?',
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 20 : 150,
        vertical: isSmallScreen ? 30 : 60,
      ),
      child:
          isSmallScreen
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFaqTitle(),
                  SizedBox(height: 30),
                  _buildAccordionList(faqItems),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left column - Title and View all button
                  Expanded(flex: 1, child: _buildFaqTitle()),
                  // Right column - FAQ accordions
                  Expanded(flex: 2, child: _buildAccordionList(faqItems)),
                ],
              ),
    );
  }

  // Title and view all button for FAQ section
  Widget _buildFaqTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Explore FAQs",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: kAccentGreen,
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
                    color: kAccentGreen,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: kAccentGreen,
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
    );
  }

  // Reusable accordion list builder
  Widget _buildAccordionList(List<String> items) {
    return Container(
      padding: EdgeInsets.only(top: 6),
      child: Column(
        children:
            items.map((title) {
              return _buildAccordionItem(title);
            }).toList(),
      ),
    );
  }

  // Individual accordion item with dotted line separator
  Widget _buildAccordionItem(String title) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        colorScheme: ColorScheme.light(
          surfaceTint: Colors.transparent,
          primary: kAccentGreen,
        ),
      ),
      child: Column(
        children: [
          ExpansionTile(
            tilePadding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: EdgeInsets.only(left: 50, bottom: 16, right: 20),
            leading: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kAccentGreen, width: 3),
              ),
              child: Icon(
                Icons.add,
                color: kAccentGreen,
                size: 22,
                weight: 900,
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kAccentGreen,
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
          // Dotted line separator
          Container(
            width: double.infinity,
            height: 1,
            child: CustomPaint(
              painter: DottedLinePainter(color: kDottedLineColor),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for dotted line separators
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

// Search bar component
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    return Container(
      height: 57,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: kAccentGold, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 14 : 16.8,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF54555A),
              ),
              decoration: const InputDecoration(
                hintText: "Enter your occupation",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: kAccentGold, size: 28),
                contentPadding: EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              color: kAccentGold,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text(
                "Search",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
