import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/BasePageLayout.dart';
import '../widgets/steps_section.dart';

class ApplicationProcess extends StatelessWidget {
  const ApplicationProcess({super.key});

  // Color constants
  static const Color tealColor = Color(0xFF00565B);
  static const Color yellowColor = Color(0xFFF9C700);
  static const Color dottedLineColor = Color(0xFF008996);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 1100;

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(screenHeight, screenWidth),
          _buildBreadcrumbs(),
          _buildMainContent(context),
          ProcessStepsSection(),
          _buildKeyTermsSection(
            'Key terms for Qualifications\nAssessment Criteria',
            [
              'What is a highly relevant area of study?',
              'What is study at the required educational level?',
            ],
            true,
            context,
          ),
          SizedBox(height: 20),
          _buildKeyTermsSection(
            'Key terms for Employment\nAssessment Criteria',
            [
              'What is a highly relevant employment?',
              'What is pre- and post-qualification employment?',
              'What is Date Deemed Skilled?',
              'What is closely related employment?',
            ],
            false,
            context,
          ),
          SizedBox(height: screenHeight / 6),
          _buildAfterApplicationSection(),
          _buildFaqSection(
            title: 'Explore FAQs',
            items: [
              'How can VETASSESS be sure it can process my application in 10 business days?',
              'What if my application for Priority Processing is not accepted?',
              "I've applied for the standard services. Can I change to Priority Processing?",
              'Once my application for Priority Processing is accepted, can I change my occupation?',
              'What happens if you cannot process my priority processing application within 10 business days?',
              "What happens if my occupation is removed from the Australian Government's Department of Home Affairs list of eligible occupations during Priority Processing?",
            ],
            isExpansionPanel: true,
          ),
          _buildPreparingApplSection(),
          _buildApplyBanner(),
        ],
      ),
    );
  }

