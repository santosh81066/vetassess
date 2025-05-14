import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

class EligibilityCriteria extends StatelessWidget {
  const EligibilityCriteria({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const Color tealColor = Color(0xFF00565B);
    const Color yellowColor = Color(0xFFF9C700);
    const Color dottedLineColor = Color(0xFF008996);

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(screenHeight, screenWidth),
          _buildBreadcrumbs(),
          ..._buildProcessSteps(screenWidth),
          _buildGatherDocSection(),
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 100, top: 50),
              child: Container(
                width: screenWidth * 0.6,

                height: screenHeight * 0.33,
                color: tealColor,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Search For Your Occupation And Check \nEligibility Here",
                      style: TextStyle(
                        color: Color(0xFFFFA000),
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: screenWidth * 0.46,
                      child: const _SearchBar(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildFaqSection(),
        ],
      ),
    );
  }
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
                  "Am I Eligible to Apply with \nMy Professional \nOccupation?",
                  style: TextStyle(
                    color: Color(0xFFFFA000),
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    height: 1.28,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Assessments are comprehensive, modern and completed by experts in the field.",
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
          'Am I eligible to apply?',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    ),
  );
}

List<Widget> _buildProcessSteps(double screenWidth) {
  // Define all step data in a list
  final List<Map<String, dynamic>> stepsData = [
    {
      'step':
          'We provide skills assessments \nfor the largest range of \noccupations in Australia.',
      //'title': 'Choose a professional occupation',
      'description':
          "The Australian Government has authorised us to provide skills assessments for 341 professional and other non-trade occupations. If you're a professional needing a skills assessment to migrate to Australia, we can offer you a service that understands and can assess your experience and qualifications.",
      'image': 'assets/images/skiil_assesment_support.jpg',
      'imageOnRight': true,
    },
  ];

  // Generate widgets for each step
  return stepsData.asMap().entries.map((entry) {
    final int index = entry.key;
    final Map<String, dynamic> stepData = entry.value;

    final Widget stepInfoColumn = Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepData['step'],
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF006064),
            ),
          ),
          SizedBox(height: 20),

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
      height: 450,
      width: 600,
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
        vertical: screenWidth * 0.06,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowChildren,
      ),
    );
  }).toList();
}

Widget _buildGatherDocSection() {
  // Extended list of FAQ items
  final List<String> actualFaqTitles = [
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
    padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 60),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column - Title and View all button
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gather the documents you will need",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0A594C),
                    height: 1.3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Column(
                    children: [
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
            ),
          ),
        ),

        // Right column - FAQ accordions
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(top: 6),
            child: Column(
              children:
                  actualFaqTitles.map((title) {
                    return Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                        colorScheme: ColorScheme.light(
                          surfaceTint: Colors.transparent,
                          primary: Color(0xFF0A594C),
                        ),
                      ),
                      child: Column(
                        children: [
                          ExpansionTile(
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
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF0A594C),
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Color(0xFF0A594C),
                                size: 22,
                                weight: 900,
                              ),
                            ),
                            title: Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
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
                          Container(
                            width: double.infinity,
                            height: 1,
                            child: CustomPaint(
                              painter: DottedLinePainter(
                                color: Color(0xFF008996),
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
  );
}

Widget _buildFaqSection() {
  // Actual FAQ items from the image
  final List<String> actualFaqTitles = [
    'What if I do not meet the requirements for my nominated occupation?',
    'How long will it take to process my application?',
    'What if my occupation is not listed?',
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 60),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column - Title and View all button
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Explore FAQs",
                  style: TextStyle(
                    fontSize: 32,
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
        ),

        // Right column - FAQ accordions
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(top: 6),
            child: Column(
              children:
                  actualFaqTitles.map((title) {
                    return Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                        colorScheme: ColorScheme.light(
                          surfaceTint: Colors.transparent,
                          primary: Color(0xFF0A594C),
                        ),
                      ),
                      child: Column(
                        children: [
                          ExpansionTile(
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
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF0A594C),
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Color(0xFF0A594C),
                                size: 22,
                                weight: 900,
                              ),
                            ),
                            title: Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
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
                          Container(
                            width: double.infinity,
                            height: 1,
                            child: CustomPaint(
                              painter: DottedLinePainter(
                                color: Color(0xFF008996),
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
        border: Border.all(color: const Color(0xFFFFA000), width: 2),
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
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFFFA000),
                  size: 28,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFFA000),
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
