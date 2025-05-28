import 'package:flutter/material.dart';

import '../screens/application_forms/appli_personal_details.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    
    // Define breakpoints
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;
    
    // Responsive values
    final headerHeight = _getResponsiveHeight(screenHeight, isMobile, isTablet);
    final logoSize = _getResponsiveLogoSize(isMobile, isTablet);
    final titleFontSize = _getResponsiveTitleSize(isMobile, isTablet);
    final horizontalPadding = _getResponsivePadding(screenWidth, isMobile, isTablet);
    final spacingBetweenElements = _getResponsiveSpacing(isMobile, isTablet);
    
    return Column(
      children: [
        // Header with logo and title
        Container(
          height: headerHeight,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: _buildHeaderContent(
            context,
            isMobile,
            isTablet,
            logoSize,
            titleFontSize,
            spacingBetweenElements,
          ),
        ),

        // Teal border line
        Container(
          height: 2,
          width: double.infinity,
          color: Colors.teal[700],
        ),

        // Navigation bar
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: _buildNavigationBar(context, isMobile, isTablet),
        ),
      ],
    );
  }

  Widget _buildHeaderContent(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    double logoSize,
    double titleFontSize,
    double spacing,
  ) {
    if (isMobile) {
      // Stack layout for mobile
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/vetassess_logo.png',
            height: logoSize,
            fit: BoxFit.contain,
          ),
          SizedBox(height: spacing / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Skills Recognition General Occupations',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFontSize,
                color: Colors.teal[800],
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                height: 1.2,
              ),
            ),
          ),
        ],
      );
    } else {
      // Row layout for tablet and desktop
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/vetassess_logo.png',
            height: logoSize,
            fit: BoxFit.contain,
          ),
          SizedBox(width: spacing),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: isTablet ? 8 : 14),
              child: Text(
                'Skills Recognition General Occupations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize,
                  color: Colors.teal[800],
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildNavigationBar(BuildContext context, bool isMobile, bool isTablet) {
    final iconSize = isMobile ? 20.0 : 24.0;
    final textSize = isMobile ? 12.0 : 14.0;
    
    if (isMobile) {
      // More compact navigation for mobile
      return SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.orange[900],
                size: iconSize,
              ),
              onPressed: () {},
            ),
            for (final item in ['Contact', 'Links', 'FAQs'])
              TextButton(
                onPressed: () {},
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.orange[900],
                    fontSize: textSize,
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      // Original navigation for tablet and desktop
      return SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.orange[900],
                size: iconSize,
              ),
              onPressed: () {},
            ),
            for (final item in ['Contact us', 'Useful links', 'FAQs'])
              TextButton(
                onPressed: () {},
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.orange[900],
                    fontSize: textSize,
                  ),
                ),
              ),
            SizedBox(width: isTablet ? 50 : 175),
          ],
        ),
      );
    }
  }

  double _getResponsiveHeight(double screenHeight, bool isMobile, bool isTablet) {
    if (isMobile) {
      return screenHeight * 0.15; // 15% of screen height
    } else if (isTablet) {
      return screenHeight * 0.12; // 12% of screen height
    } else {
      return screenHeight / 6; // Original desktop size
    }
  }

  double _getResponsiveLogoSize(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 40.0;
    } else if (isTablet) {
      return 50.0;
    } else {
      return 60.0; // Original size
    }
  }

  double _getResponsiveTitleSize(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 22.0;
    } else {
      return 30.0; // Original size
    }
  }

  double _getResponsivePadding(double screenWidth, bool isMobile, bool isTablet) {
    if (isMobile) {
      return 8.0;
    } else if (isTablet) {
      return 16.0;
    } else {
      return 24.0; // Original padding
    }
  }

  double _getResponsiveSpacing(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 28.0;
    } else {
      return 40.0; // Original spacing
    }
  }
}