Widget _buildHeaderBanner(double screenHeight, double screenWidth) {
  final isMobile = ResponsiveHelper.isMobile(screenWidth);
  final isTablet = ResponsiveHelper.isTablet(screenWidth);
  
  return Container(
    width: screenWidth,
    height: isMobile ? screenHeight * 0.60 : screenHeight * 0.70,
    decoration: const BoxDecoration(color: tealColor),
    child: Stack(
      children: [
        // Background image - adjust positioning for mobile
        Positioned(
          right: isMobile ? -50 : 0,
          child: Image.asset(
            'assets/images/internal_page_banner.png',
            height: isMobile ? screenHeight * 0.60 : screenHeight * 0.70,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          width: isMobile ? screenWidth * 0.95 : (isTablet ? screenWidth * 0.80 : screenWidth * 0.66),
          padding: EdgeInsets.only(
            top: ResponsiveHelper.getResponsivePadding(100, screenWidth),
            left: ResponsiveHelper.getResponsivePadding(35, screenWidth),
            right: isMobile ? ResponsiveHelper.getResponsivePadding(20, screenWidth) : 0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Text(
                  isMobile 
                    ? "Application process for a professional or general skills application"
                    : "Application process for a \nprofessional or general \nskills application",
                  style: TextStyle(
                    color: const Color(0xFFFFA000),
                    fontSize: ResponsiveHelper.getResponsiveFontSize(42, screenWidth),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    height: isMobile ? 1.2 : null,
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.getResponsivePadding(30, screenWidth),
                ),
                Text(
                  isMobile
                    ? "Start your migration journey by applying for a skills assessment for your professional occupation."
                    : "Start your migration journey by applying for a skills assessment for your professional \noccupation.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveHelper.getResponsiveFontSize(16, screenWidth),
                    height: 1.5,
                    letterSpacing: 0.3,
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

Widget _buildBreadcrumbs() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final isMobile = ResponsiveHelper.isMobile(screenWidth);
      
      const TextStyle linkStyle = TextStyle(
        fontSize: 14,
        color: tealColor,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      );
      
      final TextStyle responsiveLinkStyle = TextStyle(
        fontSize: ResponsiveHelper.getResponsiveFontSize(14, screenWidth),
        color: tealColor,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      );
      
      final TextStyle responsiveGreyStyle = TextStyle(
        color: Colors.grey,
        fontSize: ResponsiveHelper.getResponsiveFontSize(14, screenWidth),
      );

      if (isMobile) {
        // Mobile: Stack breadcrumbs vertically or wrap them
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveHelper.getResponsivePadding(10, screenWidth),
            horizontal: ResponsiveHelper.getResponsivePadding(20, screenWidth),
          ),
          child: Wrap(
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Home', style: responsiveLinkStyle),
              ),
              Text(' / ', style: responsiveGreyStyle),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Skills Assessment',
                  style: responsiveLinkStyle,
                ),
              ),
              Text(' / ', style: responsiveGreyStyle),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Professional occupations',
                  style: responsiveLinkStyle,
                ),
              ),
              Text(' / ', style: responsiveGreyStyle),
              Text(
                'Application process',
                style: TextStyle(
                  color: Colors.grey[600], 
                  fontSize: ResponsiveHelper.getResponsiveFontSize(14, screenWidth),
                ),
              ),
            ],
          ),
        );
      }

      // Desktop/Tablet: Keep original horizontal layout
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveHelper.getResponsivePadding(10, screenWidth),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Home', style: responsiveLinkStyle),
              ),
              Text(' / ', style: responsiveGreyStyle),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Skills Assessment For Migration',
                  style: responsiveLinkStyle,
                ),
              ),
              Text(' / ', style: responsiveGreyStyle),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Skills Assessment for professional occupations',
                  style: responsiveLinkStyle,
                ),
              ),
              Text(' / ', style: responsiveGreyStyle),
              Text(
                'Application process for a professional or general skills application',
                style: TextStyle(
                  color: Colors.grey[600], 
                  fontSize: ResponsiveHelper.getResponsiveFontSize(14, screenWidth),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
  Widget _buildMainContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    
    // Define responsive breakpoints
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    
    // Responsive padding
    final horizontalPadding = isMobile 
        ? 16.0 
        : isTablet 
            ? 40.0 
            : screenWidth * 0.1; // 10% of screen width for desktop
    
    final topPadding = isMobile ? 20.0 : 50.0;
    final bottomPadding = isMobile ? 40.0 : 100.0;

    return Container(
      padding: EdgeInsets.only(
        top: topPadding,
        right: horizontalPadding,
        left: horizontalPadding,
        bottom: bottomPadding,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with responsive font size
          Text(
            'Application Process',
            style: TextStyle(
              fontSize: isMobile ? 24 : isTablet ? 28 : 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF006064),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          
          // Content container with responsive width
          Container(
            padding: EdgeInsets.only(
              bottom: isMobile ? 60 : isTablet ? 100 : 150
            ),
            width: isMobile 
                ? double.infinity 
                : isTablet 
                    ? screenWidth * 0.8 
                    : screenWidth * 0.55,
            child: Column(
              children: [
                _buildResponsiveText(
                  'A VETASSESS full skills assessment involves assessing your qualifications and employment against the suitability of your nominated occupation.',
                  isMobile,
                ),
                SizedBox(height: isMobile ? 16 : 24),
                _buildResponsiveText(
                  'We assess your qualification/s against the Australian Qualifications Framework (AQF) and to determine the relevance of your qualifications for your nominated occupation. Employment assessment involves determining whether your work experience - whether in Australia or overseas - is at an appropriate skill level to your nominated occupation.',
                  isMobile,
                ),
                SizedBox(height: isMobile ? 16 : 24),
                _buildResponsiveText(
                  'You need a positive assessment of both your qualifications and your employment for your skills assessment to be successful.',
                  isMobile,
                ),
              ],
            ),
          ),
          _buildTradesBanner(context),
        ],
      ),
    );
  }

  Widget _buildResponsiveText(String text, bool isMobile) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isMobile ? 14 : 16,
        height: 1.5,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildTradesBanner(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final screenWidth = size.width;
        final screenHeight = size.height;
        
        // Responsive breakpoints
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth >= 600 && screenWidth < 1024;
        final isDesktop = screenWidth >= 1024;
        
        // Responsive dimensions with safe constraints
        final bannerHeight = isMobile 
            ? 200.0 // Fixed height for mobile to avoid overflow
            : isTablet 
                ? screenHeight * 0.25 
                : screenHeight * 0.3;
                
        final svgSize = isMobile 
            ? 120.0 
            : isTablet 
                ? screenHeight * 0.16 
                : screenHeight * 0.18;
                
        final horizontalPadding = isMobile 
            ? 16.0 
            : isTablet 
                ? 40.0 
                : 80.0;
                
        final fontSize = isMobile 
            ? 18.0 
            : isTablet 
                ? 24.0 
                : 28.0;
                
        final buttonWidth = isMobile 
            ? 100.0 
            : isTablet 
                ? 120.0 
                : 150.0;

        return Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 150, // Minimum height to prevent too small banners
            maxHeight: screenHeight * 0.4, // Maximum height to prevent overflow
          ),
          height: bannerHeight,
          decoration: const BoxDecoration(color: tealColor),
          child: Stack(
            children: [
              // Background SVG - only show on larger screens to avoid clutter
              if (!isMobile)
                Positioned(
                  left: 0,
                  top: 0,
                  child: SvgPicture.asset(
                    'assets/images/vet.svg',
                    width: svgSize,
                    height: bannerHeight,
                    fit: BoxFit.contain, // Changed to contain to prevent overflow
                  ),
                ),
              
              // Content
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: isMobile
                      ? _buildMobileLayout(fontSize, buttonWidth)
                      : _buildDesktopLayout(fontSize, buttonWidth),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Layout for mobile devices (stacked vertically)
  Widget _buildMobileLayout(double fontSize, double buttonWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            'Looking for the trades assessment process?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFFFA000),
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildActionButton("Go Here", buttonWidth),
      ],
    );
  }

  // Layout for tablet and desktop (horizontal)
  Widget _buildDesktopLayout(double fontSize, double buttonWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            'Looking for the trades assessment process?',
            style: TextStyle(
              color: const Color(0xFFFFA000),
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 20),
        _buildActionButton("Go Here", buttonWidth),
      ],
    );
  }




