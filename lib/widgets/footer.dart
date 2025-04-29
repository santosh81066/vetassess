import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Footer Section
        Container(
        color: const Color(0xFF0D5257),
    // Dark Teal background
          padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 45),
          child: Column(
            children: [
              Wrap(
                spacing: 50,
                runSpacing: 32,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  _FooterLinksSection(
                    title: 'Services',
                    links: [
                      'Skills Assessment for Migration',
                      'Skills Assessment for Non-Migration',
                      'Business and Industry',
                      'Recognition of Prior Learning',
                      'Skills Assessment Support',
                    ],
                  ),
                  _FooterLinksSection(
                    title: 'Useful Links',
                    links: [
                      'Trade Fact Sheets',
                      'Professional Occupation Information Sheets',
                      'Fees – Professional Occupations',
                      'Required Documents',
                      'Chinese Qualifications Verification Service',
                    ],
                  ),
                  _FooterLinksSection(
                    title: 'About Us',
                    links: [
                      'About Us',
                      'Industry Partners',
                      'Refund Policy',
                      'Complaints',
                      'Feedback',
                      'Customer Service Charter',
                      'Careers',
                    ],
                  ),
                  _FooterLinksSection(
                    title: 'Resources',
                    links: [
                      'Check my Occupation',
                      'Guides & Fact Sheets',
                      'News',
                      'For Migration Specialists',
                      'FAQs',
                    ],
                  ),
                  _FooterLinksSection(
                    title: 'Business & Industry',
                    links: [
                      'For Business',
                      'For Educators',
                      'Online Learning',
                      'Global Initiatives',
                      'Industry Partners',
                    ],
                  ),
                  _ContactSection(),
                ],
              ),
              const SizedBox(height: 48),
              _VetassessLogoSection(),
            ],
          ),
        ),

        // Bottom Footer
        Container(
        color: const Color(0xFF0D5257),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Divider(color: Colors.teal.shade800, thickness: 1),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    '© ${DateTime.now().year} Go Code Designers. All rights reserved. RTO No. 1760',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
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
            ],
          ),
        ),
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
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              link,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          )),
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
          const Text('Contact Us',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Level 1,\n85 Cremorne Street\nCremorne, Victoria 3121\nAustralia',
              style: TextStyle(color: Colors.white, fontSize: 13)),
          const SizedBox(height: 16),
          const Text('1300 VETASSESS',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Contact Us', style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.facebook, color: Colors.white),
              SizedBox(width: 8),
              Icon(Icons.facebook_rounded, color: Colors.white),
              SizedBox(width: 8),
              Icon(Icons.youtube_searched_for, color: Colors.white),
              SizedBox(width: 8),
              Icon(Icons.camera_alt, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

class _VetassessLogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        const Text(
          'VETASSESS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'In the spirit of reconciliation VETASSESS acknowledges the Traditional Custodians of country throughout Australia and their\nconnections to land, sea and community. We pay our respects to their Elders past and present and extend that respect to all\nAboriginal and Torres Strait Islander peoples today.',
          style: TextStyle(color: Colors.white70, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
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
