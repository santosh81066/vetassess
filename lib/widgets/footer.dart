import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'HelpSection.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;

    return Column(
      children: [
        const HelpSection(),
        // Main Footer Section with columns
        Container(
          color: const Color(0xFF0D5257), // Dark Teal background
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: _getHorizontalPadding(screenWidth),
            vertical: _getVerticalPadding(screenWidth),
          ),
          child: _buildFooterContent(context, screenWidth, isDesktop, isTablet, isMobile),
        ),

        // VETASSESS Logo and Acknowledgment Section
        _buildLogoAndAcknowledgmentSection(context, screenWidth),

        // Bottom section with copyright and links
        _buildBottomSection(context, screenWidth, isMobile),
      ],
    );
  }

  double _getHorizontalPadding(double screenWidth) {
    if (screenWidth > 1200) return 80;
    if (screenWidth > 768) return 40;
    return 20;
  }

  double _getVerticalPadding(double screenWidth) {
    if (screenWidth > 768) return 40;
    return 20;
  }

  Widget _buildFooterContent(BuildContext context, double screenWidth, bool isDesktop, bool isTablet, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._getFooterSections().map((section) => Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: section,
          )),
          _ContactSection(isMobile: isMobile),
        ],
      );
    } else {
      return Wrap(
        spacing: isDesktop ? 30 : 20,
        runSpacing: isDesktop ? 30 : 20,
        alignment: WrapAlignment.spaceEvenly,
        children: [
          ..._getFooterSections(),
          _ContactSection(isMobile: isMobile),
        ],
      );
    }
  }

  List<Widget> _getFooterSections() {
    return [
      // Services column
      _FooterLinksSection(
        title: 'Services',
        links: const [
          'Skills Assessment for Migration',
          'Skills Assessment for Non-Migration',
          'Business and Industry',
          'Recognition of Prior Learning',
          'Skills Assessment Support',
        ],
      ),

      // Useful Links column
      _FooterLinksSection(
        title: 'Useful Links',
        links: const [
          'Trade Fact Sheets',
          'Professional Occupation Information Sheets',
          'Fees – Professional Occupations',
          'Required Documents',
          'Chinese Qualifications Verification services',
        ],
      ),

      // About Us column
      _FooterLinksSection(
        title: 'About Us',
        links: const [
          'About Us',
          'Industry Partners',
          'Refund Policy',
          'Complaints',
          'Feedback',
          'Customer services Charter',
          'Careers',
        ],
      ),

      // Resources column
      _FooterLinksSection(
        title: 'Resources',
        links: const [
          'Check my Occupation',
          'Guides & Fact Sheets',
          'News',
          'For Migration Specialists',
          'FAQs',
        ],
      ),

      // Business & Industry column
      _FooterLinksSection(
        title: 'Business & Industry',
        links: const [
          'For Business',
          'For Educators',
          'Online Learning',
          'Global Initiatives',
          'Industry Partners',
        ],
      ),
    ];
  }

  Widget _buildLogoAndAcknowledgmentSection(BuildContext context, double screenWidth) {
    final isMobile = screenWidth <= 768;
    
    return Container(
      color: const Color(0xFF0D5257),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(screenWidth),
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo section
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Image.asset(
              'assets/images/vetasses_logo.png',
              height: isMobile ? 80 : 120,
              width: isMobile ? 100 : 150,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: isMobile ? 80 : 120,
                  width: isMobile ? 100 : 150,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          
          // Aboriginal and Torres Strait Islander Flags
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Image.asset(
              'assets/images/dual_flags_r.png',
              height: isMobile ? 36 : 54,
              width: isMobile ? 116 : 174,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: isMobile ? 36 : 54,
                  width: isMobile ? 116 : 174,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),

          // Acknowledgment Text
          Text(
            'In the spirit of reconciliation VETASSESS acknowledges the Traditional Custodians of country throughout Australia and their '
            'connections to land, sea and community. We pay our respects to their Elders past and present and extend that respect to all '
            'Aboriginal and Torres Strait Islander peoples today.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 11 : 12,
              height: 1.4,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, double screenWidth, bool isMobile) {
    return Container(
      color: const Color(0xFF0D5257),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(screenWidth),
        vertical: 15,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Copyright 2025 VETASSESS. All rights reserved. RTO No. 21097',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: const [
                    _BottomLink('Disclaimer'),
                    _BottomLink('Privacy'),
                    _BottomLink('Accessibility'),
                    _BottomLink('Sitemap'),
                    _BottomLink('Website by Pixelstorm'),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Copyright 2025 VETASSESS. All rights reserved. RTO No. 21097',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Wrap(
                  spacing: 16,
                  children: const [
                    _BottomLink('Disclaimer'),
                    _BottomLink('Privacy'),
                    _BottomLink('Accessibility'),
                    _BottomLink('Sitemap'),
                    _BottomLink('Website by Pixelstorm'),
                  ],
                ),
              ],
            ),
    );
  }
}

