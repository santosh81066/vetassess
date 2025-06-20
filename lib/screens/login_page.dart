import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../widgets/BasePageLayout.dart';
import '../widgets/HelpSection.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          _buildMainContent(context, screenWidth, screenHeight),
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
          Text('Login', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _getResponsiveHorizontalPadding(screenWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: _getResponsiveSpacing(screenHeight, 100),
              bottom: _getResponsiveSpacing(screenHeight, 50),
            ),
            child: Text(
              'You can Apply below or log in to review current \napplications',
              style: TextStyle(
                fontSize: _getResponsiveFontSize(screenWidth, 32),
                fontWeight: FontWeight.w700,
                color: Color(0xFF0A5A5A),
              ),
            ),
          ),
          _buildSectionHeader('Skills assessment for migration', screenWidth),
          _buildTableStructure([
            _buildAssessmentRow(
              context: context,
              screenWidth: screenWidth,
              title:
                  'Skills assessment for \nprofessional and general \noccupations',
              links: [
                LinkItem(
                  text: 'Check your occupation',
                  hasArrow: true,
                  onTap: () {
                    context.go('/maintenance');
                  },
                ),
                LinkItem(
                  text: 'Fees',
                  hasArrow: true,
                  onTap: () {
                    context.go('/fee_screen');
                  },
                ),
                LinkItem(
                  text: 'Supporting documents',
                  hasArrow: true,
                  onTap: () {
                    // Add navigation for supporting documents
                    context.go('/eligibility_criteria');
                  },
                ),
              ],
              hasReadyButton: true,
              hasLoginButton: true,
            ),
            _buildAssessmentRow(
              context: context,
              screenWidth: screenWidth,
              title: 'Skill assessment for trade \noccupations',
              links: [
                LinkItem(
                  text: 'Check your occupation',
                  hasArrow: true,
                  onTap: () {
                    context.go('/maintenance');
                  },
                ),
                LinkItem(
                  text: 'Fees',
                  hasArrow: true,
                  onTap: () {
                    context.go('/fee_screen');
                  },
                ),
                LinkItem(
                  text: 'Am I eligible',
                  hasArrow: true,
                  onTap: () {
                    context.go('/eligibility_criteria');
                  },
                ),
              ],
              hasReadyButton: true,
              hasLoginButton: true,
            ),
            _buildAssessmentRow(
              context: context,
              screenWidth: screenWidth,
              title:
                  'Skill assessment support (for \nprofessional and general \noccupations)',
              links: [
                LinkItem(
                  text: 'How to apply',
                  hasArrow: true,
                  onTap: () {
                    context.go('/skills_assess_support');
                  },
                ),
              ],
              hasReadyButton: true,
              hasLoginButton: true,
            ),
            _buildAssessmentRow(
              context: context,
              screenWidth: screenWidth,
              title: 'Chinese Qualifications \nVerification',
              links: [
                LinkItem(
                  text: 'Fees',
                  hasArrow: true,
                  onTap: () {
                    context.go('/fee_screen');
                  },
                ),
                LinkItem(
                  text: 'Supporting documents',
                  hasArrow: true,
                  onTap: () {
                    context.go('/eligibility_criteria');
                  },
                ),
              ],
              hasReadyButton: true,
              hasLoginButton: true,
            ),
            _buildAssessmentRow(
              context: context,
              screenWidth: screenWidth,
              title: 'Australian Technical \nCompetencies Statement',
              links: [],
              hasReadyButton: true,
              hasLoginButton: false,
            ),
          ]),
          SizedBox(
            height: _getResponsiveSpacing(screenHeight, screenHeight / 6),
          ),
          _buildSectionHeader(
            'Qualifications and skills recognition (non migration assessment)',
            screenWidth,
          ),
          _buildTableStructure([
            _buildAssessmentRow(
              context: context,
              screenWidth: screenWidth,
              title: 'Psychotherapy and counselling qualifications assessment',
              links: [
                LinkItem(
                  text: 'Fees',
                  hasArrow: true,
                  onTap: () {
                    context.go('/fee_screen');
                  },
                ),
                LinkItem(
                  text: 'Supporting documents',
                  hasArrow: true,
                  onTap: () {
                    context.go('/eligibility_criteria');
                  },
                ),
              ],
              hasReadyButton: true,
              hasLoginButton: true,
            ),
            _buildAssessmentRow(
              context: context,
              screenWidth: screenWidth,
              title:
                  'Financial Adviser Standards and Ethics Authority qualifications comparison to the AQF',
              links: [
                LinkItem(
                  text: 'Fees',
                  hasArrow: true,
                  onTap: () {
                    context.go('/fee_screen');
                  },
                ),
                LinkItem(
                  text: 'Supporting documents',
                  hasArrow: true,
                  onTap: () {
                    context.go('/eligibility_criteria');
                  },
                ),
              ],
              hasReadyButton: true,
              hasLoginButton: true,
            ),
          ]),
          SizedBox(
            height: _getResponsiveSpacing(screenHeight, screenHeight / 6),
          ),
        ],
      ),
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
                    "Login",
                    style: TextStyle(
                      color: Color(0xFFFFA000),
                      fontSize: _getResponsiveFontSize(screenWidth, 42),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Ready To Start Your Application Process?",
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

  // Responsive helper methods
  double _getResponsiveHorizontalPadding(double screenWidth) {
    if (screenWidth < 768) return 16.0; // Mobile
    if (screenWidth < 1024) return 32.0; // Tablet
    return 50.0; // Desktop
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

  bool _isMobile(double screenWidth) => screenWidth < 768;
  bool _isTablet(double screenWidth) =>
      screenWidth >= 768 && screenWidth < 1024;
}

Widget _buildSectionHeader(String text, double screenWidth) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      vertical: 26,
      horizontal: screenWidth < 768 ? 16 : 24,
    ),
    color: Color(0xFF0A5A5A),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth < 768 ? 18 : 20,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget _buildTableStructure(List<Widget> rows) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Colors.grey.shade300),
        right: BorderSide(color: Colors.grey.shade300),
        bottom: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Column(children: rows),
  );
}

