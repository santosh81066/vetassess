import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vetassess/screens/application_process.dart';
import 'package:vetassess/theme.dart';
import '../widgets/BasePageLayout.dart';

class PriorityProcessing extends StatelessWidget {
  const PriorityProcessing({super.key});

  static const tealColor = Color(0xFF00565B);
  static const yellowColor = Color(0xFFF9C700);
  static const dottedLineColor = Color(0xFF008996);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTabletOrLarger = size.width > 768;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width <= 1024;
    final isDesktop = size.width > 1024;

    // Responsive padding
    double horizontalPadding = isDesktop ? 150 : (isTablet ? 50 : 20);

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(size, isMobile, isTablet),
          _buildBreadcrumbs(isMobile, horizontalPadding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._buildProcessSteps(size, isMobile, isTablet),
                const SizedBox(height: 30),
                _buildResponsiveSection(
                  context,
                  isTabletOrLarger,
                  'Who can apply',
                  _whoCanApplyContent(),
                ),
                const SizedBox(height: 30),
                _buildEligibilityCategories(isMobile),
                const SizedBox(height: 60),
                _buildSectionTitle('How to Apply'),
                const SizedBox(height: 30),
                _buildApplicationSteps(isMobile),
                const SizedBox(height: 50),
                _buildDivider(),
                const SizedBox(height: 30),
                _buildResponsiveSection(
                  context,
                  isTabletOrLarger,
                  'Before you apply',
                  _beforeApplyContent(),
                ),
                const SizedBox(height: 50),
                _buildResponsiveSection(
                  context,
                  isTabletOrLarger,
                  'What does Priority Processing cost?',
                  _costContent(),
                ),
                const SizedBox(height: 50),
                _buildFaqSection(isMobile),
                const SizedBox(height: 50),
                _buildTradesBanner(size.height, isMobile),
                const SizedBox(height: 50),
                _buildPreparingApplSection(isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner(Size size, bool isMobile, bool isTablet) {
    return Container(
      width: size.width,
      height: isMobile ? size.height * 0.35 : size.height * 0.45,
      decoration: const BoxDecoration(color: tealColor),
      child: Stack(
        children: [
          if (!isMobile)
            Positioned(
              right: 0,
              child: Image.asset(
                'assets/images/internal_page_banner.png',
                height: isMobile ? size.height * 0.35 : size.height * 0.45,
                fit: BoxFit.fitHeight,
              ),
            ),
          Container(
            width: isMobile ? size.width * 0.9 : size.width * 0.66,
            padding: EdgeInsets.only(
              top: isMobile ? 50 : 100,
              left: isMobile ? 20 : (isTablet ? 50 : 170),
              right: isMobile ? 20 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Priority Processing",
                  style: TextStyle(
                    color: const Color(0xFFFFA000),
                    fontSize: isMobile ? 28 : (isTablet ? 36 : 42),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: isMobile ? 20 : 30),
                Text(
                  "Fast track the assessment of your application for a professional or general occupation.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 16,
                    height: 1.5,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs(bool isMobile, double horizontalPadding) {
    const linkStyle = TextStyle(
      fontSize: 14,
      color: Color(0xFF0d5257),
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );

    final breadcrumbs = [
      ('Home', linkStyle),
      ('Skills Assessment For Migration', linkStyle),
      ('Skills Assessment for professional occupations', linkStyle),
      (
        'Priority Processing & Urgent Applications',
        TextStyle(color: Colors.grey[600], fontSize: 14),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: horizontalPadding,
      ),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    breadcrumbs
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(item.$1, style: item.$2),
                          ),
                        )
                        .toList(),
              )
              : Row(
                children:
                    breadcrumbs
                        .expand(
                          (item) => [
                            TextButton(
                              onPressed: item.$2 == linkStyle ? () {} : null,
                              child: Text(item.$1, style: item.$2),
                            ),
                            if (item != breadcrumbs.last)
                              const Text(
                                ' / ',
                                style: TextStyle(color: Colors.grey),
                              ),
                          ],
                        )
                        .toList(),
              ),
    );
  }

  Widget _buildResponsiveSection(
    BuildContext context,
    bool isTabletOrLarger,
    String title,
    List<Widget> content,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isTabletOrLarger ? 7 : 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(title),
              const SizedBox(height: 20),
              ...content,
            ],
          ),
        ),
        if (isTabletOrLarger) const Expanded(flex: 3, child: SizedBox()),
      ],
    );
  }

  List<Widget> _whoCanApplyContent() {
    return [
      _buildText(
        'When applying for Priority Processing, you must have sufficient supporting evidence, correct fee payment, proof of identity, qualification and employment claims ready to upload to the online form.',
      ),
      _buildText('The 10 business days will start after:'),
      const SizedBox(height: 15),
      _buildBulletPoint(
        'We have confirmed your application meets the eligibility criteria for Priority Processing. This normally takes up to two business days. You will receive an email from us once your application is approved for Priority Processing.',
      ),
      _buildBulletPoint('The fee has been paid and received.'),
    ];
  }

  List<Widget> _beforeApplyContent() {
    final points = [
      'You need to submit all your documents and pay for a standard assessment and the Priority Processing fee at the time you apply. You will not be able to load more documents later because of the tight timeframe for Priority Processing.',
      'Before we accept your application for Priority Processing, we will review if we can meet the deadline of 10 business days for assessment. If you meet the criteria for Priority Processing, it will take us around 2 business days for the review. Once this is approved, you will receive and acceptance email from us.',
      'If we find the submitted documents are misleading, or if we have to investigate if they are authentic, we may conduct additional checks. This is likely to delay the process beyond 10 days.',
      'If your application is assessed as not suitable for Priority Processing, VETASSESS will refund the Priority Processing fee within 3 weeks of notification of non-eligibility. Your application will proceed through the standard process for a full skills assessment.',
    ];

    return [
      _buildText(
        'There are some important requirements to know before you apply for Priority Processing:',
      ),
      _buildText('The 10 business days will start after:'),
      const SizedBox(height: 15),
      ...points.map(_buildBulletPoint),
      const SizedBox(height: 15),
      _buildText(
        'Once the assessment is made, you can download your assessment outcome letter within 48 hours.',
      ),
      const SizedBox(height: 15),
      _buildText(
        'There is an additional cost of \$806, excluding GST, for this service. You must lodge your application online.',
      ),
    ];
  }

  List<Widget> _costContent() {
    return [
      _buildText(
        'There is an additional cost of \$806, excluding GST, for this service.',
      ),
      const SizedBox(height: 10),
      _buildTaxOfficeFootnote(),
    ];
  }

  List<Widget> _buildProcessSteps(Size size, bool isMobile, bool isTablet) {
    return [
      Container(
        color: AppColors.color12,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: size.height / 35),
        child:
            isMobile
                ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fast track your application in 10 business days',
                            style: TextStyle(
                              fontSize: isMobile ? 24 : 30,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF006064),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'If you\'re in a hurry and would like to fast track your application, we offer a priority service where we will assess your application in 10 business days for an extra cost of \$806.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Priority Processing is available for General and Professional occupations.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Image.asset(
                      'assets/images/blog_metropolis.jpg',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: isTablet ? size.width * 0.5 : size.width * 0.4,
                      height: isTablet ? 400 : 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fast track your application in 10 business days',
                            style: TextStyle(
                              fontSize: isTablet ? 24 : 30,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF006064),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'If you\'re in a hurry and would like to fast track your application, we offer a priority service where we will assess your application in 10 business days for an extra cost of \$806.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Priority Processing is available for General and Professional occupations.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/blog_metropolis.jpg',
                      height: isTablet ? 300 : 400,
                      width: isTablet ? 350 : 500,
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
      ),
    ];
  }

