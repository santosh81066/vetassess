import 'package:flutter/material.dart';

class SkillsMatchSection extends StatelessWidget {
  const SkillsMatchSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size dimensions
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    final bool isMediumScreen = screenSize.width >= 600 && screenSize.width < 960;
    final bool isLargeScreen = screenSize.width >= 960;

    // Calculate responsive padding that decreases on smaller screens
    double horizontalPadding = isSmallScreen 
        ? 16 
        : isMediumScreen 
            ? screenSize.width * 0.05
            : screenSize.width * 0.08;

    final List<Map<String, dynamic>> cards = [
      {
        "image": "assets/images/trades_assessment.png",
        "title": "Am I eligible for a trades skilled migration assessment?",
        "description":
            "Check your visa subclass, occupation and other requirements before you begin.",
        "link": "Find out if you are eligible",
        "buttonIcon": Icons.arrow_forward,
      },
      {
        "image": "assets/images/professional_general.png",
        "title": "Am I eligible for a professional & general occupation?",
        "description":
            "Find out if your occupation is a professional or general occupation with VETASSESS.",
        "link": "Find out more",
        "buttonIcon": Icons.arrow_forward,
      },
      {
        "image": "assets/images/application_status.jpg",
        "title": "Can I view the status of my application?",
        "description":
            "Check the progress of your application via our online portal.",
        "link": "View your application status",
        "buttonIcon": Icons.arrow_forward,
      },
    ];

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: isSmallScreen ? 40 : 80),
          _buildResponsiveHeader(context),
          SizedBox(height: isSmallScreen ? 30 : 60),
          _buildResponsiveCardGrid(context, cards),
          SizedBox(height: isSmallScreen ? 30 : 50),
        ],
      ),
    );
  }

  Widget _buildResponsiveHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final titleFontSize = isSmallScreen ? 28.0 : 36.0;
    final textFontSize = isSmallScreen ? 14.0 : 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Match your skills and experience to an${isSmallScreen ? '' : '\nAustralian occupation.'}",
          style: TextStyle(
            fontSize: titleFontSize,
            color: const Color(0xFF00695C),
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Are you looking to move to Australia – either temporarily or permanently – and continue to work in your trade, profession or specialised occupation? VETASSESS can recognise and validate the skills, qualifications and experience you gained in your home country to give you the opportunity to continue your skilled career in Australia.",
          style: TextStyle(
            fontSize: textFontSize,
            color: const Color(0xFF54555A),
            fontWeight: FontWeight.w400,
            height: 1.6,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveCardGrid(BuildContext context, List<Map<String, dynamic>> cards) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the layout based on screen width
        final screenWidth = constraints.maxWidth;
        final isSmallScreen = screenWidth < 600;
        final isMediumScreen = screenWidth >= 600 && screenWidth < 960;

        // Calculate number of cards per row and spacing
        int crossAxisCount;
        double spacing;
        double cardHeight;

        if (isSmallScreen) {
          crossAxisCount = 1;
          spacing = 16;
          cardHeight = 420; // Shorter on mobile
        } else if (isMediumScreen) {
          crossAxisCount = 2;
          spacing = 20;
          cardHeight = 450;
        } else {
          crossAxisCount = 3;
          spacing = 24;
          cardHeight = 480;
        }

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards.map((card) {
            // Calculate card width based on available space
            double cardWidth = isSmallScreen
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
                aspectRatio: 16/9,
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