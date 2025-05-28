import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1024;

    // Calculate responsive padding
    double getLeftPadding() {
      if (isSmallScreen) {
        return 16.0; // Fixed padding for mobile
      } else if (isMediumScreen) {
        return screenWidth * 0.05; // 5% of screen width for tablet
      } else {
        return screenWidth * 0.1; // 10% of screen width for desktop
      }
    }

    // Calculate responsive font size
    double getFontSize() {
      if (isSmallScreen) {
        return 12.0;
      } else {
        return 14.0;
      }
    }

    return Column(
      children: [
        Container(height: 2, color: Colors.teal[700]),
        Container(
          padding: EdgeInsets.only(
            top: isSmallScreen ? 8 : 10,
            bottom: isSmallScreen ? 8 : 10,
            left: getLeftPadding(),
            right: isSmallScreen ? 16.0 : 0,
          ),
          width: screenWidth,
          color: Colors.white,
          child: isSmallScreen
              ? _buildMobileLayout(getFontSize())
              : _buildDesktopLayout(getFontSize()),
        ),
      ],
    );
  }

  // Mobile layout - vertical stacking
  Widget _buildMobileLayout(double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Privacy',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Text(
              ' | ',
              style: TextStyle(color: Colors.black87, fontSize: fontSize),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Disclaimer',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Copyright © 2025 VETASSESS. All rights reserved.',
          style: TextStyle(
            color: Colors.black87,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  // Desktop/Tablet layout - horizontal layout
  Widget _buildDesktopLayout(double fontSize) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Privacy',
            style: TextStyle(
              color: Colors.brown,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Text(
          ' | ',
          style: TextStyle(color: Colors.black87, fontSize: fontSize),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Disclaimer',
            style: TextStyle(
              color: Colors.brown,
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Text(
          ' | ',
          style: TextStyle(color: Colors.black87, fontSize: fontSize),
        ),
        Text(
          'Copyright © 2025 VETASSESS. All rights reserved.',
          style: TextStyle(color: Colors.black87, fontSize: fontSize),
        ),
      ],
    );
  }
}