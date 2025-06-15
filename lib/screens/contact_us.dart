import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

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
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: _getContentHorizontalPadding(screenWidth),
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header text
                Text(
                  'Choose how you would like to contact us from\nthe options below.',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(screenWidth, 36),
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D7A7B),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 40),

                // Main content - responsive layout
                _buildResponsiveContent(screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveContent(double screenWidth) {
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    if (isMobile) {
      return Column(
        children: [
          _buildEnquiriesSection(),
          const SizedBox(height: 40),
          _buildCurrentApplicationsSection(),
          const SizedBox(height: 40),
          _buildBusinessEnquiriesSection(),
        ],
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildEnquiriesSection()),
              const SizedBox(width: 30),
              Expanded(child: _buildCurrentApplicationsSection()),
            ],
          ),
          const SizedBox(height: 40),
          _buildBusinessEnquiriesSection(),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildEnquiriesSection()),
          const SizedBox(width: 60),
          Expanded(child: _buildCurrentApplicationsSection()),
          const SizedBox(width: 60),
          Expanded(child: _buildBusinessEnquiriesSection()),
        ],
      );
    }
  }

  Widget _buildEnquiriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enquiries',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D7A7B),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Monday to Friday, 9am to 5pm AEDT\nexcept Public Holidays',
          style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.4),
        ),
        const SizedBox(height: 24),

        // Phone number with icon
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2D7A7B),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.phone, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF00BCD4), width: 2),
                      ),
                    ),
                    child: const Text(
                      '1300 VETASSESS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D7A7B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF00BCD4), width: 2),
                      ),
                    ),
                    child: const Text(
                      '(1300 838 277)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D7A7B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),

        // International section
        const Text(
          'International',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D7A7B),
          ),
        ),
        const SizedBox(height: 16),

        // International phone
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2D7A7B),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.phone, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF00BCD4), width: 2),
                  ),
                ),
                child: const Text(
                  '+61 3 9655 4801',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D7A7B),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Webchat info
        const Text(
          'Webchat available Monday to Friday,\n9am to 4:30pm AEDT except Public\nHolidays',
          style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.4),
        ),
        const SizedBox(height: 20),

        // Chat button
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2D7A7B),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF00BCD4), width: 2),
                  ),
                ),
                child: const Text(
                  'Chat to VETASSESS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D7A7B),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrentApplicationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'For current applications',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D7A7B),
          ),
        ),
        const SizedBox(height: 40),

        // Option 1
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFFFB74D), width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Check your status online',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D7A7B),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF2D7A7B),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),

        // Option 2
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFFFB74D), width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'View current processing times',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D7A7B),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF2D7A7B),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),

        // Option 3
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'View FAQs page',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D7A7B),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFF2D7A7B),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessEnquiriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Business & industry\nenquiries',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D7A7B),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'If you are a business, government or\neducational customer or have an inquiry.',
          style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.4),
        ),
        const SizedBox(height: 24),

        // Business phone
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2D7A7B),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.phone, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF00BCD4), width: 2),
                  ),
                ),
                child: const Text(
                  '+61 3 9655 4801',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D7A7B),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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
                    "Contact us",
                    style: TextStyle(
                      color: Color(0xFFFFA000),
                      fontSize: _getResponsiveFontSize(screenWidth, 42),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "All office opening hours are Monday - Friday, 9:00 a.m to 5:00 p.m, except \nPublic Holidays.",
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
          Text('Contact', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  // Responsive helper methods
  double _getResponsiveHorizontalPadding(double screenWidth) {
    if (screenWidth < 768) return 16.0; // Mobile
    if (screenWidth < 1024) return 32.0; // Tablet
    return 50.0; // Desktop
  }

  double _getContentHorizontalPadding(double screenWidth) {
    if (screenWidth < 768) return 16.0; // Mobile
    if (screenWidth < 1024) return 32.0; // Tablet
    return 150.0; // Desktop
  }

  double _getResponsiveFontSize(double screenWidth, double baseFontSize) {
    if (screenWidth < 768) return baseFontSize * 0.8; // Mobile
    if (screenWidth < 1024) return baseFontSize * 0.9; // Tablet
    return baseFontSize; // Desktop
  }

  double _getResponsiveSpacing(double screenHeight, double baseSpacing) {
    if (screenHeight < 600) return baseSpacing * 0.6;
    if (screenHeight < 800) return baseSpacing * 0.8;
    return baseSpacing;
  }
}
