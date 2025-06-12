import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vetassess/theme.dart';
import '../widgets/BasePageLayout.dart';

class PriorityProcessing extends StatelessWidget {
  const PriorityProcessing({super.key});

  static const tealColor = Color(0xFF00565B);
  static const yellowColor = Color(0xFFF9C700);
  static const dottedLineColor = Color(0xFF008996);
  static const darkTeal = Color(0xFF0d5257);
  static const amber = Color(0xFFFFA000);
  static const grey = Color(0xFF5A5A5A);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width <= 1024;
    final isDesktop = size.width > 1024;
    final isTabletOrLarger = size.width > 768;
    
    final horizontalPadding = isDesktop ? 150.0 : (isTablet ? 50.0 : 20.0);
     final screenWidth = MediaQuery.of(context).size.width;
    
    final screenHeight = MediaQuery.of(context).size.height;

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(context),
          _buildBreadcrumbs(context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._buildProcessSteps(screenWidth, screenHeight),
                const SizedBox(height: 30),
                _buildSection(context, isTabletOrLarger, 'Who can apply', _whoCanApplyContent()),
                const SizedBox(height: 30),
                _buildEligibilityCategories(isMobile),
                const SizedBox(height: 60),
                _buildSectionTitle('How to Apply'),
                const SizedBox(height: 30),
                _buildApplicationSteps(context),
                const SizedBox(height: 50),
                _buildDivider(),
                const SizedBox(height: 30),
                _buildSection(context, isTabletOrLarger, 'Before you apply', _beforeApplyContent()),
                const SizedBox(height: 50),
                _buildSection(context, isTabletOrLarger, 'What does Priority Processing cost?', _costContent()),
                const SizedBox(height: 50),
                _buildFaqSection(isMobile),
                const SizedBox(height: 50),
                _buildTradesBanner(size.height, isMobile),
                const SizedBox(height: 50),
                _buildPreparingApplSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }


// Refactored Header Banner Widget
Widget _buildHeaderBanner(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final isMobile = ResponsiveUtils.isMobile(context);
  final isTablet = ResponsiveUtils.isTablet(context);
  
  return Container(
    width: size.width,
    height: ResponsiveUtils.getResponsiveHeight(
      context,
      mobile: size.height * 0.40,
      tablet: size.height * 0.45,
      desktop: size.height * 0.50,
    ),
    decoration: const BoxDecoration(color: tealColor),
    child: Stack(
      children: [
        // Background image - only show on tablet and desktop
        if (!isMobile)
          Positioned(
            right: 0,
            child: Image.asset(
              'assets/images/internal_page_banner.png',
              height: ResponsiveUtils.getResponsiveHeight(
                context,
                mobile: size.height * 0.40,
                tablet: size.height * 0.45,
                desktop: size.height * 0.50,
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
        
        // Content container
        Container(
          width: ResponsiveUtils.getResponsiveWidth(
            context,
            mobile: size.width * 0.9,
            tablet: size.width * 0.75,
            desktop: size.width * 0.66,
          ),
          padding: ResponsiveUtils.getResponsivePadding(
            context,
            mobile: const EdgeInsets.only(top: 50, left: 20, right: 20),
            tablet: const EdgeInsets.only(top: 80, left: 50, right: 20),
            desktop: const EdgeInsets.only(top: 100, left: 170, right: 0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Priority Processing",
                style: TextStyle(
                  color: amber,
                  fontSize: ResponsiveUtils.getResponsiveFontSize(
                    context,
                    mobile: 28,
                    tablet: 36,
                    desktop: 42,
                  ),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(
                height: ResponsiveUtils.getResponsiveHeight(
                  context,
                  mobile: 20,
                  tablet: 25,
                  desktop: 30,
                ),
              ),
              Text(
                "Fast track the assessment of your application for a professional or general occupation.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveUtils.getResponsiveFontSize(
                    context,
                    mobile: 14,
                    tablet: 15,
                    desktop: 16,
                  ),
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

// Refactored Breadcrumbs Widget
Widget _buildBreadcrumbs(BuildContext context) {
  final isMobile = ResponsiveUtils.isMobile(context);
  final horizontalPadding = ResponsiveUtils.getResponsiveWidth(
    context,
    mobile: 20,
    tablet: 50,
    desktop: 170,
  );
  
  const linkStyle = TextStyle(
    fontSize: 14,
    color: darkTeal,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
  final greyStyle = TextStyle(color: Colors.grey[600], fontSize: 14);

  final breadcrumbs = [
    ('Home', linkStyle),
    ('Skills Assessment For Migration', linkStyle),
    ('Skills Assessment for professional occupations', linkStyle),
    ('Priority Processing & Urgent Applications', greyStyle),
  ];

  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 12,
      horizontal: horizontalPadding,
    ),
    child: isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: breadcrumbs
                .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(item.$1, style: item.$2),
                    ))
                .toList(),
          )
        : Wrap(
            children: breadcrumbs
                .expand((item) => [
                      TextButton(
                        onPressed: item.$2 == linkStyle ? () {} : null,
                        child: Text(item.$1, style: item.$2),
                      ),
                      if (item != breadcrumbs.last)
                        const Text(
                          ' / ',
                          style: TextStyle(color: Colors.grey),
                        ),
                    ])
                .toList(),
          ),
  );
}

  Widget _buildSection(BuildContext context, bool isTabletOrLarger, String title, List<Widget> content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isTabletOrLarger ? 7 : 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildSectionTitle(title), const SizedBox(height: 20), ...content],
          ),
        ),
        if (isTabletOrLarger) const Expanded(flex: 3, child: SizedBox()),
      ],
    );
  }

  List<Widget> _whoCanApplyContent() => [
    _buildText('When applying for Priority Processing, you must have sufficient supporting evidence, correct fee payment, proof of identity, qualification and employment claims ready to upload to the online form.'),
    _buildText('The 10 business days will start after:'),
    const SizedBox(height: 15),
    _buildBulletPoint('We have confirmed your application meets the eligibility criteria for Priority Processing. This normally takes up to two business days. You will receive an email from us once your application is approved for Priority Processing.'),
    _buildBulletPoint('The fee has been paid and received.'),
  ];

  List<Widget> _beforeApplyContent() {
    final points = [
      'You need to submit all your documents and pay for a standard assessment and the Priority Processing fee at the time you apply. You will not be able to load more documents later because of the tight timeframe for Priority Processing.',
      'Before we accept your application for Priority Processing, we will review if we can meet the deadline of 10 business days for assessment. If you meet the criteria for Priority Processing, it will take us around 2 business days for the review. Once this is approved, you will receive and acceptance email from us.',
      'If we find the submitted documents are misleading, or if we have to investigate if they are authentic, we may conduct additional checks. This is likely to delay the process beyond 10 days.',
      'If your application is assessed as not suitable for Priority Processing, VETASSESS will refund the Priority Processing fee within 3 weeks of notification of non-eligibility. Your application will proceed through the standard process for a full skills assessment.',
    ];

    return [
      _buildText('There are some important requirements to know before you apply for Priority Processing:'),
      _buildText('The 10 business days will start after:'),
      const SizedBox(height: 15),
      ...points.map(_buildBulletPoint),
      const SizedBox(height: 15),
      _buildText('Once the assessment is made, you can download your assessment outcome letter within 48 hours.'),
      const SizedBox(height: 15),
      _buildText('There is an additional cost of \$806, excluding GST, for this services. You must lodge your application online.'),
    ];
  }

  List<Widget> _costContent() => [
    _buildText('There is an additional cost of \$806, excluding GST, for this services.'),
    const SizedBox(height: 10),
    _buildTaxOfficeFootnote(),
  ];

List<Widget> _buildProcessSteps(double screenWidth, double screenHeight) {
  // Determine if we're on a mobile device
  bool isMobile = screenWidth < 768;
  bool isTablet = screenWidth >= 768 && screenWidth < 1024;
  bool isDesktop = screenWidth >= 1024;
  
  // Calculate responsive dimensions
  double horizontalPadding = screenWidth * (isMobile ? 0.05 : isTablet ? 0.08 : 0.1);
  double verticalPadding = screenHeight * (isMobile ? 0.02 : 0.03);
  
  // Responsive font sizes
  double titleFontSize = isMobile ? 18 : isTablet ? 22 : 24;
  double bodyFontSize = isMobile ? 14 : 16;
  
  // Image dimensions
  double imageHeight = isMobile ? 250 : isTablet ? 300 : 400;
  double imageWidth = isMobile ? screenWidth * 0.9 : isTablet ? 600 : 800;
  
  return [
    Container(
      color: AppColors.color12,
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: isMobile 
        ? _buildMobileLayout(screenWidth, titleFontSize, bodyFontSize, imageHeight, imageWidth)
        : _buildDesktopLayout(screenWidth, titleFontSize, bodyFontSize, imageHeight, imageWidth),
    ),
  ];
}

Widget _buildMobileLayout(double screenWidth, double titleFontSize, double bodyFontSize, double imageHeight, double imageWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Text content first on mobile
      Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fast track your application in 10 business days',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF006064),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'If you''re in a hurry and would like to fast track your application, we offer a priority services where we will assess your application in 10 business days for an extra cost of \$806.',
              style: TextStyle(
                fontSize: bodyFontSize,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Priority Processing is available for General and Professional occupations.',
              style: TextStyle(
                fontSize: bodyFontSize,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 24),
      // Image below text on mobile
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/blog_metropolis.jpg',
            height: imageHeight,
            width: imageWidth,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}

Widget _buildDesktopLayout(double screenWidth, double titleFontSize, double bodyFontSize, double imageHeight, double imageWidth) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Text content
      Expanded(
        flex: 5,
        child: Container(
          padding: const EdgeInsets.only(right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fast track your application in 10 business days',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF006064),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'If you''re in a hurry and would like to fast track your application, we offer a priority services where we will assess your application in 10 business days for an extra cost of \$806.',
                style: TextStyle(
                  fontSize: bodyFontSize,
                  height: 1.5,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Priority Processing is available for General and Professional occupations.',
                style: TextStyle(
                  fontSize: bodyFontSize,
                  height: 1.5,
                  letterSpacing: 0.3,fontWeight: FontWeight.bold,color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
      // Image
      Expanded(
        flex: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/blog_metropolis.jpg',
            height: imageHeight,
            width: imageWidth,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}

  Widget _buildApplicationSteps(BuildContext context) {
    final steps = [
      ('1', 'Check Eligibility', 'Check your eligibility for Priority Processing.'),
      ('2', 'Documents', 'Gather required documents for application.'),
      ('3', 'Apply', null),
    ];

    Widget buildStep(step) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNumberedStep(context, step.$1, step.$2),
        SizedBox(height: getResponsiveSpacing(context, mobile: 8, tablet: 10, desktop: 12)),
        if (step.$1 == '3')
          _buildApplyStep(context)
        else
          _buildDescriptionText(context, step.$3!),
      ],
    );

    // Use LayoutBuilder for more precise responsive behavior
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileBreakpoint) {
          return _buildheaderMobileLayout(steps, buildStep, context);
        } else {
          return _buildheaderDesktopLayout(steps, buildStep, context);
        }
      },
    );
  }

  Widget _buildheaderMobileLayout(List<(String, String, String?)> steps, Widget Function(dynamic) buildStep, BuildContext context) {
    return Column(
      children: steps.map((step) => Container(
        margin: EdgeInsets.only(
          bottom: getResponsiveSpacing(context, mobile: 20, tablet: 25, desktop: 30)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStep(step),
            if (step != steps.last)
              Container(
                margin: EdgeInsets.only(
                  top: getResponsiveSpacing(context, mobile: 15, tablet: 18, desktop: 20)
                ),
                height: 2,
                width: getResponsiveSpacing(context, mobile: 80, tablet: 90, desktop: 100),
                color: Colors.amber,
              ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildheaderDesktopLayout(List<(String, String, String?)> steps, Widget Function(dynamic) buildStep, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.expand((step) => [
        Expanded(child: buildStep(step)),
        if (step != steps.last) 
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: getResponsiveSpacing(context, mobile: 25, tablet: 30, desktop: 35)
              ),
              height: 2,
              color: Colors.amber,
            )
          ),
      ]).toList(),
    );
  }

  Widget _buildNumberedStep(BuildContext context, String number, String title) {
    final containerSize = getResponsiveContainerSize(context, mobile: 50, tablet: 55, desktop: 60);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          decoration: const BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.all(Radius.circular(8)), // Added border radius for better design
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, mobile: 32, tablet: 36, desktop: 40),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF006064), // darkTeal
              ),
            ),
          ),
        ),
        SizedBox(height: getResponsiveSpacing(context, mobile: 12, tablet: 14, desktop: 15)),
        Text(
          title,
          style: TextStyle(
            fontSize: getResponsiveFontSize(context, mobile: 20, tablet: 22, desktop: 24),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF006064), // darkTeal
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionText(BuildContext context, String description) {
    return Text(
      description,
      style: TextStyle(
        fontSize: getResponsiveFontSize(context, mobile: 14, tablet: 15, desktop: 16),
        color: Colors.grey, // grey
        height: 1.4, // Added line height for better readability
      ),
    );
  }

  Widget _buildApplyStep(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: getResponsiveFontSize(context, mobile: 14, tablet: 15, desktop: 16),
          color: Colors.grey, // grey
          height: 1.4, // Added line height for better readability
        ),
        children: const [
          TextSpan(text: 'Apply online '),
          TextSpan(
            text: 'here',
            style: TextStyle(
              color: Color(0xFF006064),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: '. You will have the option to select Priority Processing for your application.'),
        ],
      ),
    );
  }
    double getResponsiveFontSize(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  // Responsive spacing
  double getResponsiveSpacing(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
   // Define breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Responsive helper methods
  bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < mobileBreakpoint;
  bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= mobileBreakpoint && 
                                        MediaQuery.of(context).size.width < tabletBreakpoint;
  bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= tabletBreakpoint;


  // Responsive container size
  double getResponsiveContainerSize(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }


  Widget _buildEligibilityCategories(bool isMobile) {
    final eligible = ['New full skills assessment applications', 'Positively assessed renewal applications', 'Returning applicants for assessment under a change of occupation'];
    final ineligible = ['Negatively assessed renewal applications', 'Returning applicants with a negative outcome for previous full skills assessment are not eligible', 'Applications for Review and Appeal'];

    Widget buildBox(String title, List<String> items) => Expanded(
      child: Container(
        height: 280, padding: const EdgeInsets.all(20), color: const Color(0xFFF2F2F2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTeal)),
            const SizedBox(height: 20),
            ...items.map((item) => Padding(padding: const EdgeInsets.only(bottom: 10), child: _buildBulletPoint(item))),
          ],
        ),
      ),
    );

    return isMobile
        ? Column(children: [buildBox('Applicants eligible for Priority Processing', eligible), const SizedBox(height: 20), buildBox('Applicants ineligible for Priority Processing', ineligible)])
        : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [buildBox('Applicants eligible for Priority Processing', eligible), const SizedBox(width: 20), buildBox('Applicants ineligible for Priority Processing', ineligible)]);
  }

  Widget _buildFaqSection(bool isMobile) {
    final faqTitles = [
      'How can VETASSESS be sure it can process my application in 10 business days?',
      'What if my application for Priority Processing is not accepted?',
      'I\'ve applied for the standard services. Can I change to Priority Processing?',
      'Once my application for Priority Processing is accepted, can I change my occupation?',
      'What happens if you cannot process my priority processing application within 10 business days?',
      "What happens if my occupation is removed from the Australian Government's Department of Home Affairs list of eligible occupations during Priority Processing?",
    ];

    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text("Explore FAQs", style: TextStyle(fontSize: isMobile ? 28 : 32, fontWeight: FontWeight.w700, color: const Color(0xFF0A594C), height: 1.3)),
        const SizedBox(height: 24),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              const Text("View all", style: TextStyle(fontSize: 16, decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Color(0xFF0A594C))),
              const SizedBox(width: 10),
              Container(
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFF0A594C), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ],
    );

    final faqList = Column(children: faqTitles.map(_buildFaqItem).toList());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 60),
      child: isMobile
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [header, const SizedBox(height: 40), faqList])
          : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: header), Expanded(flex: 2, child: Container(padding: const EdgeInsets.only(top: 6), child: faqList))]),
    );
  }

  Widget _buildFaqItem(String title) => Theme(
    data: ThemeData(dividerColor: Colors.transparent, colorScheme: const ColorScheme.light(surfaceTint: Colors.transparent, primary: Color(0xFF0A594C))),
    child: Column(
      children: [
        ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(vertical: 20),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.only(left: 50, bottom: 16, right: 20),
          leading: Container(
            width: 32, height: 32,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF0A594C), width: 3)),
            child: const Icon(Icons.add, color: Color(0xFF0A594C), size: 22),
          ),
          title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF0A594C))),
          trailing: const SizedBox.shrink(),
          children: const [Text('This is the answer to the FAQ question.', style: TextStyle(fontSize: 15, height: 1.5))],
        ),
        SizedBox(width: double.infinity, height: 1, child: CustomPaint(painter: DottedLinePainter(color: dottedLineColor))),
      ],
    ),
  );

  Widget _buildTradesBanner(double screenHeight, bool isMobile) {
    final content = isMobile
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Apply Online Now', style: TextStyle(color: amber, fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 0.5), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              const Text('You must apply for Priority Processing before placing your application.', style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 16, letterSpacing: 0.5), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              SizedBox(height: 60, width: 160, child: _buildApplyButton()),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Apply Online Now', style: TextStyle(color: amber, fontSize: 26, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                  SizedBox(height: 8),
                  Text('You must apply for Priority Processing before placing your application.', style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 16, letterSpacing: 0.5)),
                ],
              ),
              SizedBox(height: 60, width: 160, child: _buildApplyButton()),
            ],
          );

    return Container(
      width: double.infinity,
      height: isMobile ? screenHeight * 0.25 : screenHeight * 0.30,
      decoration: const BoxDecoration(color: darkTeal),
      child: Stack(
        children: [
          if (!isMobile)
            Positioned(
              right: 0.95, bottom: 0,
              child: SvgPicture.asset('assets/images/vet.svg', width: screenHeight * 0.1, height: screenHeight * 0.3),
            ),
          Center(child: Container(padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40), child: content)),
        ],
      ),
    );
  }

  Widget _buildApplyButton() => ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: amber, foregroundColor: Colors.white, elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    child: const Text("Apply Online", style: TextStyle(color: Colors.black)),
  );

