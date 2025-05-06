import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart'; // optional if using go_router

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768;

    return Stack(
      children: [
        // Background color
        Container(color: const Color(0xFF0F5D60), height: 500), // adjust height

        // Background image (angled overlay)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/images/block-bg.svg',
            fit: BoxFit.cover,
            height: 250,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "We're here to help",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HelpCard(
                    iconAsset: 'assets/icons/icon-logo.svg',
                    title: 'Contact us',
                    description: 'Ask a question or find more information.',
                    buttonText: 'Send Enquiry',
                    onPressed: () {
                      context.go('/contact-us');
                    },
                  ),
                  const SizedBox(width: 24, height: 24),
                  _HelpCard(
                    iconAsset: 'assets/icons/icon-logo_0.svg',
                    title: 'Call our office',
                    description: 'Speak to our friendly customer support team.',
                    buttonText: 'Call 1300 838 277',
                    onPressed: () {
                      // Call link
                      // You could use url_launcher if needed
                    },
                  ),
                  const SizedBox(width: 24, height: 24),
                  _HelpCard(
                    iconAsset: 'assets/icons/icon-logo_1.svg',
                    title: 'Email us',
                    description: 'Send us your question or ask for more information.',
                    buttonText: 'Email Us',
                    onPressed: () {
                      // Email link
                    },
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

class _HelpCard extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const _HelpCard({
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(iconAsset, height: 32, width: 32),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF004D40),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA000),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
