import 'package:flutter/material.dart';

class HowToPreparePage extends StatelessWidget {
  const HowToPreparePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 150),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          const Text(
            'How to prepare your application',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Color(0xFF00695C),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          // Tabs
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Color(0xFF00695C),
                  unselectedLabelColor: Colors.black45,
                  indicatorColor: Color(0xFFFFA000),
                  indicatorWeight: 4,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(text: 'Professional Occupations'),
                    Tab(text: 'Trade Occupations'),
                  ],
                ),
                const SizedBox(height: 48),
                // Tab content
                SizedBox(
                  height: 400, // Slightly taller to accommodate larger boxes
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
        const SizedBox(height: 60), // Increased spacing to match image
        // Steps with connected lines - using Row with mainAxisAlignment
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Changed to center to align the dots
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
        const SizedBox(height: 60), // Increased spacing to match image
        // Steps with connected lines - similar structure
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center, // Changed to center to align the dots
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
          // Number box - LARGER SIZE
          Container(
            width: 70, // Increased from 50
            height: 70, // Increased from 50
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 38, // Increased from 32
                fontWeight: FontWeight.w900,
                color: Color(0xFF00695C),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 20, // Increased from 18
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
                        color: Color(0xFF0288D1),
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
    return SizedBox(
      width: 60,
      child: Center(
        child: CustomPaint(painter: _DottedLinePainter(), size: Size(60, 2)),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Color(0xFFFFA000)
          ..strokeWidth =
              3 // Slightly thicker to match image
          ..strokeCap = StrokeCap.round;

    final dashWidth = 4.0; // Longer dashes to match image
    final dashSpace = 6.0; // More space between dashes
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
