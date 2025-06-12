import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ProcessStepsSection extends StatelessWidget {
  const ProcessStepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;
        final isTablet =
            constraints.maxWidth <= 900 && constraints.maxWidth > 600;
        final isMobile = constraints.maxWidth <= 600;

        return Column(
          children: _buildProcessSteps(
            constraints.maxWidth,
            isDesktop: isDesktop,
            isTablet: isTablet,
            isMobile: isMobile,
          ),
        );
      },
    );
  }

  // Helper method to launch URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  // Helper method to create rich text with clickable links
  Widget _buildRichText(String text, {required double fontSize, bool isBold = false}) {
    final List<TextSpan> spans = [];
    final RegExp urlRegex = RegExp(r'(www\.[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})');
    final RegExp linkRegex = RegExp(r'(document requirements|Priority Processing|Withdraw my application|Apply or continue assessment)');
    
    final matches = <Match>[];
    matches.addAll(urlRegex.allMatches(text));
    matches.addAll(linkRegex.allMatches(text));
    matches.sort((a, b) => a.start.compareTo(b.start));

    int currentIndex = 0;
    
    for (final match in matches) {
      // Add text before the match
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: TextStyle(
            fontSize: fontSize,
            height: 1.6,
            letterSpacing: 0.3,
            color: const Color(0xFF424242),
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ));
      }
      
      // Add the clickable link
      final matchText = match.group(0)!;
      spans.add(TextSpan(
        text: matchText,
        style: TextStyle(
          fontSize: fontSize,
          height: 1.6,
          letterSpacing: 0.3,
          color: const Color(0xFF006064),
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (urlRegex.hasMatch(matchText)) {
              _launchUrl('https://$matchText');
            } else {
              // Handle internal links
              _handleInternalLink(matchText);
            }
          },
      ));
      
      currentIndex = match.end;
    }
    
    // Add remaining text
    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: TextStyle(
          fontSize: fontSize,
          height: 1.6,
          letterSpacing: 0.3,
          color: const Color(0xFF424242),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ));
    }
    
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  // Handle internal navigation links
  void _handleInternalLink(String linkText) {
    switch (linkText) {
      case 'document requirements':
        // Navigate to document requirements page
        print('Navigate to document requirements');
        break;
      case 'Priority Processing':
        // Navigate to priority processing page
        print('Navigate to priority processing');
        break;
      case 'Withdraw my application':
        // Navigate to withdraw application page
        print('Navigate to withdraw application');
        break;
      case 'Apply or continue assessment':
        // Navigate to application page
        print('Navigate to apply or continue assessment');
        break;
    }
  }

  List<Widget> _buildProcessSteps(
    double screenWidth, {
    required bool isDesktop,
    required bool isTablet,
    required bool isMobile,
  }) {
    // Updated step data with rich text descriptions
    final List<Map<String, dynamic>> stepsData = [
      {
        'step': 'Step 1',
        'title': 'Choose a professional occupation',
        'description':
            'Choose an occupation against which you wish to be assessed and select the visa purpose for which the skills assessment is required. For information on the occupations available for migration to Australia and different visa categories please refer to www.homeaffairs.gov.au.',
        'anzscoInfo':
            'For information on the ANZSCO description of your chosen occupation, log on to www.abs.gov.au and enter the ANZSCO code for your selected occupation.',
        'image': 'assets/images/lady_1_occupation.jpg',
        'imageOnRight': false,
        'linkText': 'Find your occupation',
      },
      {
        'step': 'Step 2',
        'title': 'Read what\'s required',
        'description':
            'If VETASSESS is the assessing authority for your chosen occupation, you will be able to find detailed information on the skills assessment criteria when you search for your occupation on our website. A VETASSESS Skills Assessment considers the relevance of qualifications and employment to the nominated occupation.\n\nOur assessment of your qualification/s will assess the educational level of your qualification against Australian requirements and the relevance of the major area of study. Only a qualification/s assessment is required for 485 visa purposes. An assessment of both qualification/s and employment is required for permanent residency purposes.',
        'anzscoInfo': '',
        'image': 'assets/images/management_consultant.png',
        'imageOnRight': true,
        'linkText': 'Find your Occupation',
      },
      {
        'step': 'Step 3',
        'title': 'Create an Account with VETASSESS',
        'description':
            'Log on to Apply or continue assessment.',
        'anzscoInfo': '',
        'image': 'assets/images/Create_account_with_VETASSESS _1.jpg',
        'imageOnRight': false,
        'linkText': 'Create an Account',
      },
      {
        'step': 'Step 4',
        'title': 'Submit your Application',
        'description':
            'Complete the online application form and upload high-quality color scans of the necessary documents. Ensure that you thoroughly read and understand the document requirements before applying. Failure to provide all the relevant documents in the correct format may result in a delay in processing your application, extending beyond the standard processing times. If you wish to have your application processed under Priority Processing, you should select this option on your application when submitting it.',
        'anzscoInfo': '',
        'image': 'assets/images/general_skills_application.jpg',
        'imageOnRight': true,
        'linkText': 'Apply Now',
      },
      {
        'step': 'Step 5',
        'title': 'During your Application',
        'description':
            'Your application will be allocated to an assessment officer and if there are additional documents required you will be notified online. If you need to Withdraw my application, you can do so through the online portal.',
        'anzscoInfo': '',
        'image': 'assets/images/During_your_application.jpg',
        'imageOnRight': false,
        'linkText': 'Track your Application',
      },
      {
        'step': 'Step 6',
        'title': 'Application Outcome',
        'description':
            'Once your skills assessment application is complete, you will be able to view and download your skills assessment outcome letter from the online portal.',
        'anzscoInfo': '',
        'image': 'assets/images/Application_Outcome.jpg',
        'imageOnRight': true,
        'linkText': 'Apply Now or View Application',
      },
    ];

    // Generate widgets for each step
    return stepsData.map((stepData) {
      final int index = stepsData.indexOf(stepData);

      if (isMobile) {
        // For mobile screens, stack vertically regardless of imageOnRight
        return _buildMobileLayout(screenWidth, stepData, index);
      } else {
        // For tablet and desktop, use row layout with responsive sizes
        return _buildHorizontalLayout(
          screenWidth,
          stepData,
          index,
          isDesktop: isDesktop,
          isTablet: isTablet,
        );
      }
    }).toList();
  }

  Widget _buildMobileLayout(
    double screenWidth,
    Map<String, dynamic> stepData,
    int index,
  ) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: index == 0 ? 40 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image always on top for mobile
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              stepData['image'],
              width: screenWidth * 0.9,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 32),
          // Step number and title
          Text(
            stepData['step'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            stepData['title'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 20),
          // Description with rich text
          _buildRichText(stepData['description'], fontSize: 16),
          const SizedBox(height: 24),
          // ANZSCO info section (only if not empty)
          if (stepData['anzscoInfo'].isNotEmpty) ...[
            const Text(
              'Information on the ANZSCO description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            const SizedBox(height: 12),
            _buildRichText(stepData['anzscoInfo'], fontSize: 16),
            const SizedBox(height: 24),
          ],
          // Link button
          if (stepData['linkText'] != null)
            InkWell(
              onTap: () {
                // Handle link tap
                print('Navigate to: ${stepData['linkText']}');
              },
              child: Text(
                stepData['linkText'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF006064),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHorizontalLayout(
    double screenWidth,
    Map<String, dynamic> stepData,
    int index, {
    required bool isDesktop,
    required bool isTablet,
  }) {
    final double horizontalPadding =
        isDesktop ? screenWidth * 0.08 : screenWidth * 0.05;
    final double contentWidth =
        isDesktop ? screenWidth * 0.84 : screenWidth * 0.9;
    final double imageWidth = isDesktop ? contentWidth * 0.45 : contentWidth * 0.4;
    final double textWidth = isDesktop ? contentWidth * 0.45 : contentWidth * 0.5;
    final double verticalSpacing = isDesktop ? 80 : 60;

    final Widget stepInfoColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Text(
            stepData['step'],
            style: TextStyle(
              fontSize: isDesktop ? 28 : 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            stepData['title'],
            style: TextStyle(
              fontSize: isDesktop ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 24),
          // Description with rich text
          _buildRichText(stepData['description'], fontSize: isDesktop ? 16 : 15),
          // ANZSCO info section (only if not empty)
          if (stepData['anzscoInfo'].isNotEmpty) ...[
            const SizedBox(height: 32),
            Text(
              'Information on the ANZSCO description',
              style: TextStyle(
                fontSize: isDesktop ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF006064),
              ),
            ),
            const SizedBox(height: 16),
            _buildRichText(stepData['anzscoInfo'], fontSize: isDesktop ? 16 : 15),
          ],
          // Link button
          if (stepData['linkText'] != null) ...[
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                // Handle link tap
                print('Navigate to: ${stepData['linkText']}');
              },
              child: Text(
                stepData['linkText'],
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF006064),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      );
    
  

    final Widget imageWidget = Flexible(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          stepData['image'],
          width: imageWidth,
          height: isDesktop ? 350 : 280,
          fit: BoxFit.cover,
        ),
      ),
    );

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: index == 0 ? 40 : verticalSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: stepData['imageOnRight']
            ? [
                Expanded(flex: 45, child: stepInfoColumn),
                const Spacer(flex: 10),
                Expanded(flex: 45, child: imageWidget),
              ]
            : [
                Expanded(flex: 45, child: imageWidget),
                const Spacer(flex: 10),
                Expanded(flex: 45, child: stepInfoColumn),
              ],
      ),
    );
  }
}