Widget _buildKeyTermsSection(
  String sectionTitle,
  List<String> expandableTitles,
  bool includeParagraphs,
  BuildContext context,
) {
  // Get screen dimensions
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  // Calculate responsive dimensions
  final horizontalPadding = screenWidth * 0.05; // 5% of screen width
  final verticalPadding = screenHeight * 0.03; // 3% of screen height
  final leftColumnWidth = screenWidth > 800 
      ? screenWidth * 0.3 // 30% for larger screens
      : screenWidth * 0.35; // 35% for smaller screens
  
  // Responsive font sizes
  final titleFontSize = screenWidth > 800 ? 28.0 : 24.0;
  final expandableFontSize = screenWidth > 800 ? 16.0 : 14.0;
  final paragraphFontSize = screenWidth > 800 ? 15.0 : 13.0;

  // Generate expandable sections
  List<Widget> expandableSections = _buildExpandableSections(
    expandableTitles,
    includeParagraphs,
    context,
  );

  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Yellow top divider
        Container(
          margin: EdgeInsets.only(bottom: screenHeight * 0.02),
          height: 1,
          color: yellowColor,
        ),
        // Main content with responsive layout
        screenWidth > 600
            ? _buildTwoColumnLayout(
                sectionTitle,
                expandableSections,
                leftColumnWidth,
                titleFontSize,
                context,
              )
            : _buildSingleColumnLayout(
                sectionTitle,
                expandableSections,
                titleFontSize,
                context,
              ),
      ],
    ),
  );
}

Widget _buildTwoColumnLayout(
  String sectionTitle,
  List<Widget> expandableSections,
  double leftColumnWidth,
  double titleFontSize,
  BuildContext context,
) {
  final screenHeight = MediaQuery.of(context).size.height;
  final responsivePadding = screenHeight * 0.02;

  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column - Title only
        Container(
          width: leftColumnWidth,
          padding: EdgeInsets.fromLTRB(
            responsivePadding,
            responsivePadding,
            0,
            responsivePadding,
          ),
          child: Text(
            sectionTitle,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: tealColor,
              height: 1.3,
            ),
          ),
        ),
        // Right column - Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: expandableSections,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSingleColumnLayout(
  String sectionTitle,
  List<Widget> expandableSections,
  double titleFontSize,
  BuildContext context,
) {
  final screenHeight = MediaQuery.of(context).size.height;
  final responsivePadding = screenHeight * 0.02;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title section
      Padding(
        padding: EdgeInsets.fromLTRB(
          responsivePadding,
          responsivePadding,
          responsivePadding,
          responsivePadding,
        ),
        child: Text(
          sectionTitle,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w700,
            color: tealColor,
            height: 1.3,
          ),
        ),
      ),
      // Expandable sections
      ...expandableSections,
    ],
  );
}

