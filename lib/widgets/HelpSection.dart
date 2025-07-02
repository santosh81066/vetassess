import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart'; // optional if using go_router

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    
    // Better responsive breakpoints
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1024;
    final bool isDesktop = width >= 1024;
    
    return Container(
      color: const Color(0xFF0F5D60),
      child: Stack(
        children: [
          // Background image 2 - top right (block-bg.svg)
          Positioned(
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/block-bg.svg',
              width: width * (isMobile ? 0.8 : 1.0),
              fit: BoxFit.fitHeight,
            ),
          ),
          
          // Background image - left bottom
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/Vector1.png',
              width: width * (isMobile ? 0.6 : 0.8),
              fit: BoxFit.contain,
            ),
          ),

          // Content with proper responsive layout
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 40 : (isTablet ? 60 : 80),
                horizontal: isMobile ? 16 : (isTablet ? 32 : 50),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "We're here to help",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: isMobile ? 30 : (isTablet ? 40 : 50)),
                  
                  // Responsive cards layout
                  _buildResponsiveCardsLayout(context, width, isMobile, isTablet, isDesktop),
                  
                  // Add bottom padding to prevent overflow
                  SizedBox(height: isMobile ? 40 : 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveCardsLayout(BuildContext context, double width, bool isMobile, bool isTablet, bool isDesktop) {
    if (isMobile) {
      // Mobile: Single column layout
      return Column(
        children: _buildHelpCards(width - 32, isMobile, isTablet)
            .map((card) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: card,
                ))
            .toList(),
      );
    } else if (isTablet) {
      // Tablet: Two columns layout
      final cards = _buildHelpCards((width - 64) / 2 - 8, isMobile, isTablet);
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 16),
              Expanded(child: cards[1]),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: cards[2]),
              const Expanded(child: SizedBox()), // Empty space to center the third card
            ],
          ),
        ],
      );
    } else {
      // Desktop: Three columns layout
      final cards = _buildHelpCards((width - 100) / 3 - 16, isMobile, isTablet);
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: cards[0]),
            const SizedBox(width: 24),
            Expanded(child: cards[1]),
            const SizedBox(width: 24),
            Expanded(child: cards[2]),
          ],
        ),
      );
    }
  }

  List<Widget> _buildHelpCards(double width, bool isMobile, bool isTablet) {
    return [
      _HelpCard(
        width: width,
        iconAsset: 'assets/images/icon-logo_3.svg',
        title: 'Contact us',
        description: 'Ask a question or find more information.',
        buttonText: 'Send Enquiry',
        isMobile: isMobile,
        isTablet: isTablet,
        onPressed: () {
          // Navigation action
        },
      ),
      _HelpCard(
        width: width,
        iconAsset: 'assets/images/icon-logo_3.svg',
        title: 'Call our office',
        description: 'Speak to our friendly customer support team.',
        buttonText: '+91 9392183747',
        isMobile: isMobile,
        isTablet: isTablet,
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
        isMobile: isMobile,
        isTablet: isTablet,
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
  final bool isMobile;
  final bool isTablet;

  const _HelpCard({
    required this.width,
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : width,
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Important: Let the card size itself
            children: [
              SvgPicture.asset(
                iconAsset,
                height: isMobile ? 28 : 36,
                width: isMobile ? 28 : 36,
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 20 : (isTablet ? 22 : 25),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F5D60),
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Text(
                description,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: title == 'Contact us' 
                    ? (isMobile ? 20 : (isTablet ? 40 : 60))
                    : (isMobile ? 16 : (isTablet ? 24 : 40)),
              ),
              SizedBox(
                width: isMobile ? double.infinity : 160,
                height: isMobile ? 45 : 50,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA000),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 8 : 10,
                      horizontal: isMobile ? 8 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    maxLines: isMobile ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}