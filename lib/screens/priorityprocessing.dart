import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vetassess/screens/application_process.dart';
import 'package:vetassess/theme.dart';
import '../widgets/BasePageLayout.dart';

class PriorityProcessing extends StatelessWidget {
  const PriorityProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrLarger = screenWidth > 768;
    final screenHeight = MediaQuery.of(context).size.height;

    // Color constants
    const Color tealColor = Color(0xFF00565B);
    const Color yellowColor = Color(0xFFF9C700);
    const Color dottedLineColor = Color(0xFF008996);
    
    return BasePageLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildProcessSteps(screenWidth, screenHeight),
            
            const SizedBox(height: 30),
            
            // Modified section with better responsive layout
            _buildWhoCanApplySection(context, isTabletOrLarger),
            
            const SizedBox(height: 30),
            
            _buildEligibilityCategories(context),
            const SizedBox(height: 60),

            _buildSectionTitle(context, 'How to Apply'),
             const SizedBox(height: 30),
            _buildApplicationSteps(context),

            const SizedBox(height: 50),
            
            // Content sections
            _buildDivider(),
            const SizedBox(height: 30),
             
            
             _buildBeforeyouapplySection( context, isTabletOrLarger),
              const SizedBox(height: 20),
                        
            SizedBox(height: 30,),
            _buildPriorityProcessingSection(context, isTabletOrLarger),
              SizedBox(height: 50,),
             _buildFaqSection(
            'Explore FAQs',
            [
              'What is a highly relevant employment?',
              'What is pre- and post-qualification employment?',
              'What is Date Deemed Skilled?',
              'What is closely related employment?',
              "What happens if my occupation is removed from the Australian Government's Department of Home Affairs list of eligible occupations during Priority Processing?",
            ],
            false,
            tealColor,
            yellowColor,
            dottedLineColor,
            context,
          ),
            SizedBox(height: 50,),   
          _buildTradesBanner(screenHeight),
           SizedBox(height: 50,), 
            _buildPreparingApplSection(
            'Preparing your application',
            [
              'What is a highly relevant employment?',
              'What is pre- and post-qualification employment?',
              'What is Date Deemed Skilled?',
              'What is closely related employment?',
            ],
            false,
            tealColor,
            yellowColor,
            dottedLineColor,
            context,
          ),

          ],
        ),
      ),
    );
  }

  // New method to build the "Who can apply" section with responsive layout
  Widget _buildWhoCanApplySection(BuildContext context, bool isTabletOrLarger) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left section with content
            Expanded(
              flex: isTabletOrLarger ? 7 : 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Who can apply'),
                  
                  const SizedBox(height: 20),
                  
                  _buildFootnoteText(
                    context,
                    'When applying for Priority Processing, you must have sufficient supporting evidence, correct fee payment, proof of identity, qualification and employment claims ready to upload to the online form.',
                  ),
                  _buildFootnoteText(
                    context,
                    'The 10 business days will start after:',
                  ),
                  const SizedBox(height: 15),
                  _buildBulletPoints(
                    'We have confirmed your application meets the eligibility criteria for Priority Processing. This normally takes up to two business days. You will receive an email from us once your application is approved for Priority Processing.',
                  ),
                  _buildBulletPoints(
                    'The fee has been paid and received.',
                  ),
                ],
              ),
            ),
            // Right spacer section
            if (isTabletOrLarger) 
              Expanded(
                flex: 3,
                child: Container(),
              ),
          ],
        );
      }
    );
  }

   // New method to build the "Who can apply" section with responsive layout
  Widget _buildBeforeyouapplySection(BuildContext context, bool isTabletOrLarger) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left section with content
            Expanded(
              flex: isTabletOrLarger ? 7 : 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Before you apply'),
                  
                  const SizedBox(height: 20),
                  
                  _buildFootnoteText(
                    context,
                    'There are some important requirements to know before you apply for Priority Processing:',
                  ),
                  _buildFootnoteText(
                    context,
                    'The 10 business days will start after:',
                  ),
                  const SizedBox(height: 15),
                  _buildBulletPoints(
                    'You need to submit all your documents and pay for a standard assessment and the Priority Processing fee at the time you apply. You will not be able to load more documents later because of the tight timeframe for Priority Processing. ',
                  ),
                  _buildBulletPoints(
                    'Before we accept your application for Priority Processing, we will review if we can meet the deadline of 10 business days for assessment. If you meet the criteria for Priority Processing, it will take us around 2 business days for the review. Once this is approved, you will receive and acceptance email from us.',
                  ),
                  _buildBulletPoints(
                    'If we find the submitted documents are misleading, or if we have to investigate if they are authentic, we may conduct additional checks. This is likely to delay the process beyond 10 days. ',
                  ),
                  _buildBulletPoints(
                    'If your application is assessed as not suitable for Priority Processing, VETASSESS will refund the Priority Processing fee within 3 weeks of notification of non-eligibility. Your application will proceed through the standard process for a full skills assessment.',
                  ),
                  SizedBox(height: 15,),
                  _buildFootnoteText(
                    context,
                    'Once the assessment is made, you can download your assessment outcome letter within 48 hours.',
                  ),
                   SizedBox(height: 15,),
                  _buildFootnoteText(
                    context,
                    'There is an additional cost of \$806, excluding GST, for this service. You must lodge your application online.',
                  ),
                ],
              ),
            ),
            // Right spacer section
            if (isTabletOrLarger) 
              Expanded(
                flex: 3,
                child: Container(),
              ),
          ],
        );
      }
    );
  }

     // New method to build the "Who can apply" section with responsive layout
  Widget _buildPriorityProcessingSection(BuildContext context, bool isTabletOrLarger) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left section with content
            Expanded(
              flex: isTabletOrLarger ? 7 : 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'What does Priority Processing cost?'),
                  
                  const SizedBox(height: 20),
                  _buildFootnoteText(
                    context,
                    'There is an additional cost of \$806, excluding GST, for this service. ',
                  ),
                    SizedBox(height: 10,),
                  _buildTaxOfficeFootnote(context),
                ],
              ),
            ),
            // Right spacer section
            if (isTabletOrLarger) 
              Expanded(
                flex: 3,
                child: Container(),
              ),
          ],
        );
      }
    );
  }

  Widget _buildFaqSection(
  String sectionTitle,
  List<String> expandableTitles,
  bool includeParagraphs,
  Color tealColor,
  Color yellowColor,
  Color dottedLineColor,
  BuildContext context,
) {
  // Actual FAQ items from the image
  final List<String> actualFaqTitles = [
    'How can VETASSESS be sure it can process my application in 10 business days?',
    'What if my application for Priority Processing is not accepted?',
    'I’ve applied for the standard service. Can I change to Priority Processing?'
        'Once my application for Priority Processing is accepted, can I change my occupation?',
    'What happens if you cannot process my priority processing application within 10 business days?',
    "What happens if my occupation is removed from the Australian Government's Department of Home Affairs list of eligible occupations during Priority Processing?",
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 60),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column - Title and View all button
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: 40),
              Text(
                "Explore FAQs",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0A594C),
                  height: 1.3,
                ),
              ),
              SizedBox(height: 24),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "View all",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A594C),

                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Color(0xFF0A594C),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Right column - FAQ accordions
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(top: 6),
            child: Column(
              children:
                  actualFaqTitles.map((title) {
                    return Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                        colorScheme: ColorScheme.light(
                          surfaceTint: Colors.transparent,
                          primary: Color(0xFF0A594C),
                        ),
                      ),
                      child: Column(
                        children: [
                          ExpansionTile(
                            tilePadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 0,
                            ),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            childrenPadding: EdgeInsets.only(
                              left: 50,
                              bottom: 16,
                              right: 20,
                            ),
                            leading: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF0A594C),
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Color(0xFF0A594C),
                                size: 22,
                                weight: 900,
                              ),
                            ),
                            title: Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0A594C),
                              ),
                            ),
                            trailing: SizedBox.shrink(),
                            children: [
                              Text(
                                'This is the answer to the FAQ question.',
                                style: TextStyle(fontSize: 15, height: 1.5),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            child: CustomPaint(
                              painter: DottedLinePainter(
                                color: Color(0xFF008996),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}


  List<Widget> _buildProcessSteps(double screenWidth, double screenHeight) {
    // Define all step data in a list
    final List<Map<String, dynamic>> stepsData = [
      {
        'step': 'Fast track your application in 10 business days',
        'description':
            'If you\'re in a hurry and would like to fast track your application, we offer a priority service where we will assess your application in 10 business days for an extra cost of \$806.',
        'descriptions':
            'Priority Processing is available for General and Professional occupations.',
        'image': 'assets/images/blog_metropolis.jpg',
        'imageOnRight': true,
      },
    ];

    // Generate widgets for each step
    return stepsData.asMap().entries.map((entry) {
      final int index = entry.key;
      final Map<String, dynamic> stepData = entry.value;

      final Widget stepInfoColumn = SizedBox(
        width: screenWidth * 0.4,
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stepData['step'],
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006064),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              stepData['description'],
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              stepData['descriptions'],
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
        width: 500,
        fit: BoxFit.fitHeight,
      );

      final List<Widget> rowChildren = stepData['imageOnRight']
          ? [stepInfoColumn, imageWidget]
          : [imageWidget, stepInfoColumn];

     return Container(
  color: AppColors.color12,
  width: screenWidth,
  padding: EdgeInsets.only(
    top: screenHeight / 35,
    bottom: screenHeight / 35,
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: rowChildren,
  ),
);

    }).toList();
  }

  // Build the numbered application steps section
  Widget _buildApplicationSteps(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step 1
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberedStep(context, '1', 'Check Eligibility'),
              const SizedBox(height: 10),
              Text(
                'Check your eligibility for Priority Processing.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF5A5A5A),
                ),
              ),
            ],
          ),
        ),
        // Connector line for step 1 to 2
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            height: 2,
            color: Colors.amber,
          ),
        ),
        // Step 2
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberedStep(context, '2', 'Documents'),
              const SizedBox(height: 10),
              Text(
                'Gather required documents for application.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF5A5A5A),
                ),
              ),
            ],
          ),
        ),
        // Connector line for step 2 to 3
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 30),
            height: 2,
            color: Colors.amber,
          ),
        ),
        // Step 3
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberedStep(context, '3', 'Apply'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5A5A5A),
                  ),
                  children: [
                    const TextSpan(text: 'Apply online '),
                    const TextSpan(
                      text: 'here',
                      style: TextStyle(
                        color: Color(0xFF006064),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: '. You will have the option to select Priority Processing for your application.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Build a numbered step with a box
  Widget _buildNumberedStep(BuildContext context, String number, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              color: const Color(0xFFF2F2F2),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0d5257),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0d5257),
          ),
        ),
      ],
    );
  }

  // Build the eligibility and ineligibility sections side by side
  Widget _buildEligibilityCategories(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eligible applicants column
        Expanded(
          child: SizedBox(
            height: 280,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFF2F2F2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Applicants eligible for Priority Processing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0d5257),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildBulletPoints('New full skills assessment applications'),
                  const SizedBox(height: 10),
                  _buildBulletPoints('Positively assessed renewal applications'),
                  const SizedBox(height: 10),
                  _buildBulletPoints('Returning applicants for assessment under a change of occupation'),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Ineligible applicants column
        Expanded(
          child: SizedBox(
            height: 280,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFF2F2F2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Applicants ineligible for Priority Processing',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0d5257),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildBulletPoints('Negatively assessed renewal applications'),
                  const SizedBox(height: 10),
                  _buildBulletPoints('Returning applicants with a negative outcome for previous full skills assessment are not eligible'),
                  const SizedBox(height: 10),
                  _buildBulletPoints('Applications for Review and Appeal'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
   // Build the standard Tax Office footnote that appears throughout the page
  Widget _buildTaxOfficeFootnote(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(text: 'Before applying, check the documents you will need and ensure you understand the '),
            TextSpan(
              text: ' application process.',
              style: TextStyle(
                color: const Color(0xFF0d5257),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
            
          ],
        ),
      ),
    );
  }


   Widget _buildDivider() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          height: 1,
          color: const Color(0xFFF9D342), // Yellow color for the line
          width: double.infinity,
        ),
        const SizedBox(height: 30),
      ],
    );
  }


  // Build a standard section title with consistent styling
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0d5257),
                fontSize: 30,
              ),
        ),
        
      ],
    );
  }

  // Build standard footnote text
  Widget _buildFootnoteText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  // Helper method for bullet points
  Widget _buildBulletPoints(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF5A5A5A),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF5A5A5A),
            ),
          ),
        ),
      ],
    );
  }
  