List<Widget> _buildExpandableSections(
  List<String> expandableTitles,
  bool includeParagraphs,
  BuildContext context,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  // Responsive dimensions
  final horizontalPadding = screenWidth * 0.02;
  final verticalPadding = screenHeight * 0.01;
  final expandableFontSize = screenWidth > 800 ? 16.0 : 14.0;
  final paragraphFontSize = screenWidth > 800 ? 15.0 : 13.0;
  
  List<Widget> expandableSections = [];

  for (int i = 0; i < expandableTitles.length; i++) {
    // Add expandable tile
    expandableSections.add(
      Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(surfaceTint: Colors.transparent),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.fromLTRB(
            horizontalPadding * 1.2,
            i == 0 ? verticalPadding * 2.4 : verticalPadding * 1.2,
            horizontalPadding * 1.2,
            verticalPadding * 1.2,
          ),
          title: Text(
            expandableTitles[i],
            style: TextStyle(
              fontSize: expandableFontSize,
              fontWeight: FontWeight.w600,
              color: tealColor,
            ),
          ),
          trailing: _buildCircleIcon(Icons.add, tealColor),
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding * 1.2,
                0,
                horizontalPadding * 1.2,
                verticalPadding * 1.6,
              ),
              child: Text(
                'Content for required educational level',
                style: TextStyle(
                  fontSize: paragraphFontSize,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Add dotted line separator if not the last item
    if (i < expandableTitles.length - 1 || includeParagraphs) {
      expandableSections.add(_buildDottedLine(color: Color(0xFFfd7e14)));
    }
  }

  // Add text paragraphs if required
  if (includeParagraphs) {
    final textStyle = TextStyle(
      fontSize: paragraphFontSize,
      color: Colors.black87,
      height: 1.5,
    );
    
    final List<String> paragraphs = [
      'Please note that we will not be assessing an Australian Graduate Diploma or comparable overseas postgraduate diploma, either alone or in combination with underpinning sub-degree qualifications, for comparability to the educational level of an Australian Bachelor degree.',
      'This is based on the different nature and learning outcomes of an Australian Bachelor degree compared to other qualifications on the AQF.',
      'Therefore, a qualification assessed at AQF Graduate Diploma level cannot be used to meet the requirements of occupations that require a minimum of an AQF Bachelor degree level.',
      'The Postgraduate Diploma may, however, be considered for assessment against the requirements of occupations which require a qualification at AQF Diploma or Advanced Diploma/ Associate degree level.',
    ];

    for (int i = 0; i < paragraphs.length; i++) {
      expandableSections.add(
        Padding(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding * 1.2,
            verticalPadding * 2.4,
            horizontalPadding * 1.2,
            i < paragraphs.length - 1 ? 0 : verticalPadding * 2.4,
          ),
          child: Text(paragraphs[i], style: textStyle),
        ),
      );

      if (i < paragraphs.length - 1) {
        expandableSections.add(SizedBox(height: verticalPadding * 2.4));
      }
    }
  }

  return expandableSections;
}

Widget _buildAfterApplicationSection() {
  return Builder(
    builder: (context) {
      final screenSize = MediaQuery.of(context).size;
      final screenWidth = screenSize.width;
      final screenHeight = screenSize.height;
      
      // Clean responsive breakpoints
      final bool isMobile = screenWidth < 768;
      final bool isTablet = screenWidth >= 768 && screenWidth < 1024;
      final bool isDesktop = screenWidth >= 1024;
      
      // Responsive scaling factor
      final double scaleFactor = isMobile ? 0.8 : 1.0;
      
      return Container(
        width: double.infinity,
        color: Color(0xfff2f2f2),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : (isTablet ? 80.0 : 170.0),
          vertical: isMobile ? 24.0 : 40.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'After your application',
              style: TextStyle(
                fontSize: isMobile ? 22.0 : (isTablet ? 26.0 : 28.0),
                fontWeight: FontWeight.bold,
                color: tealColor,
              ),
            ),
            SizedBox(height: 16.0 * scaleFactor),
            Text(
              'You can ask for a review or an appeal of a VETASSESS skills assessment outcome, and you can apply to \nhave your skills assessed against another occupation.',
              style: TextStyle(
                fontSize: isMobile ? 14.0 : 16.0,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30.0 * scaleFactor),
            isDesktop 
                ? _buildOptionsGrid(
                    screenWidth: screenWidth,
                    isMobile: isMobile,
                    isTablet: isTablet,
                  )
                : _buildOptionsColumn(
                    isMobile: isMobile,
                    scaleFactor: scaleFactor,
                  ),
            SizedBox(height: 40.0 * scaleFactor),
          ],
        ),
      );
    },
  );
}

