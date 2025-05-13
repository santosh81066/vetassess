import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart'; // optional if using go_router

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the layout should be responsive
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 768;
    
    return Container(
      color: const Color(0xFF0F5D60), // Teal background color matching screenshot
      child: Stack(
        children: [
             
    // Background image 2 - top right (block-bg.svg)
    Positioned(
      right: 0.95,
      bottom: 0,
      child: SvgPicture.asset(
        'assets/images/block-bg.svg',
        width: MediaQuery.of(context).size.width * 1.0, // Responsive width
        fit: BoxFit.fitHeight,
      ),
    ),
            // Background image
     Positioned(
      left: 0,
      bottom: 0,
      child: Image.asset(
        'assets/images/Vector1.png',
        width: MediaQuery.of(context).size.width * 0.80, // Responsive width
        fit: BoxFit.contain,
      ),
    ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 100,
              horizontal: 50, // More padding on desktop
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "We're here to help",
                  textAlign: TextAlign.left, // Left aligned as in screenshot
                  style: TextStyle(
                    fontSize: 30, // Larger font size matching screenshot
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: isDesktop ? 60 : 40),
                
                // Cards layout - horizontal on desktop, vertical on mobile
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (isDesktop) {
                      // Desktop: Horizontal layout
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildHelpCards(constraints.maxWidth / 3 - 16),
                      );
                    } else {
                      // Mobile: Vertical layout
                      return Column(
                        children: _buildHelpCards(width - 32)
                            .expand((card) => [card, const SizedBox(height: 16)])
                            .toList()
                            ..removeLast(), // Remove the last spacer
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHelpCards(double width) {
    return [
      _HelpCard(
        width: width,
        iconAsset: 'assets/images/icon-logo_3.svg',
        title: 'Contact us',
        description: 'Ask a question or find more information.',
        buttonText: 'Send Enquiry',
        onPressed: () {
          // Navigation action
        },
      ),
      _HelpCard(
        width: width,
        iconAsset: 'assets/images/icon-logo_3.svg',
        title: 'Call our office',
        description: 'Speak to our friendly customer support team.',
        buttonText: 'Call 1300 838 277',
        onPressed: () {
          // Call action
        },
      ),
      _HelpCard(
        width: width,
        iconAsset: 'assets/images/icon-logo_3.svg',
        title: 'Email us',
        description: 'Send us your question or ask for more information.',
        buttonText: 'Email Us',
        onPressed: () {
          // Email action
        },
      ),
    ];
  }
}

class _HelpCard extends StatelessWidget {
  final double width;
  final String iconAsset;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const _HelpCard({
    required this.width,
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: 300,
        child: Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Square corners as in screenshot
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  iconAsset,
                  height: 36,
                  width: 36,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F5D60), // Teal color for the title
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
               SizedBox(height: title == 'Contact us' ? 60 : 40),
                SizedBox(
                  width: 160,
                  height: 50,
                  child: ElevatedButton(
                    
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: const Color(0xFFFFA000), // Amber button color
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // Square button
                      ),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}