Widget _buildTradesBanner(double screenHeight) {
  return Container(
    width: double.infinity,
    height: screenHeight * 0.30,
    decoration: const BoxDecoration(color: Color(0xFF0d5257)),
    child: Stack(
      children: [
        Positioned(
          right: 0.95,
          bottom: 0,
          child: SvgPicture.asset(
            'assets/images/vet.svg',
            width: screenHeight * 0.1,
            height: screenHeight * 0.3,
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left side: Title and subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Apply Online Now',
                      style: TextStyle(
                        color: Color(0xFFFFA000),
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You must apply for Priority Processing before placing your application.',
                      style: TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                // Right side: Button
                SizedBox(
                  height: 60,
                  width: 160,
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
                      "Apply Online",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


Widget _buildPreparingApplSection(
  String sectionTitle,
  List<String> expandableTitles,
  bool includeParagraphs,
  Color tealColor,
  Color yellowColor,
  Color dottedLineColor,
  BuildContext context,
) {
  // Actual navigation items from the image
  final List<String> actualLinks = [
    'The application process',
    'Acceptable documents you will need',
    'Fees & Charges',
    'Check your occupation',
    'FAQs',
    'Reviews, Reassessments, Appeals,\nReissues & Feedback',
    'Priority Processing & Urgent\nApplications',
    'Points Test Advice',
    'Renewals',
  ];

  return Container(
    width: double.infinity,
   // color: Colors.white,
    // padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column - Title and description
        Expanded(
          flex: 2,
          child: Container(
            width: 450,
            padding: EdgeInsets.only(top: 40, bottom: 40, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Preparing your application",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A594C),
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'A VETASSESS Skills Assessment involves assessing both your qualifications and your employment experience. Your qualifications will be compared with the Australian Qualifications Framework (AQF) and your employment experience will be assessed to determine whether it is relevant and at an appropriate skill level.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
          const SizedBox(width: 100),
        // Right column - Navigation links with dotted lines
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(top: 40, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  actualLinks.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String link = entry.value;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                link,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF0A594C),
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Add dotted line for all items except the last one
                        if (index < actualLinks.length - 1)
                          Container(
                            width: double.infinity,
                            height: 1,
                            child: CustomPaint(
                              painter: DottedLinePainter(
                                color: Color(0xFFfd7e14),
                              ),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
   
}

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;

    const double dashWidth = 3;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
