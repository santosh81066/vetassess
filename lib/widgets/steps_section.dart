import 'package:flutter/material.dart';

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

  List<Widget> _buildProcessSteps(
    double screenWidth, {
    required bool isDesktop,
    required bool isTablet,
    required bool isMobile,
  }) {
    // Define all step data in a list
    final List<Map<String, dynamic>> stepsData = [
      {
        'step': 'Step 1',
        'title': 'Choose a professional occupation',
        'description':
            'Select an occupation that aligns with your qualifications and work experience. Your nomination should reflect your skills and expertise accurately for the best assessment outcome.',
        'anzscoInfo':
            'Review the Australian and New Zealand Standard Classification of Occupations (ANZSCO) to ensure your chosen occupation matches your skills and qualifications.',
        'image': 'assets/images/lady_1_occupation.jpg',
        'imageOnRight': false,
      },
      {
        'step': 'Step 2',
        'title': 'Check eligibility requirements',
        'description':
            'Verify that you meet the minimum qualification and work experience requirements for your nominated occupation. Different occupations have different eligibility criteria.',
        'anzscoInfo':
            'Each occupation has specific skill requirements outlined in the ANZSCO. Ensure you understand these requirements before proceeding with your application.',
        'image': 'assets/images/management_consultant.png',
        'imageOnRight': true,
      },
      {
        'step': 'Step 3',
        'title': 'Create an account with VETASSESS',
        'description':
            'Register on the VETASSESS portal to begin your skills assessment process. You will need to provide personal details and create login credentials.',
        'anzscoInfo':
            'Have your ANZSCO occupation code ready when creating your account to streamline the application process.',
        'image': 'assets/images/Create_account_with_VETASSESS _1.jpg',
        'imageOnRight': false,
      },
      {
        'step': 'Step 4',
        'title': 'Submit your application and documents',
        'description':
            'Complete the online application form and upload all required documentation, including qualifications, employment evidence, and identification documents.',
        'anzscoInfo':
            'Ensure your documentation clearly demonstrates how your skills and experience align with your nominated ANZSCO occupation.',
        'image': 'assets/images/general_skills_application.jpg',
        'imageOnRight': true,
      },
      {
        'step': 'Step 5',
        'title': 'Application processing',
        'description':
            'Your application will be reviewed by VETASSESS assessors. You may be contacted for additional information or clarification during this stage.',
        'anzscoInfo':
            'VETASSESS assessors will compare your qualifications and experience against the ANZSCO standards for your nominated occupation.',
        'image': 'assets/images/During_your_application.jpg',
        'imageOnRight': false,
      },
      {
        'step': 'Step 6',
        'title': 'Receive assessment outcome',
        'description':
            'Once assessment is complete, you will receive an outcome letter indicating whether your skills have been positively assessed for your nominated occupation.',
        'anzscoInfo':
            'If successful, you can use your skills assessment for migration purposes as specified in the Department of Home Affairs requirements.',
        'image': 'assets/images/Application_Outcome.jpg',
        'imageOnRight': true,
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
        vertical: index == 0 ? 20 : 50,
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
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          // Info below the image
          Text(
            stepData['step'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stepData['title'],
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            stepData['description'],
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Information on the ANZSCO description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stepData['anzscoInfo'],
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              letterSpacing: 0.3,
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
        isDesktop ? screenWidth * 0.1 : screenWidth * 0.05;
    final double infoColumnWidth =
        isDesktop ? screenWidth * 0.3 : screenWidth * 0.45;
    final double imageWidth = isDesktop ? screenWidth * 0.4 : screenWidth * 0.4;
    final double verticalSpacing =
        isDesktop ? (index == 0 ? 0 : 100) : (index == 0 ? 0 : 50);

    final Widget stepInfoColumn = Container(
      width: infoColumnWidth,
      constraints: BoxConstraints(minHeight: isDesktop ? 400 : 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepData['step'],
            style: TextStyle(
              fontSize: isDesktop ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stepData['title'],
            style: TextStyle(
              fontSize: isDesktop ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            stepData['description'],
            style: TextStyle(
              fontSize: isDesktop ? 16 : 14,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Information on the ANZSCO description',
            style: TextStyle(
              fontSize: isDesktop ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stepData['anzscoInfo'],
            style: TextStyle(
              fontSize: isDesktop ? 16 : 14,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );

    final Widget imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        stepData['image'],
        width: imageWidth,
        fit: BoxFit.cover,
      ),
    );

    final List<Widget> rowChildren =
        stepData['imageOnRight']
            ? [stepInfoColumn, const Spacer(), imageWidget]
            : [imageWidget, const Spacer(), stepInfoColumn];

    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: rowChildren,
      ),
    );
  }
}
