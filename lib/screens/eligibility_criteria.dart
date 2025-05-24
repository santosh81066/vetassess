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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 768;

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(screenHeight, screenWidth, isSmallScreen),
          _buildBreadcrumbs(isSmallScreen),
          ..._buildProcessSteps(screenWidth, isSmallScreen),
          _buildAnnouncement(context),
          _buildGatherDocSection(isSmallScreen),
          _buildSearchSection(screenHeight, screenWidth, isSmallScreen),
          _buildFaqSection(isSmallScreen),
        ],
      ),
    );
  }

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
            width: isSmallScreen ? screenWidth * 0.9 : screenWidth * 0.66,
            padding: EdgeInsets.only(
              top: isSmallScreen ? 60 : 100,
              left: isSmallScreen ? 20 : 170,
              right: isSmallScreen ? 20 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSmallScreen
                      ? "Application process for a professional or general skills application"
                      : "Application process for a \nprofessional or general \nskills application",
                  style: TextStyle(
                    color: const Color(0xFFFFA000),
                    fontSize: isSmallScreen ? 28 : 42,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    height: isSmallScreen ? 1.2 : 1.0,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 20 : 30),
                Text(
                  isSmallScreen
                      ? "Start your migration journey by applying for a skills assessment for your professional occupation."
                      : "Start your migration journey by applying for a skills assessment for your professional \noccupation.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 14 : 16,
                    height: 1.5,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs(bool isSmallScreen) {
    const linkStyle = TextStyle(
      fontSize: 14,
      color: Color(0xFF0d5257),
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );

    final breadcrumbs = [
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

  List<Widget> _buildBreadcrumbItems(
    List<Map<String, String>> items,
    TextStyle linkStyle,
  ) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final isActive = item['isActive'] == 'true';

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

      if (i < items.length - 1) {
        widgets.add(const Text(' / ', style: TextStyle(color: Colors.grey)));
      }
    }
    return widgets;
  }

  List<Widget> _buildProcessSteps(double screenWidth, bool isSmallScreen) {
    const stepText =
        'We provide skills assessments \nfor the largest range of \noccupations in Australia.';
    const description =
        "The Australian Government has authorised us to provide skills assessments for 341 professional and other non-trade occupations. If you're a professional needing a skills assessment to migrate to Australia, we can offer you a service that understands and can assess your experience and qualifications.";

    final stepInfoColumn = Container(
      width: isSmallScreen ? screenWidth * 0.9 : screenWidth * 0.4,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepText,
            style: TextStyle(
              fontSize: isSmallScreen ? 24 : 32,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );

    final imageWidget = Image.asset(
      'assets/images/skiil_assesment_support.jpg',
      height: isSmallScreen ? 300 : 450,
      width: isSmallScreen ? screenWidth * 0.9 : 600,
      fit: BoxFit.cover,
    );

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
                  children: [
                    stepInfoColumn,
                    const SizedBox(height: 20),
                    imageWidget,
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [stepInfoColumn, imageWidget],
                ),
      ),
    ];
  }

  Widget _buildAnnouncement(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 24.0,
        vertical: 8.0,
      ),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 5,
          width: double.infinity,
          color: const Color(0xFFEEAA00),
        ),
        Container(
          color: const Color(0xFFFFF8F0),
          padding: const EdgeInsets.all(16.0),
          child: _buildAnnouncementContent(fontSize: 0.9),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(width: 5, color: const Color(0xFFEEAA00)),
          Expanded(
            child: Container(
              color: const Color(0xFFFFF8F0),
              padding: const EdgeInsets.all(24.0),
              child: _buildAnnouncementContent(fontSize: 1.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementContent({required double fontSize}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Announcements',
          style: TextStyle(
            fontSize: 28.0 * fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF006064),
          ),
        ),
        SizedBox(height: 24 * fontSize),
        Text(
          'Skills Assessments that are close to expiry',
          style: TextStyle(
            fontSize: 18.0 * fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF006064),
          ),
        ),
        SizedBox(height: 16 * fontSize),
        Text(
          'Applicants with a Skills Assessment that is close to expiring should consider applying for a renewal of their assessment at the same time as they apply for a state or territory migration program – or earlier. Each state and territory has its own criteria for applications and sometimes the timeframes are short. Applicants will be more likely to avoid disappointment if they apply for a renewal early rather than wait for an invitation from a state or territory.',
          style: TextStyle(
            fontSize: 16.0 * fontSize,
            height: 1.5,
            color: const Color(0xFF006064),
          ),
        ),
        SizedBox(height: 12 * fontSize),
        InkWell(
          onTap: () {},
          child: Text(
            'Find out how to renew your Skills Assessment before it expires here.',
            style: TextStyle(
              fontSize: 16.0 * fontSize,
              color: const Color.fromARGB(255, 5, 124, 128),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(height: 20 * fontSize),
        Text(
          'Skills assessment documents: professional and general occupations',
          style: TextStyle(
            fontSize: 18.0 * fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF006064),
          ),
        ),
        SizedBox(height: 16 * fontSize),
        Text(
          'Applicants are expected to provide all the documents required at the time they submit their application. We have changed our timeframes for applications that do not have complete documents. We will close incomplete applications that do not meet the deadline and there will be a fee to reopen the application. You can find out more here. It is important to ensure you lodge a complete set of required documents when you apply, and this will avoid delays with your application.',
          style: TextStyle(
            fontSize: 16.0 * fontSize,
            height: 1.5,
            color: const Color(0xFF006064),
          ),
        ),
      ],
    );
  }

  Widget _buildGatherDocSection(bool isSmallScreen) {
    const documentItems = [
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
                  const SizedBox(height: 30),
                  _buildAccordionList(documentItems),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: _buildGatherDocTitle(),
                    ),
                  ),
                  Expanded(flex: 2, child: _buildAccordionList(documentItems)),
                ],
              ),
    );
  }

  Widget _buildGatherDocTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
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

  Widget _buildSearchSection(
    double screenHeight,
    double screenWidth,
    bool isSmallScreen,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100, top: 50),
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
              SizedBox(
                width: isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.46,
                child: const _SearchBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqSection(bool isSmallScreen) {
    const faqItems = [
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
                  const SizedBox(height: 30),
                  _buildAccordionList(faqItems),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: _buildFaqTitle()),
                  Expanded(flex: 2, child: _buildAccordionList(faqItems)),
                ],
              ),
    );
  }

  Widget _buildFaqTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Explore FAQs",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: kAccentGreen,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                const Text(
                  "View all",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kAccentGreen,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: kAccentGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
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

  Widget _buildAccordionList(List<String> items) {
    return Container(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        children: items.map((title) => _buildAccordionItem(title)).toList(),
      ),
    );
  }

  Widget _buildAccordionItem(String title) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        colorScheme: const ColorScheme.light(
          surfaceTint: Colors.transparent,
          primary: kAccentGreen,
        ),
      ),
      child: Column(
        children: [
          ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 0,
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.only(
              left: 50,
              bottom: 16,
              right: 20,
            ),
            leading: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kAccentGreen, width: 3),
              ),
              child: const Icon(
                Icons.add,
                color: kAccentGreen,
                size: 22,
                weight: 900,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kAccentGreen,
              ),
            ),
            trailing: const SizedBox.shrink(),
            children: const [
              Text(
                'This is the answer to the FAQ question.',
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
            ],
          ),
          SizedBox(
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

class DottedLinePainter extends CustomPainter {
  final Color color;
  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;

    const dashWidth = 3.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

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
