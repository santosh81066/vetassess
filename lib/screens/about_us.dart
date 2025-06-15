import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  static const Color tealColor = Color(0xFF00565B);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(screenHeight, screenWidth),
          _buildBreadcrumb(screenWidth),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: _getResponsiveVerticalPadding(screenWidth, 40),
              horizontal: _getResponsiveContentPadding(screenWidth),
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main heading
                Text(
                  'VETASSESS is authorised by the Australian Government to assess more trade, professional and other occupations than anyone else.',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(screenWidth, 36),
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2B7A78),
                    height: 1.3,
                    letterSpacing: -0.5,
                  ),
                ),

                SizedBox(height: _getResponsiveSpacing(screenWidth, 32)),

                // First paragraph
                Text(
                  'As a global business, we\'re known and recognised for our expertise in assessments, built on more than 25 years of experience. Our dedicated team assesses the qualifications and work experience of prospective migrants, and supports individuals\' applications for employment, course entry and industry membership in Australia.',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(screenWidth, 16),
                    color: Color(0xFF666666),
                    height: 1.6,
                    letterSpacing: 0.1,
                  ),
                ),

                SizedBox(height: _getResponsiveSpacing(screenWidth, 24)),

                // Second paragraph
                Text(
                  'We also apply our expertise to assess skills for industry organisations, and consult to governments and government agencies internationally on education and training initiatives.',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(screenWidth, 16),
                    color: Color(0xFF666666),
                    height: 1.6,
                    letterSpacing: 0.1,
                  ),
                ),

                SizedBox(height: _getResponsiveSpacing(screenWidth, 80)),

                // "Get to know the VETASSESS team" heading
                Center(
                  child: Text(
                    'Get to know the VETASSESS team',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _getResponsiveFontSize(screenWidth, 32),
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2B7A78),
                      letterSpacing: -0.3,
                    ),
                  ),
                ),

                SizedBox(height: _getResponsiveSpacing(screenWidth, 60)),

                // Statistics row - responsive layout
                _buildStatisticsSection(screenWidth),

                SizedBox(height: _getResponsiveSpacing(screenWidth, 40)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(double screenWidth) {
    final isMobile = screenWidth < 768;

    if (isMobile) {
      // Stack statistics vertically on mobile
      return Column(
        children: [
          _buildStatisticItem('30+', 'Countries represented'),
          SizedBox(height: _getResponsiveSpacing(screenWidth, 40)),
          _buildStatisticItem('50%', 'Speak more than one language.'),
          SizedBox(height: _getResponsiveSpacing(screenWidth, 40)),
          _buildStatisticItem(
            '100%',
            'Trade assessors have all worked in their trade.',
          ),
        ],
      );
    } else {
      // Keep horizontal layout for tablet and desktop
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildStatisticItem('30+', 'Countries represented')),
          Expanded(
            child: _buildStatisticItem('50%', 'Speak more than one language.'),
          ),
          Expanded(
            child: _buildStatisticItem(
              '100%',
              'Trade assessors have all worked in their trade.',
            ),
          ),
        ],
      );
    }
  }

  Widget _buildStatisticItem(String number, String description) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return Column(
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(screenWidth, 72),
                fontWeight: FontWeight.w700,
                color: Color(0xFF17A2B8),
                height: 1.0,
              ),
            ),
            SizedBox(height: _getResponsiveSpacing(screenWidth, 16)),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(screenWidth, 18),
                color: Color(0xFF2B7A78),
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeaderBanner(double screenHeight, double screenWidth) {
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isMobile = screenWidth < 768;

    return Container(
      width: screenWidth,
      height: screenHeight * (isMobile ? 0.35 : 0.45),
      decoration: const BoxDecoration(color: tealColor),
      child: Stack(
        children: [
          if (!isMobile)
            Positioned(
              right: 0,
              child: Image.asset(
                'assets/images/internal_page_banner.png',
                height: screenHeight * (isMobile ? 0.35 : 0.45),
                fit: BoxFit.fitHeight,
              ),
            ),
          Container(
            width: isMobile ? screenWidth * 0.9 : screenWidth * 0.66,
            padding: EdgeInsets.only(
              top: _getResponsiveSpacing(screenHeight, 100),
              left: _getResponsiveHorizontalPadding(screenWidth),
            ),
            child: Align(
              alignment: isMobile ? Alignment.center : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment:
                    isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                children: [
                  Text(
                    "About us",
                    style: TextStyle(
                      color: Color(0xFFFFA000),
                      fontSize: _getResponsiveFontSize(screenWidth, 42),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Meet Australia's largest skills assessment provider.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _getResponsiveFontSize(screenWidth, 16),
                      height: 1.5,
                      letterSpacing: 0.3,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: _getResponsiveHorizontalPadding(screenWidth),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Home',
              style: TextStyle(
                color: Color(0xFF0d5257),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Text(' / ', style: TextStyle(color: Colors.grey)),
          Text('About Us', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  // Enhanced responsive helper methods
  double _getResponsiveHorizontalPadding(double screenWidth) {
    if (screenWidth < 768) return 16.0; // Mobile
    if (screenWidth < 1024) return 32.0; // Tablet
    return 50.0; // Desktop
  }

  double _getResponsiveContentPadding(double screenWidth) {
    if (screenWidth < 768) return 20.0; // Mobile
    if (screenWidth < 1024) return 60.0; // Tablet
    return 150.0; // Desktop
  }

  double _getResponsiveVerticalPadding(double screenWidth, double basePadding) {
    if (screenWidth < 768) return basePadding * 0.6; // Mobile
    if (screenWidth < 1024) return basePadding * 0.8; // Tablet
    return basePadding; // Desktop
  }

  double _getResponsiveSpacing(double screenWidth, double baseSpacing) {
    if (screenWidth < 768) return baseSpacing * 0.6; // Mobile
    if (screenWidth < 1024) return baseSpacing * 0.8; // Tablet
    return baseSpacing; // Desktop
  }

  double _getResponsiveFontSize(double screenWidth, double baseFontSize) {
    if (screenWidth < 768)
      return baseFontSize * 0.75; // Mobile - reduced more for better fit
    if (screenWidth < 1024) return baseFontSize * 0.9; // Tablet
    return baseFontSize; // Desktop
  }
}
