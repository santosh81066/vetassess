import 'package:flutter/material.dart';

class HowToPreparePage extends StatelessWidget {
  const HowToPreparePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 20 : 40,
        horizontal: _getHorizontalPadding(screenWidth),
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            'How to prepare your application',
            style: TextStyle(
              fontSize: isMobile ? 24 : (isTablet ? 30 : 36),
              fontWeight: FontWeight.w700,
              color: Color(0xFF00695C),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 24 : 48),
          // Tabs
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Color(0xFF00695C),
                  unselectedLabelColor: Colors.black45,
                  indicatorColor: Color(0xFFFFA000),
                  indicatorWeight: 4,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    fontSize: isMobile ? 16 : 20,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: isMobile ? 16 : 20,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: 'Professional Occupations'),
                    Tab(text: 'Trade Occupations'),
                  ],
                ),
                SizedBox(height: isMobile ? 24 : 48),
                // Tab content
                SizedBox(
                  height: isMobile ? 600 : (isTablet ? 500 : 400),
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

  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth < 768) {
      return 16; // Mobile
    } else if (screenWidth < 1024) {
      return 40; // Tablet
    } else if (screenWidth < 1440) {
      return 80; // Small desktop
    } else {
      return 150; // Large desktop
    }
  }
}

class _ProfessionalOccupationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description text
          Text(
            "If you're a professional choosing to migrate to Australia, chances are you're likely to be "
            "assessed by us. We assess 361 different professional occupations, assessing your skills, "
            "experience and qualifications.",
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 30 : 60),
          // Steps - responsive layout
          _ResponsiveStepsLayout(
            steps: [
              _StepData(
                number: "1",
                title: "Find",
                description: "Find the VETASSESS occupation that most closely fits your skills and experience.",
              ),
              _StepData(
                number: "2",
                title: "Match",
                description: "Match your skills and experience to your chosen occupation.",
              ),
              _StepData(
                number: "3",
                title: "Prepare",
                description: "Get ready to apply by preparing all the information and documents you need.",
              ),
              _StepData(
                number: "4",
                title: "Apply",
                description: "Apply online when you're ready. If you're still unsure,",
                linkText: "skills assessment support",
                linkDescription: "is available when you need it.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TradeOccupationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content for Trade Occupations tab
          Text(
            "If you're a tradesperson, your skills and experience will be assessed by someone who has worked in your trade and understands your skills and qualifications. VETASSESS is Australia's leading assessment body for trades and we can assess 27 different trade occupations.",
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          SizedBox(height: isMobile ? 30 : 60),
          // Steps - responsive layout
          _ResponsiveStepsLayout(
            steps: [
              _StepData(
                number: "1",
                title: "Find",
                description: "Find the VETASSESS occupation that most closely fits your skills and experience.",
              ),
              _StepData(
                number: "2",
                title: "Match",
                description: "Match your skills and experience to your chosen occupation.",
              ),
              _StepData(
                number: "3",
                title: "Prepare",
                description: "Get ready to apply by preparing all the information and documents you need.",
              ),
              _StepData(
                number: "4",
                title: "Apply",
                description: "Apply online when you're ready. If you're still unsure,",
                linkText: "skills assessment support",
                linkDescription: "is available when you need it.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepData {
  final String number;
  final String title;
  final String description;
  final String? linkText;
  final String? linkDescription;

  _StepData({
    required this.number,
    required this.title,
    required this.description,
    this.linkText,
    this.linkDescription,
  });
}

class _ResponsiveStepsLayout extends StatelessWidget {
  final List<_StepData> steps;

  const _ResponsiveStepsLayout({required this.steps});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    if (isMobile) {
      // Mobile: Vertical layout
      return Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            _StepColumn(
              number: steps[i].number,
              title: steps[i].title,
              description: steps[i].description,
              linkText: steps[i].linkText,
              linkDescription: steps[i].linkDescription,
              isMobile: true,
            ),
            if (i < steps.length - 1) ...[
              const SizedBox(height: 20),
              _VerticalDottedLine(),
              const SizedBox(height: 20),
            ],
          ],
        ],
      );
    } else {
      // Tablet and Desktop: Horizontal layout
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < steps.length; i++) ...[
              _StepColumn(
                number: steps[i].number,
                title: steps[i].title,
                description: steps[i].description,
                linkText: steps[i].linkText,
                linkDescription: steps[i].linkDescription,
                isMobile: false,
                isTablet: isTablet,
              ),
              if (i < steps.length - 1) _DottedLine(),
            ],
          ],
        ),
      );
    }
  }
}

class _StepColumn extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final String? linkText;
  final String? linkDescription;
  final bool isMobile;
  final bool isTablet;

  const _StepColumn({
    required this.number,
    required this.title,
    required this.description,
    this.linkText,
    this.linkDescription,
    this.isMobile = false,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final boxSize = isMobile ? 60.0 : (isTablet ? 65.0 : 70.0);
    final numberFontSize = isMobile ? 32.0 : (isTablet ? 35.0 : 38.0);
    final titleFontSize = isMobile ? 18.0 : (isTablet ? 19.0 : 20.0);
    final descriptionFontSize = isMobile ? 13.0 : 14.0;
    final columnWidth = isMobile ? double.infinity : (isTablet ? 160.0 : 180.0);

    return SizedBox(
      width: columnWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Number box
          Container(
            width: boxSize,
            height: boxSize,
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
                fontSize: numberFontSize,
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
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: Color(0xFF00695C),
            ),
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: descriptionFontSize,
              color: Colors.black87,
              height: 1.4,
            ),
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
                        fontSize: descriptionFontSize,
                        color: Color(0xFF0288D1),
                        decoration: TextDecoration.underline,
                        height: 1.4,
                      ),
                    ),
                    if (linkDescription != null)
                      TextSpan(
                        text: " $linkDescription",
                        style: TextStyle(
                          fontSize: descriptionFontSize,
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

class _VerticalDottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Center(
        child: CustomPaint(painter: _VerticalDottedLinePainter(), size: Size(2, 30)),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFFFA000)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final dashWidth = 4.0;
    final dashSpace = 6.0;
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

class _VerticalDottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFFFA000)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final dashHeight = 4.0;
    final dashSpace = 6.0;
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}