Widget _buildAssessmentRow({
  required BuildContext context,
  required double screenWidth,
  required String title,
  required List<LinkItem> links,
  required bool hasReadyButton,
  required bool hasLoginButton,
}) {
  final isMobile = screenWidth < 768;
  final isTablet = screenWidth >= 768 && screenWidth < 1024;

  return Container(
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade300)),
    ),
    child:
        isMobile
            ? _buildMobileLayout(
              context,
              title,
              links,
              hasReadyButton,
              hasLoginButton,
              screenWidth,
            )
            : _buildDesktopLayout(
              context,
              title,
              links,
              hasReadyButton,
              hasLoginButton,
              screenWidth,
            ),
  );
}

Widget _buildMobileLayout(
  BuildContext context,
  String title,
  List<LinkItem> links,
  bool hasReadyButton,
  bool hasLoginButton,
  double screenWidth,
) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0A5A5A),
          ),
        ),
        SizedBox(height: 16),

        // Links
        if (links.isNotEmpty) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: links.map((link) => _buildLink(link)).toList(),
          ),
          SizedBox(height: 16),
        ],

        // Buttons
        Column(
          children: [
            if (hasReadyButton)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/login'),
                  label: Flexible(
                    child: Text(
                      "I'm ready to apply",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF5A623),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    elevation: 0,
                  ),
                  icon: Icon(Icons.edit, color: Colors.black, size: 18),
                ),
              ),
            if (hasReadyButton && hasLoginButton) SizedBox(height: 12),
            if (hasLoginButton)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  label: Flexible(
                    child: Text(
                      'Agent login',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFF0A5A5A),
                    side: BorderSide(color: Color(0xFF0A5A5A), width: 2),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  icon: Icon(Icons.login, color: Color(0xFF0A5A5A), size: 18),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDesktopLayout(
  BuildContext context,
  String title,
  List<LinkItem> links,
  bool hasReadyButton,
  bool hasLoginButton,
  double screenWidth,
) {
  final isTablet = screenWidth >= 768 && screenWidth < 1024;

  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left column - Title
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 16.0 : 24.0,
              vertical: 30,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 18 : 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0A5A5A),
              ),
            ),
          ),
        ),

        // Middle column - Links
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(isTablet ? 16.0 : 24.0),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey.shade300),
                right: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: links.map((link) => _buildLink(link)).toList(),
            ),
          ),
        ),

        // Right column - Buttons
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.only(
              top: isTablet ? 50 : 70,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child:
                isTablet
                    ? Column(
                      children: [
                        if (hasReadyButton)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => context.go('/login'),
                              label: Text(
                                "I'm ready to apply",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF5A623),
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                elevation: 0,
                              ),
                              icon: Icon(Icons.edit, color: Colors.black),
                            ),
                          ),
                        if (hasReadyButton && hasLoginButton)
                          SizedBox(height: 12),
                        if (hasLoginButton)
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              label: Text(
                                'Agent login',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Color(0xFF0A5A5A),
                                side: BorderSide(
                                  color: Color(0xFF0A5A5A),
                                  width: 2,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              icon: Icon(Icons.login, color: Color(0xFF0A5A5A)),
                            ),
                          ),
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasReadyButton)
                          ElevatedButton.icon(
                            onPressed: () => context.go('/login'),
                            label: Text(
                              "I'm ready to apply",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF5A623),
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              minimumSize: Size(190, 66),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              elevation: 0,
                            ),
                            icon: Icon(Icons.edit, color: Colors.black),
                          ),
                        SizedBox(width: 12),
                        if (hasLoginButton)
                          OutlinedButton.icon(
                            onPressed: () {},
                            label: Text(
                              'Agent login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF0A5A5A),
                              side: BorderSide(
                                color: Color(0xFF0A5A5A),
                                width: 4,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              minimumSize: Size(190, 66),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            icon: Icon(Icons.login, color: Color(0xFF0A5A5A)),
                          ),
                      ],
                    ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLink(LinkItem link) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: InkWell(
      onTap: link.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              link.text,
              style: TextStyle(
                color: Color(0xFF0A5A5A),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          if (link.hasArrow)
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.arrow_forward,
                size: 18,
                color: Color(0xFF0A5A5A),
              ),
            ),
        ],
      ),
    ),
  );
}

// Updated LinkItem class to include onTap callback
class LinkItem {
  final String text;
  final bool hasArrow;
  final VoidCallback? onTap;

  LinkItem({required this.text, required this.hasArrow, this.onTap});
}
