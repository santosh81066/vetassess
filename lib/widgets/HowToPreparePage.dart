import 'package:flutter/material.dart';

class HowToPreparePage extends StatelessWidget {
  const HowToPreparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          const Text(
            'How to prepare your application',
            style: TextStyle(
              fontSize: 32, // Larger font size to match image
              fontWeight: FontWeight.w700,
              color: Color(0xFF00695C), // Darker teal color from image
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48), // More spacing to match image
          // Tabs
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Color(0xFF00695C),
                  unselectedLabelColor: Colors.black45,
                  indicatorColor: Color(0xFFFFA000), // Amber/orange color
                  indicatorWeight: 3,
                  indicatorSize:
                      TabBarIndicatorSize.tab, // Match image indicator size
                  labelStyle: TextStyle(
                    fontSize: 18, // Larger text to match image
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 18, // Larger text to match image
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(text: 'Professional Occupations'),
                    Tab(text: 'Trade Occupations'),
                  ],
                ),
                const SizedBox(height: 48), // More spacing to match image
                // Tab content
                SizedBox(
                  height:
                      370, // Set a fixed height for the tab content to match image
                  child: TabBarView(
                    children: [
                      // Professional Occupations Tab
                      _ProfessionalOccupationsContent(),

                      // Trade Occupations Tab
                      _TradeOccupationsContent(),
                    ],
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

class _ProfessionalOccupationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description text
        Text(
          "If you're a professional choosing to migrate to Australia, chances are you're likely to be "
          "assessed by us. We assess 361 different professional occupations, assessing your skills, "
          "experience and qualifications.",
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 48), // More spacing to match image
        // Steps
        // Using SizedBox to constrain width like in the image
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step 1
              _StepColumn(
                number: "1",
                title: "Find",
                description:
                    "Find the VETASSESS occupation that most closely fits your skills and experience.",
              ),

              // Dotted line 1
              _DottedLine(),

              // Step 2
              _StepColumn(
                number: "2",
                title: "Match",
                description:
                    "Match your skills and experience to your chosen occupation.",
              ),

              // Dotted line 2
              _DottedLine(),

              // Step 3
              _StepColumn(
                number: "3",
                title: "Prepare",
                description:
                    "Get ready to apply by preparing all the information and documents you need.",
              ),

              // Dotted line 3
              _DottedLine(),

              // Step 4
              _StepColumn(
                number: "4",
                title: "Apply",
                description:
                    "Apply online when you're ready. If you're still unsure,",
                linkText: "skills assessment support",
                linkDescription: "is available when you need it.",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TradeOccupationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Content for Trade Occupations tab
        Text(
          "If you're a tradesperson, your skills and experience will be assessed by someone who has worked in your trade and understands your skills and qualifications. VETASSESS is Australia's leading assessment body for trades and we can assess 27 different trade occupations.",
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 48), // More spacing to match image
        // Steps would go here - similar structure to Professional tab
        // Not shown in the image so not implemented here
      ],
    );
  }
}

class _StepColumn extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final String? linkText;
  final String? linkDescription;

  const _StepColumn({
    required this.number,
    required this.title,
    required this.description,
    this.linkText,
    this.linkDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180, // Fixed width to match spacing in image
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Number box
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 24, // Larger text for number
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 18, // Larger text for title
              fontWeight: FontWeight.w700,
              color: Color(0xFF00695C),
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
            textAlign: TextAlign.center,
          ),

          // Link text if provided
          if (linkText != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: linkText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(
                          0xFF0288D1,
                        ), // Blue link color to match image
                        decoration: TextDecoration.underline,
                        height: 1.4,
                      ),
                    ),
                    if (linkDescription != null)
                      TextSpan(
                        text: " $linkDescription",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.4,
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
}

class _DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, // Wider to match image
      height: 20,
      margin: EdgeInsets.only(
        top: 25,
      ), // More top margin to match image alignment
      child: CustomPaint(
        painter: _DottedLinePainter(),
        size: Size(40, 2), // Explicit size to match image
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Color(0xFFFFA000) // Amber/orange color to match image
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;

    final dashWidth = 5.0; // Longer dashes to match image
    final dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
