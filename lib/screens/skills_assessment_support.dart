import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

class SkillsAssessmentSupport extends StatelessWidget {
  const SkillsAssessmentSupport({super.key});
  static const Color tealColor = Color(0xFF00565B);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isLargeScreen = width > 1100;
    // Get screen size dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    final bool isMediumScreen =
        screenSize.width >= 600 && screenSize.width < 960;

    // Calculate responsive padding that decreases on smaller screens
    double horizontalPadding =
        isSmallScreen
            ? 16
            : isMediumScreen
            ? screenSize.width * 0.075
            : screenSize.width * 0.1;

    final List<Map<String, dynamic>> cards = [
      {
        "image": "assets/images/trades_assessment.png",
        "title": "For Applicants",
        "description":
            "This service provides tailored information via a 30-minute phone consultation about the VETASSESS Skills Assessment criteria for professional occupational classifications. We provide separate services for migration agents/lawyers and for applicants.",
        "link": "Learn More",
        "buttonIcon": Icons.arrow_forward,
      },
      {
        "image": "assets/images/professional_general.png",
        "title": "For Migration Agents",
        "description":
            "The Skills Assessment Support (SAS) Consultation Service for Migration Agents and practising legal professionals provides a customised 30-minute guided phone discussion about the Skills Assessment process and criteria that apply to professional occupational classifications that we assess.",
        "link": "Learn More",
        "buttonIcon": Icons.arrow_forward,
      },
      {
        "image": "assets/images/application_status.jpg",
        "title": "Document Checks",
        "description":
            "This service checks whether the documentation you are planning to provide for a skills assessment will be sufficient for a Skills Assessment application.",
        "link": "Learn More",
        "buttonIcon": Icons.arrow_forward,
      },
    ];

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(screenHeight, screenWidth),
          _buildBreadcrumbs(),
          ..._buildProcessSteps(screenWidth),
          Container(
            color: Color(0xfff2f2f2),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isSmallScreen ? 40 : 80),
                _buildResponsiveHeader(context),
                SizedBox(height: isSmallScreen ? 15 : 30),
                _buildResponsiveCardGrid(context, cards),
                SizedBox(height: isSmallScreen ? 40 : 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //hero
  Widget _buildHeaderBanner(double screenHeight, double screenWidth) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.45,
      decoration: const BoxDecoration(color: tealColor),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Image.asset(
              'assets/images/internal_page_banner.png',
              height: screenHeight * 0.45,
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
                    "Skills Assessment Support",
                    style: TextStyle(
                      color: Color(0xFFFFA000),
                      fontSize: 42,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Skills Assessment Support for Professional and General Occupations",
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
          Text(
            'Skills Assessment Support',
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
        'step': 'Skills Assessment Support',
        //'title': 'Choose a professional occupation',
        'description':
            'Skills Assessment Support (SAS) services are for migration agents, legal practitioners and prospective applicants who are yet to submit their Skills Assessment application for a general or professional occupation.',
        'anzscoInfo':
            'The SAS services aim to provide additional and tailored support to applicants, agents and lawyers in submitting a sufficiently complete/ ready to assess skills assessment application.',
        'image': 'assets/images/skiil_assesment_support.jpg',
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
            SizedBox(height: 20),
            // const Text(
            //   'Information on the ANZSCO description',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xFF006064),
            //   ),
            // ),
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
          vertical: screenWidth * 0.07,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      );
    }).toList();
  }
}

Widget _buildResponsiveHeader(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmallScreen = screenWidth < 600;
  final titleFontSize = isSmallScreen ? 28.0 : 36.0;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "There are different SAS services available:",
        style: TextStyle(
          fontSize: titleFontSize,
          color: const Color(0xFF00695C),
          fontWeight: FontWeight.w800,
          height: 1.2,
          letterSpacing: -0.5,
        ),
      ),
    ],
  );
}

Widget _buildResponsiveCardGrid(
  BuildContext context,
  List<Map<String, dynamic>> cards,
) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Determine the layout based on screen width
      final screenWidth = constraints.maxWidth;
      final isSmallScreen = screenWidth < 600;
      final isMediumScreen = screenWidth >= 600 && screenWidth < 960;
      final screenHeight = MediaQuery.of(context).size.height;
      // Calculate number of cards per row and spacing
      int crossAxisCount;
      double spacing;
      double cardHeight;

      if (isSmallScreen) {
        crossAxisCount = 1;
        spacing = 16;
        cardHeight = screenHeight * 0.8; // Shorter on mobile
      } else if (isMediumScreen) {
        crossAxisCount = 2;
        spacing = 20;
        cardHeight = screenHeight * 0.8;
      } else {
        crossAxisCount = 3;
        spacing = 24;
        cardHeight = screenHeight * 0.8;
      }

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children:
            cards.map((card) {
              // Calculate card width based on available space
              double cardWidth =
                  isSmallScreen
                      ? constraints.maxWidth
                      : isMediumScreen
                      ? (constraints.maxWidth - spacing) / 2
                      : (constraints.maxWidth - (spacing * 2)) / 3;

              return Container(
                width: cardWidth,
                height: cardHeight,
                margin: const EdgeInsets.only(bottom: 8),
                child: _CardItem(
                  image: card["image"],
                  title: card["title"],
                  description: card["description"],
                  link: card["link"],
                  buttonIcon: card["buttonIcon"],
                  isSmallScreen: isSmallScreen,
                ),
              );
            }).toList(),
      );
    },
  );
}

class _CardItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String link;
  final IconData buttonIcon;
  final bool isSmallScreen;

  const _CardItem({
    required this.image,
    required this.title,
    required this.description,
    required this.link,
    required this.buttonIcon,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    // Adjust font sizes based on screen size
    final titleFontSize = isSmallScreen ? 18.0 : 20.0;
    final descFontSize = isSmallScreen ? 14.0 : 16.0;
    final linkFontSize = isSmallScreen ? 14.0 : 16.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with green line
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  color: const Color(0xFF008996), // Green line below the image
                ),
              ),
            ],
          ),
          // Content section with flexible layout
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title - handle line breaks based on space
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00695C),
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: descFontSize,
                      color: const Color(0xFF54555A),
                      height: 1.4,
                      letterSpacing: 0.1,
                    ),
                  ),
                  // Push the gesture detector to the bottom
                  const Spacer(),
                  // Link with arrow
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              link,
                              style: TextStyle(
                                fontSize: linkFontSize,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF00695C),
                              ),
                            ),
                            Container(
                              height: 2,
                              width: link.length * (isSmallScreen ? 6.5 : 7.3),
                              color: const Color(0xFF00695C),
                              margin: const EdgeInsets.only(top: 1),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(isSmallScreen ? 5 : 7),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF00695C),
                          ),
                          child: Icon(
                            buttonIcon,
                            color: Colors.white,
                            size: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ],
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