Widget _buildOptionsGrid({
  required double screenWidth,
  required bool isMobile,
  required bool isTablet,
}) {
  final List<Map<String, String>> options = _getOptionData();
  
  // Clean grid configuration
  final int crossAxisCount = screenWidth < 1200 ? 2 : 3;
  final double spacing = isTablet ? 18.0 : 20.0;
  final double aspectRatio = isTablet ? 1.1 : 1.05;

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: aspectRatio,
    ),
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: options.length,
    itemBuilder: (context, index) {
      final option = options[index];
      return _buildOptionCard(
        option['title']!,
        option['description']!,
        isMobile: isMobile,
        isTablet: isTablet,
      );
    },
  );
}

Widget _buildOptionsColumn({
  required bool isMobile,
  required double scaleFactor,
}) {
  final List<Map<String, String>> options = _getOptionData();

  return Column(
    children: options.asMap().entries.map((entry) {
      final option = entry.value;
      final isLast = entry.key == options.length - 1;
      
      return Column(
        children: [
          _buildOptionCard(
            option['title']!,
            option['description']!,
            isMobile: isMobile,
            isTablet: false,
          ),
          if (!isLast) SizedBox(height: 20.0 * scaleFactor),
        ],
      );
    }).toList(),
  );
}

List<Map<String, String>> _getOptionData() {
  return [
    {
      'title': 'Renew your Application',
      'description':
          'Find out how to renew your application before it expires.',
    },
    {
      'title': 'Apply for Review',
      'description':
          'If you disagree with your unsuccessful skills assessment outcome, you can ask for a review of the decision.',
    },
    {
      'title': 'Apply for Reassessment',
      'description':
          'You can apply for a reassessment with a change of occupation.',
    },
    {
      'title': 'Provide Feedback',
      'description':
          'The team at VETASSESS will gladly receive and respond to all feedback from customers in a professional, timely and respectful manner. We aim to respond to all feedback within ten business days.',
    },
  ];
}

Widget _buildOptionCard(
  String title,
  String description, {
  required bool isMobile,
  required bool isTablet,
}) {
  // Clean responsive values
  final double cardPadding = isMobile ? 12.0 : 14.0;
  final double titleFontSize = isMobile ? 18.0 : (isTablet ? 19.0 : 20.0);
  final double descriptionFontSize = isMobile ? 14.0 : 16.0;
  final double buttonFontSize = isMobile ? 14.0 : 16.0;
  final double iconSize = isMobile ? 16.0 : 18.0;
  final double containerSize = isMobile ? 28.0 : 32.0;
  final double underlineWidth = isMobile ? 75.0 : 90.0;

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(cardPadding),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade200, width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.05),
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: tealColor,
          ),
        ),
        SizedBox(height: isMobile ? 10.0 : 12.0),
        Flexible(
          child: Text(
            description,
            style: TextStyle(
              fontSize: descriptionFontSize,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 12.0 : 16.0),
        _buildViewMoreButton(
          fontSize: buttonFontSize,
          iconSize: iconSize,
          containerSize: containerSize,
          underlineWidth: underlineWidth,
        ),
      ],
    ),
  );
}

