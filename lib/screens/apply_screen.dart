import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vetassess/theme.dart';
import '../widgets/BasePageLayout.dart';

class ApplyNowScreen extends StatelessWidget {
  const ApplyNowScreen({super.key});
  static const tealColor = Color(0xFF00565B);

  @override
  Widget build(BuildContext context) {
    // Check if screen is small for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final screenHeight = MediaQuery.of(context).size.height;

    return BasePageLayout(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderBanner(screenHeight, screenWidth),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 40.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Before you apply',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: AppColors.color2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Description text
                    Container(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Text(
                        'There are different application processes for skills assessments depending on the visa you\'re applying '
                        'for and your occupation. Take the time to explore our website and understand which application '
                        'process you need to follow before you begin.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 64),
                    // Three columns of content
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (isSmallScreen) {
                          // Stack columns vertically on small screens
                          return Column(
                            children: [
                              _buildInfoColumn(
                                'GET TO KNOW OCCUPATION\nREQUIREMENTS',
                                'Each VETASSESS occupation has its own specific qualifications and employment experience that you\'ll need to match in order to get your skills assessed. Search for your occupation to find out what requirements you\'ll need to meet.',
                              ),
                              const SizedBox(height: 32),
                              _buildInfoColumn(
                                'GATHER THE DOCUMENTS YOU NEED',
                                'It\'s important to make sure you have all the right documents, in the right format, ready for upload before you apply. This can help to avoid delays during the application process.',
                              ),
                              const SizedBox(height: 32),
                              _buildInfoColumn(
                                'EXPLORE PRIORITY PROCESSING',
                                'Priority Processing is a services that fast tracks application assessments but is only available for professional and general occupations. To use this services, you\'ll need to apply for it before you lodge a skills assessment application.',
                              ),
                            ],
                          );
                        } else {
                          // Arrange columns horizontally on larger screens
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _buildInfoColumn(
                                  'GET TO KNOW OCCUPATION\nREQUIREMENTS',
                                  'Each VETASSESS occupation has its own specific qualifications and employment experience that you\'ll need to match in order to get your skills assessed. Search for your occupation to find out what requirements you\'ll need to meet.',
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildInfoColumn(
                                  'GATHER THE DOCUMENTS YOU NEED',
                                  'It\'s important to make sure you have all the right documents, in the right format, ready for upload before you apply. This can help to avoid delays during the application process.',
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: _buildInfoColumn(
                                  'EXPLORE PRIORITY PROCESSING',
                                  'Priority Processing is a services that fast tracks application assessments but is only available for professional and general occupations. To use this services, you\'ll need to apply for it before you lodge a skills assessment application.',
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(height: 60),
                    _buildTradesBanner(screenHeight),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBanner(double screenHeight, double screenWidth) {
    final bool isSmallScreen = screenWidth < 600;
    final bool isMediumScreen = screenWidth >= 600 && screenWidth < 960;

    return Container(
      width: screenWidth,
      height: isSmallScreen ? screenHeight * 0.35 : screenHeight * 0.45,
      decoration: const BoxDecoration(color: tealColor),
      child: Stack(
        children: [
          // Background image - responsive positioning
          if (!isSmallScreen)
            Positioned(
              right: 0,
              child: Image.asset(
                'assets/images/internal_page_banner.png',
                height:
                    isSmallScreen ? screenHeight * 0.35 : screenHeight * 0.45,
                fit: BoxFit.fitHeight,
              ),
            ),
          // Content container - responsive layout
          Container(
            width: isSmallScreen ? screenWidth : screenWidth * 0.66,
            padding: EdgeInsets.only(
              top:
                  isSmallScreen
                      ? 40
                      : isMediumScreen
                      ? 60
                      : 100,
              left:
                  isSmallScreen
                      ? 20
                      : isMediumScreen
                      ? 40
                      : 170,
              right: isSmallScreen ? 20 : 0,
            ),
            child: Align(
              alignment:
                  isSmallScreen ? Alignment.center : Alignment.centerLeft,
              child: Column(
                crossAxisAlignment:
                    isSmallScreen
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Apply Now",
                    textAlign:
                        isSmallScreen ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFFFFA000),
                      fontSize:
                          isSmallScreen
                              ? 28
                              : isMediumScreen
                              ? 36
                              : 42,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 20 : 30),
                  Text(
                    "What you need to know to apply for a skills assessment with VETASSESS.",
                    textAlign:
                        isSmallScreen ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 14 : 16,
                      height: 1.5,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String description) {
    return Column(
      children: [
        // Logo image without container
        SvgPicture.asset(
          'assets/images/icon-logo_3.svg',
          width: 34,
          height: 34,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
        // Title text
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.color2,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        // Description text
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildTradesBanner(double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.30,
      decoration: const BoxDecoration(color: Color(0xFF0d5257)),
      child: Stack(
        children: [
          Positioned(
            right: 0.95,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/vet.svg',
              width: screenHeight * 0.1,
              height: screenHeight * 0.3,
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side: Title and subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Start Your Application and Apply Now',
                        style: TextStyle(
                          color: Color(0xFFFFA000),
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  // Right side: Button
                  SizedBox(
                    height: 60,
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA000),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text(
                        "Apply Online",
                        style: TextStyle(color: Colors.black),
                      ),
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