class _FooterLinksSection extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterLinksSection({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;
    
    return SizedBox(
      width: isMobile ? double.infinity : _getSectionWidth(screenWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFFE9A72B), // Orange/Gold color
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          ...links.map(
            (link) => Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 8 : 12),
              child: InkWell(
                onTap: () {
                  // Add navigation logic here
                  print('Tapped on: $link');
                },
                child: Text(
                  link,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 13 : 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getSectionWidth(double screenWidth) {
    if (screenWidth > 1200) return 200;
    if (screenWidth > 768) return 180;
    return 160;
  }
}

class _ContactSection extends StatelessWidget {
  final bool isMobile;
  
  const _ContactSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox(
      width: isMobile ? double.infinity : _getSectionWidth(screenWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              color: const Color(0xFFE9A72B), // Orange/Gold color
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Govindapur,Pargi,Vikarabad,Purgi S.0,\n'
            'Pargi,Telangana,India,501501,\n'
            'Pargi,TELANGANA,PIN:501591'
            ,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 13 : 14,
              fontWeight: FontWeight.w300,
              height: 1.4,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          InkWell(
            onTap: () {
              // Add phone call functionality
              print('Call: 1300 VETASSESS');
            },
            child: Text(
              '1300 VETASSESS',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 13 : 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF00B2A9), // Teal underline
                decorationThickness: 2,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          SizedBox(
            height: isMobile ? 45 : 50,
            width: isMobile ? double.infinity : 150,
            child: ElevatedButton(
              onPressed: () {
                // Add contact navigation logic
                print('Contact Us button pressed');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA000),
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 14 : 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                "Contact Us",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          // Social Media Icons
          _buildSocialMediaIcons(isMobile),
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcons(bool isMobile) {
    final iconSize = isMobile ? 20.0 : 24.0;
    final spacing = isMobile ? 8.0 : 12.0;
    
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: [
        _SocialIcon(FontAwesomeIcons.facebook, iconSize, 'Facebook'),
        _SocialIcon(FontAwesomeIcons.linkedin, iconSize, 'LinkedIn'),
        _SocialIcon(FontAwesomeIcons.twitter, iconSize, 'Twitter'),
        _SocialIcon(FontAwesomeIcons.youtube, iconSize, 'YouTube'),
        _SocialIcon(FontAwesomeIcons.instagram, iconSize, 'Instagram'),
      ],
    );
  }

  double _getSectionWidth(double screenWidth) {
    if (screenWidth > 1200) return 200;
    if (screenWidth > 768) return 180;
    return 160;
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final String platform;

  const _SocialIcon(this.icon, this.size, this.platform);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add social media navigation logic
        print('Navigate to $platform');
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: FaIcon(
          icon,
          color: Colors.white,
          size: size,
        ),
      ),
    );
  }
}

class _BottomLink extends StatelessWidget {
  final String text;

  const _BottomLink(this.text);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add navigation logic
        print('Navigate to: $text');
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}