import 'package:flutter/material.dart';

class ProcessStepsSection extends StatelessWidget {
  const ProcessStepsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(children: _buildProcessSteps(screenWidth));
  }

  List<Widget> _buildProcessSteps(double screenWidth) {
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
      final Widget stepInfoColumn = Container(
        width: screenWidth * 0.3,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stepData['step'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            Text(
              stepData['title'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            Text(
              stepData['description'],
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
            const Text(
              'Information on the ANZSCO description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            Text(
              stepData['anzscoInfo'],
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      );

      final Widget imageWidget = Image.asset(
        stepData['image'],
        height: 400,
        width: 600,
      );

      final List<Widget> rowChildren =
          stepData['imageOnRight']
              ? [stepInfoColumn, imageWidget]
              : [imageWidget, stepInfoColumn];

      final int index = stepsData.indexOf(stepData);

      return Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: index == 0 ? 0 : 100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      );
    }).toList();
  }
}