Widget _buildPreparingApplSection() {
  final List<String> links = [
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

  return Builder(
    builder: (context) {
      // Get screen dimensions using MediaQuery
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      
      // Determine device type based on screen width
      bool isMobile = screenWidth < 768;
      bool isTablet = screenWidth >= 768 && screenWidth < 1024;
      bool isDesktop = screenWidth >= 1024;

      // Responsive values based on MediaQuery
      double horizontalPadding = _getResponsivePadding(screenWidth);
      double titleFontSize = _getpreparingResponsiveTitleFontSize(screenWidth);
      double descriptionFontSize = _getpreparingResponsiveDescriptionFontSize(screenWidth);
      double linkFontSize = _getResponsiveLinkFontSize(screenWidth);
      double iconSize = _getResponsiveIconSize(screenWidth);
      double containerSize = _getResponsiveContainerSize(screenWidth);
      double verticalSpacing = _getResponsiveVerticalSpacing(screenWidth);

      return Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: isMobile
            ? _buildMobileLayouts(
                links: links,
                titleFontSize: titleFontSize,
                descriptionFontSize: descriptionFontSize,
                linkFontSize: linkFontSize,
                iconSize: iconSize,
                containerSize: containerSize,
                verticalSpacing: verticalSpacing,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              )
            : _buildDesktopTabletLayout(
                links: links,
                titleFontSize: titleFontSize,
                descriptionFontSize: descriptionFontSize,
                linkFontSize: linkFontSize,
                iconSize: iconSize,
                containerSize: containerSize,
                verticalSpacing: verticalSpacing,
                isTablet: isTablet,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
      );
    },
  );
}

// Responsive helper methods using MediaQuery values
double _getResponsivePadding(double screenWidth) {
  if (screenWidth < 480) return 16.0;
  if (screenWidth < 768) return 24.0;
  if (screenWidth < 1024) return 32.0;
  return 50.0;
}

double _getpreparingResponsiveTitleFontSize(double screenWidth) {
  if (screenWidth < 480) return 22.0;
  if (screenWidth < 768) return 24.0;
  if (screenWidth < 1024) return 26.0;
  return 28.0;
}

double _getpreparingResponsiveDescriptionFontSize(double screenWidth) {
  if (screenWidth < 768) return 14.0;
  return 15.0;
}

double _getResponsiveLinkFontSize(double screenWidth) {
  if (screenWidth < 768) return 14.0;
  return 16.0;
}

double _getResponsiveIconSize(double screenWidth) {
  if (screenWidth < 480) return 18.0;
  if (screenWidth < 768) return 20.0;
  return 22.0;
}

double _getResponsiveContainerSize(double screenWidth) {
  if (screenWidth < 480) return 26.0;
  if (screenWidth < 768) return 28.0;
  if (screenWidth < 1024) return 30.0;
  return 32.0;
}

double _getResponsiveVerticalSpacing(double screenWidth) {
  if (screenWidth < 768) return 30.0;
  return 40.0;
}

// Mobile layout - stacked vertically
Widget _buildMobileLayouts({
  required List<String> links,
  required double titleFontSize,
  required double descriptionFontSize,
  required double linkFontSize,
  required double iconSize,
  required double containerSize,
  required double verticalSpacing,
  required double screenWidth,
  required double screenHeight,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title and description section
      Container(
        width: screenWidth,
        padding: EdgeInsets.only(
          top: verticalSpacing,
          bottom: verticalSpacing * 0.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Preparing your application",
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0A594C),
                height: 1.3,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'A VETASSESS Skills Assessment involves assessing both your qualifications and your employment experience. Your qualifications will be compared with the Australian Qualifications Framework (AQF) and your employment experience will be assessed to determine whether it is relevant and at an appropriate skill level.',
              style: TextStyle(
                fontSize: descriptionFontSize,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),

      // Links section
      Container(
        width: screenWidth,
        padding: EdgeInsets.only(bottom: verticalSpacing),
        child: Column(
          children: links.asMap().entries.map((entry) {
            final int index = entry.key;
            final String link = entry.value;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          link,
                          style: TextStyle(
                            fontSize: linkFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        width: containerSize,
                        height: containerSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF0A594C),
                          size: iconSize,
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < links.length - 1)
                  _buildDottedLine(color: Color(0xFFfd7e14)),
              ],
            );
          }).toList(),
        ),
      ),
    ],
  );
}