  Widget _buildApplicationSteps(bool isMobile) {
    final steps = [
      (
        '1',
        'Check Eligibility',
        'Check your eligibility for Priority Processing.',
      ),
      ('2', 'Documents', 'Gather required documents for application.'),
      ('3', 'Apply', null), // Special case for apply step
    ];

    if (isMobile) {
      return Column(
        children:
            steps
                .map(
                  (step) => Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNumberedStep(step.$1, step.$2),
                        const SizedBox(height: 10),
                        if (step.$1 == '3')
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF5A5A5A),
                              ),
                              children: [
                                TextSpan(text: 'Apply online '),
                                TextSpan(
                                  text: 'here',
                                  style: TextStyle(
                                    color: Color(0xFF006064),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '. You will have the option to select Priority Processing for your application.',
                                ),
                              ],
                            ),
                          )
                        else
                          Text(
                            step.$3!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF5A5A5A),
                            ),
                          ),
                        if (step != steps.last)
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 2,
                            width: 100,
                            color: Colors.amber,
                          ),
                      ],
                    ),
                  ),
                )
                .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          steps
              .expand(
                (step) => [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNumberedStep(step.$1, step.$2),
                        const SizedBox(height: 10),
                        if (step.$1 == '3')
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF5A5A5A),
                              ),
                              children: [
                                TextSpan(text: 'Apply online '),
                                TextSpan(
                                  text: 'here',
                                  style: TextStyle(
                                    color: Color(0xFF006064),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '. You will have the option to select Priority Processing for your application.',
                                ),
                              ],
                            ),
                          )
                        else
                          Text(
                            step.$3!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF5A5A5A),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (step != steps.last)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 30),
                        height: 2,
                        color: Colors.amber,
                      ),
                    ),
                ],
              )
              .toList(),
    );
  }

  Widget _buildNumberedStep(String number, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildEligibilityCategories(bool isMobile) {
    final eligibleItems = [
      'New full skills assessment applications',
      'Positively assessed renewal applications',
      'Returning applicants for assessment under a change of occupation',
    ];

    final ineligibleItems = [
      'Negatively assessed renewal applications',
      'Returning applicants with a negative outcome for previous full skills assessment are not eligible',
      'Applications for Review and Appeal',
    ];

    if (isMobile) {
      return Column(
        children: [
          _buildEligibilityBox(
            'Applicants eligible for Priority Processing',
            eligibleItems,
          ),
          const SizedBox(height: 20),
          _buildEligibilityBox(
            'Applicants ineligible for Priority Processing',
            ineligibleItems,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEligibilityBox(
          'Applicants eligible for Priority Processing',
          eligibleItems,
        ),
        const SizedBox(width: 20),
        _buildEligibilityBox(
          'Applicants ineligible for Priority Processing',
          ineligibleItems,
        ),
      ],
    );
  }

  Widget _buildEligibilityBox(String title, List<String> items) {
    return Expanded(
      child: Container(
        height: 280,
        padding: const EdgeInsets.all(20),
        color: const Color(0xFFF2F2F2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0d5257),
              ),
            ),
            const SizedBox(height: 20),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildBulletPoint(item),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqSection(bool isMobile) {
    final faqTitles = [
      'How can VETASSESS be sure it can process my application in 10 business days?',
      'What if my application for Priority Processing is not accepted?',
      'I\'ve applied for the standard service. Can I change to Priority Processing?',
      'Once my application for Priority Processing is accepted, can I change my occupation?',
      'What happens if you cannot process my priority processing application within 10 business days?',
      "What happens if my occupation is removed from the Australian Government's Department of Home Affairs list of eligible occupations during Priority Processing?",
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 60),
      child:
          isMobile
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Explore FAQs",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A594C),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Text(
                          "View all",
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A594C),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF0A594C),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children:
                        faqTitles.map((title) => _buildFaqItem(title)).toList(),
                  ),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          "Explore FAQs",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0A594C),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Text(
                                "View all",
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0A594C),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0A594C),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
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
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        children:
                            faqTitles
                                .map((title) => _buildFaqItem(title))
                                .toList(),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildFaqItem(String title) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        colorScheme: const ColorScheme.light(
          surfaceTint: Colors.transparent,
          primary: Color(0xFF0A594C),
        ),
      ),
      child: Column(
        children: [
          ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(vertical: 20),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.only(
              left: 50,
              bottom: 16,
              right: 20,
            ),
            leading: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0A594C), width: 3),
              ),
              child: const Icon(Icons.add, color: Color(0xFF0A594C), size: 22),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0A594C),
              ),
            ),
            trailing: const SizedBox.shrink(),
            children: const [
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
              painter: DottedLinePainter(color: dottedLineColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradesBanner(double screenHeight, bool isMobile) {
    return Container(
      width: double.infinity,
      height: isMobile ? screenHeight * 0.25 : screenHeight * 0.30,
      decoration: const BoxDecoration(color: Color(0xFF0d5257)),
      child: Stack(
        children: [
          if (!isMobile)
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
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
              child:
                  isMobile
                      ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Apply Online Now',
                            style: TextStyle(
                              color: Color(0xFFFFA000),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'You must apply for Priority Processing before placing your application.',
                            style: TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            width: 160,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFA000),
                                foregroundColor: Colors.white,
                                elevation: 0,
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
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                          SizedBox(
                            height: 60,
                            width: 160,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFA000),
                                foregroundColor: Colors.white,
                                elevation: 0,
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

  Widget _buildPreparingApplSection(bool isMobile) {
    final links = [
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

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Preparing your application",
                  style: TextStyle(
                    fontSize: 26,
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
          const SizedBox(height: 20),
          Column(
            children:
                links
                    .asMap()
                    .entries
                    .map(
                      (entry) =>
                          _buildLinkItem(entry.key, entry.value, links.length),
                    )
                    .toList(),
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: 450,
            padding: const EdgeInsets.only(top: 40, bottom: 40, right: 20),
            child: const Column(
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
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  links
                      .asMap()
                      .entries
                      .map(
                        (entry) => _buildLinkItem(
                          entry.key,
                          entry.value,
                          links.length,
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLinkItem(int index, String link, int totalItems) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  link,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.arrow_forward,
                color: Color(0xFF0A594C),
                size: 22,
              ),
            ],
          ),
        ),
        if (index < totalItems - 1)
          Container(
            width: double.infinity,
            height: 1,
            child: CustomPaint(
              painter: DottedLinePainter(color: const Color(0xFFfd7e14)),
            ),
          ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 1, color: yellowColor, width: double.infinity);
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF0d5257),
        fontSize: 30,
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildBulletPoint(String text) {
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
            style: const TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
          ),
        ),
      ],
    );
  }

  Widget _buildTaxOfficeFootnote() {
    return const Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text:
                  'Before applying, check the documents you will need and ensure you understand the ',
            ),
            TextSpan(
              text: 'application process.',
              style: TextStyle(
                color: Color(0xFF0d5257),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;

    const dashWidth = 3.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