Widget _buildViewMoreButton({
  required double fontSize,
  required double iconSize,
  required double containerSize,
  required double underlineWidth,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'View more',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: tealColor,
            ),
          ),
          Container(
            width: underlineWidth,
            height: 2,
            color: tealColor,
            margin: EdgeInsets.only(top: 3),
          ),
        ],
      ),
      const SizedBox(width: 8),
      Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: tealColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    ],
  );
}

 Widget _buildFaqSection({
  required String title,
  required List<String> items,
  bool isExpansionPanel = false,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      
      // Responsive breakpoints
      final bool isMobile = screenWidth < 768;
      final bool isTablet = screenWidth >= 768 && screenWidth < 1024;
      final bool isDesktop = screenWidth >= 1024;
      
      // Responsive values
      final double horizontalPadding = isMobile 
          ? 16 
          : isTablet 
              ? 40 
              : screenWidth * 0.08; // 8% of screen width for desktop
      
      final double verticalPadding = isMobile 
          ? 32 
          : isTablet 
              ? 48 
              : 60;
      
      final double titleFontSize = isMobile 
          ? 24 
          : isTablet 
              ? 28 
              : 32;
      
      final double viewAllFontSize = isMobile 
          ? 14 
          : 16;
      
      final Color sectionColor = Color(0xFF0A594C);

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: isMobile
            ? _buildFaqMobileLayout(
                title: title,
                items: items,
                isExpansionPanel: isExpansionPanel,
                sectionColor: sectionColor,
                titleFontSize: titleFontSize,
                viewAllFontSize: viewAllFontSize,
              )
            : _buildFaqDesktopLayout(
                title: title,
                items: items,
                isExpansionPanel: isExpansionPanel,
                sectionColor: sectionColor,
                titleFontSize: titleFontSize,
                viewAllFontSize: viewAllFontSize,
                isTablet: isTablet,
              ),
      );
    },
  );
}

Widget _buildFaqMobileLayout({
  required String title,
  required List<String> items,
  required bool isExpansionPanel,
  required Color sectionColor,
  required double titleFontSize,
  required double viewAllFontSize,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title section
      Text(
        title,
        style: TextStyle(
          fontSize: titleFontSize,
          fontWeight: FontWeight.w700,
          color: sectionColor,
          height: 1.3,
        ),
      ),
      SizedBox(height: 16),
      
      // View all button
      Row(
        children: [
          Text(
            "View all",
            style: TextStyle(
              fontSize: viewAllFontSize,
              fontWeight: FontWeight.w600,
              color: sectionColor,
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: sectionColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
      
      SizedBox(height: 24),
      
      // Items section
      Column(
        children: items.map((item) {
          if (isExpansionPanel) {
            return _buildExpansionItem(item, sectionColor, isMobile: true);
          } else {
            return _buildLinkItem(item, sectionColor, isMobile: true);
          }
        }).toList(),
      ),
    ],
  );
}

Widget _buildFaqDesktopLayout({
  required String title,
  required List<String> items,
  required bool isExpansionPanel,
  required Color sectionColor,
  required double titleFontSize,
  required double viewAllFontSize,
  required bool isTablet,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Left column - Title and View all button
      Expanded(
        flex: isTablet ? 2 : 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: sectionColor,
                height: 1.3,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "View all",
                    style: TextStyle(
                      fontSize: viewAllFontSize,
                      fontWeight: FontWeight.w600,
                      color: sectionColor,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: sectionColor,
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
          ],
        ),
      ),

      SizedBox(width: isTablet ? 24 : 32),

      // Right column - Expansion panels or links
      Expanded(
        flex: isTablet ? 3 : 2,
        child: Container(
          padding: EdgeInsets.only(top: 6),
          child: Column(
            children: items.map((item) {
              if (isExpansionPanel) {
                return _buildExpansionItem(item, sectionColor, isMobile: false);
              } else {
                return _buildLinkItem(item, sectionColor, isMobile: false);
              }
            }).toList(),
          ),
        ),
      ),
    ],
  );
}

Widget _buildExpansionItem(String title, Color color, {bool isMobile = false}) {
  return Theme(
    data: ThemeData(
      dividerColor: Colors.transparent,
      colorScheme: ColorScheme.light(
        surfaceTint: Colors.transparent,
        primary: color,
      ),
    ),
    child: Column(
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            vertical: isMobile ? 16 : 20,
            horizontal: 0,
          ),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: EdgeInsets.only(
            left: isMobile ? 32 : 50,
            bottom: 16,
            right: isMobile ? 16 : 20,
          ),
          leading: _buildCircleIcon(Icons.add, color),
          title: Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: isMobile ? 2 : 1,
          ),
          trailing: SizedBox.shrink(),
          children: [
            Text(
              'This is the answer to the FAQ question.',
              style: TextStyle(
                fontSize: isMobile ? 14 : 15,
                height: 1.5,
              ),
            ),
          ],
        ),
        _buildDottedLine(color: Color(0xFFfd7e14)),
      ],
    ),
  );
}