// Desktop and tablet layout - side by side
Widget _buildDesktopTabletLayout({
  required List<String> links,
  required double titleFontSize,
  required double descriptionFontSize,
  required double linkFontSize,
  required double iconSize,
  required double containerSize,
  required double verticalSpacing,
  required bool isTablet,
  required double screenWidth,
  required double screenHeight,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Left column - Title and description
      Expanded(
        flex: 2,
        child: Container(
          width: screenWidth * (isTablet ? 0.55 : 0.6), // Responsive width based on screen
          padding: EdgeInsets.only(
            top: verticalSpacing,
            bottom: verticalSpacing,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Preparing your application",
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0A594C),
                  height: 1.3,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'A VETASSESS Skills Assessment involves assessing both your qualifications and your employment experience. Your qualifications will be compared with the Australian Qualifications Framework (AQF) and your employment experience will be assessed to determine whether it is relevant and at an appropriate skill level.',
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),

      // Right column - Navigation links with dotted lines
      Expanded(
        flex: 1,
        child: Container(
          width: screenWidth * (isTablet ? 0.35 : 0.3), // Responsive width based on screen
          padding: EdgeInsets.only(
            top: verticalSpacing,
            bottom: verticalSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: links.asMap().entries.map((entry) {
              final int index = entry.key;
              final String link = entry.value;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            link,
                            style: TextStyle(
                              fontSize: linkFontSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: containerSize,
                          height: containerSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF0A594C),
                            size: iconSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index < links.length - 1)
                    _buildDottedLine(color: Color(0xFFfd7e14)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    ],
  );
}
// Helper method for dotted line (you'll need to implement this)
Widget _buildDottedLine({required Color color}) {
  return Container(
    width: double.infinity,
    height: 1,
    child: CustomPaint(
      painter: DottedLinePainter(color: color),
    ),
  );
}

  Widget _buildDivider() => Container(height: 1, color: yellowColor, width: double.infinity);
  Widget _buildSectionTitle(String title) => Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: darkTeal, fontSize: 30));
  Widget _buildText(String text) => Padding(padding: const EdgeInsets.only(top: 8.0), child: Text(text, style: const TextStyle(fontSize: 16)));
  
  Widget _buildBulletPoint(String text) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('• ', style: TextStyle(fontSize: 16, color: grey, fontWeight: FontWeight.bold)),
      Expanded(child: Text(text, style: const TextStyle(fontSize: 16, color: grey))),
    ],
  );

  Widget _buildTaxOfficeFootnote() => const Padding(
    padding: EdgeInsets.only(top: 16.0),
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'Before applying, check the documents you will need and ensure you understand the '),
          TextSpan(text: 'application process.', style: TextStyle(color: darkTeal, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 1..strokeCap = StrokeCap.round;
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
// Add this responsive utility class at the top of your file
class ResponsiveUtils {
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;
  
  static double getResponsiveWidth(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
  
  static double getResponsiveHeight(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
  
  static double getResponsiveFontSize(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
  
  static EdgeInsets getResponsivePadding(BuildContext context, {
    required EdgeInsets mobile,
    required EdgeInsets tablet,
    required EdgeInsets desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
}

// Alternative approach using MediaQuery.textScaleFactor for accessibility
class ResponsiveApplicationStepsAdvanced extends StatelessWidget {
  const ResponsiveApplicationStepsAdvanced({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildApplicationSteps(context);
  }

  Widget _buildApplicationSteps(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final textScaleFactor = mediaQuery.textScaleFactor;
    
    // Responsive breakpoints with consideration for text scaling
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    
    final steps = [
      ('1', 'Check Eligibility', 'Check your eligibility for Priority Processing.'),
      ('2', 'Documents', 'Gather required documents for application.'),
      ('3', 'Apply', null),
    ];

    Widget buildStep(step) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNumberedStep(context, step.$1, step.$2, isMobile, isTablet),
        SizedBox(height: isMobile ? 8 : (isTablet ? 10 : 12)),
        if (step.$1 == '3')
          _buildApplyStep(context, isMobile, isTablet, textScaleFactor)
        else
          _buildDescriptionText(context, step.$3!, isMobile, isTablet, textScaleFactor),
      ],
    );

    if (isMobile) {
      return Column(
        children: steps.map((step) => Container(
          margin: EdgeInsets.only(bottom: isMobile ? 20 : 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildStep(step),
              if (step != steps.last)
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 2,
                  width: isMobile ? 80 : 100,
                  color: Colors.amber,
                ),
            ],
          ),
        )).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.expand((step) => [
        Expanded(child: buildStep(step)),
        if (step != steps.last) 
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: isMobile ? 25 : (isTablet ? 30 : 35)),
              height: 2,
              color: Colors.amber,
            )
          ),
      ]).toList(),
    );
  }

  Widget _buildNumberedStep(BuildContext context, String number, String title, bool isMobile, bool isTablet) {
    final containerSize = isMobile ? 50.0 : (isTablet ? 55.0 : 60.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          decoration: const BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: isMobile ? 32 : (isTablet ? 36 : 40),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF006064),
              ),
            ),
          ),
        ),
        SizedBox(height: isMobile ? 12 : (isTablet ? 14 : 15)),
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 20 : (isTablet ? 22 : 24),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF006064),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionText(BuildContext context, String description, bool isMobile, bool isTablet, double textScaleFactor) {
    return Text(
      description,
      style: TextStyle(
        fontSize: (isMobile ? 14 : (isTablet ? 15 : 16)) / textScaleFactor.clamp(1.0, 1.3),
        color: Colors.grey,
        height: 1.4,
      ),
    );
  }

  Widget _buildApplyStep(BuildContext context, bool isMobile, bool isTablet, double textScaleFactor) {
    final baseFontSize = (isMobile ? 14 : (isTablet ? 15 : 16)) / textScaleFactor.clamp(1.0, 1.3);
    
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: baseFontSize,
          color: Colors.grey,
          height: 1.4,
        ),
        children: const [
          TextSpan(text: 'Apply online '),
          TextSpan(
            text: 'here',
            style: TextStyle(
              color: Color(0xFF006064),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: '. You will have the option to select Priority Processing for your application.'),
        ],
      ),
    );
  }
}

