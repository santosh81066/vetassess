import 'package:flutter/material.dart';

class VetassessHeader extends StatelessWidget {
  const VetassessHeader({super.key});

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

        // Gray divider line
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey[300],
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
            errorBuilder: (context, error, stackTrace) {
              // Fallback logo design if image is not found
              return _buildFallbackLogo(logoSize);
            },
          ),
          SizedBox(height: spacing / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Electronic Document Upload to VETASSESS',
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
            errorBuilder: (context, error, stackTrace) {
              // Fallback logo design if image is not found
              return _buildFallbackLogo(logoSize);
            },
          ),
          SizedBox(width: spacing),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: isTablet ? 8 : 14),
              child: Text(
                'Electronic Document Upload to VETASSESS',
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

  Widget _buildFallbackLogo(double logoSize) {
    return Container(
      height: logoSize,
      width: logoSize * 2.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Icon(Icons.arrow_drop_up, color: Colors.teal, size: logoSize * 0.4),
                Icon(Icons.arrow_drop_down, color: Colors.orange, size: logoSize * 0.4),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            'VETASSESS',
            style: TextStyle(
              color: Colors.teal,
              fontSize: logoSize * 0.3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
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
      return 60.0;
    }
  }

  double _getResponsiveTitleSize(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 22.0;
    } else {
      return 30.0;
    }
  }

  double _getResponsiveSpacing(bool isMobile, bool isTablet) {
    if (isMobile) {
      return 16.0;
    } else if (isTablet) {
      return 28.0;
    } else {
      return 40.0;
    }
  }
}