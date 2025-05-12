import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'HelpSection.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HelpSection(),
        // Main Footer Section with columns
        Container(
          color: const Color(0xFF0D5257), // Dark Teal background
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.spaceEvenly,
            children: [
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
                  'Chinese Qualifications Verification Service',
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
                  'Customer Service Charter',
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

              // Contact Us section
              _ContactSection(),
            ],
          ),
        ),

        // VETASSESS Logo and Acknowledgment Section
        Container(
          color: const Color(0xFF0D5257),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Image.asset(
                    'assets/images/vetasses_logo.png',
                    height: 120,
                    width: 150,
                  ),
                ),
              ),
              // Aboriginal and Torres Strait Islander Flags
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/dual_flags_r.png',
                    height: 54,
                    width: 174,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const SizedBox(height: 15),

              /* Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Image.asset(
                    'assets/images/uk_flag.png',
                    height: 100,
                    width: 120,
                  ),
                ),
              ),*/
              // Acknowledgment Text
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'In the spirit of reconciliation VETASSESS acknowledges the Traditional Custodians of country throughout Australia and their\n'
                  'connections to land, sea and community. We pay our respects to their Elders past and present and extend that respect to all\n'
                  'Aboriginal and Torres Strait Islander peoples today.',

                  style: TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: const Color(0xFF0D5257),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Copyright 2025 VETASSESS. All rights reserved. RTO No. 21097',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Row(
                children: const [
                  _BottomLink('Disclaimer'),
                  SizedBox(width: 16),
                  _BottomLink('Privacy'),
                  SizedBox(width: 16),
                  _BottomLink('Accessibility'),
                  SizedBox(width: 16),
                  _BottomLink('Sitemap'),
                  SizedBox(width: 16),
                  _BottomLink('Website by Pixelstorm'),
                ],
              ),
            ],
          ),
        ),

        // ISO certifications at bottom right
      ],
    );
  }
}

class _FooterLinksSection extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterLinksSection({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFE9A72B), // Orange/Gold color
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...links.map(
            (link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                link,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              color: Color(0xFFE9A72B), // Orange/Gold color
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Level 1,\n'
            '85 Cremorne Street\n'
            'Cremorne, Victoria 3121\n'
            'Australia',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w100,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '1300 VETASSESS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF00B2A9), // Teal underline
              decorationThickness: 2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 50,
            width: 150,
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
                "Contact Us",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: const [
              FaIcon(FontAwesomeIcons.facebook, color: Colors.white, size: 24),
              SizedBox(width: 12),
              FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 24),
              SizedBox(width: 12),
              FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 24),
              SizedBox(width: 12),
              FaIcon(FontAwesomeIcons.youtube, color: Colors.white, size: 24),
              SizedBox(width: 12),
              FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomLink extends StatelessWidget {
  final String text;

  const _BottomLink(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 12,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
