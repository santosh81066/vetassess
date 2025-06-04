import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/screens/employment.dart';
import 'package:vetassess/screens/licence.dart';
import 'package:vetassess/screens/tertiary_education.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

class AppliOptions extends StatelessWidget {
  const AppliOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Define responsive breakpoints
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    // Calculate responsive values
    final verticalPadding = _getVerticalPadding(
      screenHeight,
      isMobile,
      isTablet,
    );
    final cardSpacing = _getCardSpacing(isMobile, isTablet);
    final cardWidth = _getCardWidth(screenWidth, isMobile, isTablet);
    final cardHeight = _getCardHeight(screenHeight, isMobile, isTablet);

    return LoginPageLayout(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildOptionCard(
              title: 'Create a New Application',
              icon: Icons.add_box_outlined,
              onPressed: () {
                context.go('/appli_type');
              },
              color: const Color(0xFF006257),
              context: context,
              width: cardWidth,
              height: cardHeight,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            SizedBox(height: cardSpacing),
            _buildOptionCard(
              title: 'Continue Incomplete Application',
              icon: Icons.edit_note,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => TertiaryEducationForm(),
                //   ),
                // );
                context.go('/app_priority_form');
              },
              color: const Color(0xFF006257),
              context: context,
              width: cardWidth,
              height: cardHeight,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            SizedBox(height: cardSpacing),
            _buildOptionCard(
              title: 'View Submitted Applications',
              icon: Icons.description_outlined,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmploymentForm()),
                );
              },
              color: const Color(0xFF006257),
              context: context,
              width: cardWidth,
              height: cardHeight,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            SizedBox(height: cardSpacing),
            _buildOptionCard(
              title: 'Update my details',
              icon: Icons.person_outline,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LicenceForm()),
                );
              },
              color: const Color(0xFF006257),
              context: context,
              width: cardWidth,
              height: cardHeight,
              isMobile: isMobile,
              isTablet: isTablet,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    required double width,
    required double height,
    required bool isMobile,
    required bool isTablet,
  }) {
    List<String> words = title.split(' ');
    String firstPart = words.first;
    String remainingPart = words.skip(1).join(' ');

    // Responsive text and icon sizes
    final fontSize = _getFontSize(isMobile, isTablet);
    final iconSize = _getIconSize(isMobile, isTablet);
    final horizontalPadding = _getHorizontalPadding(isMobile, isTablet);
    final borderRadius = _getBorderRadius(isMobile, isTablet);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: '$firstPart ',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: remainingPart,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: isMobile ? 8 : 12),
            Icon(icon, color: Colors.white, size: iconSize),
          ],
        ),
      ),
    );
  }

  // Responsive helper methods
  double _getVerticalPadding(
    double screenHeight,
    bool isMobile,
    bool isTablet,
  ) {
    if (isMobile) {
      return screenHeight * 0.04; // 4% of screen height
    } else if (isTablet) {
      return screenHeight * 0.06; // 6% of screen height
    } else {
      return 50.0; // Original desktop value
    }
  }

  double _getCardSpacing(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 12.0;
    } else if (isTablet) {
      return 16.0;
    } else {
      return 20.0; // More spacing for desktop
    }
  }

  double _getCardWidth(double screenWidth, bool isMobile, bool isTablet) {
    if (isMobile) {
      return screenWidth * 0.9; // 90% of screen width for mobile
    } else if (isTablet) {
      return screenWidth * 0.7; // 70% of screen width for tablet
    } else {
      return screenWidth * 0.5; // 50% of screen width for desktop
    }
  }

  double _getCardHeight(double screenHeight, bool isMobile, bool isTablet) {
    if (isMobile) {
      return screenHeight * 0.12; // 12% of screen height
    } else if (isTablet) {
      return screenHeight * 0.10; // 10% of screen height
    } else {
      return 120.0; // Original desktop height
    }
  }

  double _getFontSize(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 18.0;
    } else {
      return 20.0; // Original desktop size
    }
  }

  double _getIconSize(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 28.0;
    } else if (isTablet) {
      return 30.0;
    } else {
      return 32.0; // Original desktop size
    }
  }

  double _getHorizontalPadding(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 20.0;
    } else {
      return 24.0; // More padding for desktop
    }
  }

  double _getBorderRadius(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 6.0;
    } else if (isTablet) {
      return 8.0;
    } else {
      return 10.0; // Slightly more rounded for desktop
    }
  }
}