Widget _buildLinkItem(String title, Color color, {bool isMobile = false}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: isMobile ? 2 : 1,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: color,
              size: isMobile ? 20 : 22,
            ),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        height: 1,
        child: CustomPaint(
          painter: DottedLinePainter(color: Color(0xFFfd7e14)),
        ),
      ),
    ],
  );
}

// Helper method for circle icon (you'll need to implement this)
Widget _buildCircleIcon(IconData icon, Color color) {
  return Container(
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    child: Icon(
      icon,
      color: Colors.white,
      size: 16,
    ),
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



 Widget _buildApplyBanner() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 100, top: 50),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final isMobile = screenWidth < 768;
          final isTablet = screenWidth >= 768 && screenWidth < 1024;
          final isDesktop = screenWidth >= 1024;
          
          return Container(
            width: screenWidth * (isMobile ? 0.95 : 0.78),
            constraints: BoxConstraints(
              maxWidth: 1200, // Maximum width for very large screens
              minHeight: isMobile ? 300 : 400,
            ),
            color: tealColor,
            child: isMobile 
                ? _buildProfessionalMobileLayouts(screenWidth)
                : _buildDesktopLayouts(screenWidth, isTablet),
          );
        },
      ),
    ),
  );
}

Widget _buildProfessionalMobileLayouts(double screenWidth) {
  return Column(
    children: [
      // Content section
      Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Apply to get your skills assessed",
              style: TextStyle(
                color: const Color(0xFFFFA000),
                fontSize: screenWidth * 0.06, // Responsive font size
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Start the application process and if you have any questions, you can contact our customer support team at any stage.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 24),
            _buildActionButton("Apply Online", double.infinity),
          ],
        ),
      ),
      // Image section
      ClipRRect(
        child: Image.asset(
          'assets/images/During_your_application.jpg',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}

Widget _buildDesktopLayouts(double screenWidth, bool isTablet) {
  return Row(
    children: [
      // Left side with teal background and content
      Flexible(
        flex: isTablet ? 6 : 7,
        child: Container(
          padding: EdgeInsets.all(isTablet ? 40 : 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apply to get your skills assessed",
                style: TextStyle(
                  color: const Color(0xFFFFA000),
                  fontSize: isTablet ? 28 : 36,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Start the application process and if you have any questions, you can contact ${isTablet ? '' : '\n'}our customer support team at any stage.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 14 : 16,
                  height: 1.5,
                  letterSpacing: 0.3,
                ),
              ),
              _buildActionButton("Apply Online", isTablet ? 140 : 150),
            ],
          ),
        ),
      ),
      // Right side with desert landscape image
      Flexible(
        flex: isTablet ? 4 : 3,
        child: ClipRRect(
          child: Image.asset(
            'assets/images/During_your_application.jpg',
            width: double.infinity,
            height: isTablet ? 300 : 340,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}

  


Widget _buildActionButton(String text, double width) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      
      // Responsive button styling
      final buttonHeight = screenWidth >= 1024 ? 55.0 : 50.0;
      final fontSize = screenWidth >= 1024 ? 16.0 : 14.0;
      final horizontalPadding = screenWidth >= 768 ? 28.0 : 24.0;
      
      return SizedBox(
        height: buttonHeight,
        width: width,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFA000),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            textStyle: TextStyle(
              fontWeight: FontWeight.w600, 
              fontSize: fontSize,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text, 
              style: TextStyle(
                color: Colors.black,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    },
  );
}
}
  // Add these responsive helper methods at the top of your class
class ResponsiveHelper {
  static bool isMobile(double width) => width < 768;
  static bool isTablet(double width) => width >= 768 && width < 1024;
  static bool isDesktop(double width) => width >= 1024;
  
  static double getResponsiveFontSize(double baseSize, double screenWidth) {
    if (isMobile(screenWidth)) {
      return baseSize * 0.7;
    } else if (isTablet(screenWidth)) {
      return baseSize * 0.85;
    }
    return baseSize;
  }
  
  static double getResponsivePadding(double basePadding, double screenWidth) {
    if (isMobile(screenWidth)) {
      return basePadding * 0.5;
    } else if (isTablet(screenWidth)) {
      return basePadding * 0.75;
    }
    return basePadding;
  }
}


// Custom painter for dotted line (you'll need this class)
class DottedLinePainter extends CustomPainter {
  final Color color;
  
  DottedLinePainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    
    const dashWidth = 4;
    const dashSpace = 4;
    double startX = 0;
    
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


