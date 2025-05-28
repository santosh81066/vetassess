import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vetassess/theme.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';
import 'header.dart';
import 'footer.dart';

class SkillsAssessmentViewall extends StatelessWidget {
  const SkillsAssessmentViewall({super.key});
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;
  static const Color tealColor = Color(0xFF00565B);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(),
          _buildBreadcrumbs(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                const SizedBox(height: 50),
                _buildPreparingAppSection(context),
                const SizedBox(height: 50),
                _occupationTypeSections(context),
                const SizedBox(height: 50),
                _buildOccupationSearchSection(context),
                const SizedBox(height: 50),
                _buildHowToApply(context),
                const SizedBox(height: 50),
                _exploreMigrationOptionsSection(context),
                const SizedBox(height: 50),
                ..._buildInfoSection(
                  'Pioneering global skills training initiatives',
                  'We'
                      're passionate about assessing the skills and experience of skilled migrants looking to enter the Australian workforce, which is why we have assessment centres all around the world.',
                  'But what you might not know is that we'
                      're also pioneering innovative education and training programs on a global scale.',
                  'assets/images/blog_metropolis.jpg',
                  true,
                  screenWidth,
                  screenHeight,
                ),
                const SizedBox(height: 50),
                ..._buildInfoSection(
                  'For Employers and Businesses',
                  'Are you finding it challenging to address skills shortages within your business? Or perhaps your staff need upskilling and you'
                      'd like to assess their current skills and experience?',
                  'VETASSESS offers a wide range of services specifically for businesses and industry to develop employees and boost their career progression.',
                  'assets/images/blog_metropolis.jpg',
                  false,
                  screenWidth,
                  screenHeight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = MediaQuery.of(context).size.height;

        // Responsive height based on screen size
        double bannerHeight =
            isMobile(screenWidth)
                ? screenHeight * 0.5
                : isTablet(screenWidth)
                ? screenHeight * 0.55
                : screenHeight * 0.60;

        return Container(
          width: screenWidth,
          height: bannerHeight,
          decoration: const BoxDecoration(color: tealColor),
          child: Stack(
            children: [
              // Background image - hide on mobile if needed
              if (!isMobile(screenWidth))
                Positioned(
                  right: 0,
                  child: Image.asset(
                    'assets/images/internal_page_banner.png',
                    height: bannerHeight,
                    fit: BoxFit.fitHeight,
                  ),
                ),

              // Content container
              Container(
                width:
                    isMobile(screenWidth)
                        ? screenWidth * 0.9
                        : isTablet(screenWidth)
                        ? screenWidth * 0.75
                        : screenWidth * 0.66,
                padding: EdgeInsets.only(
                  top: isMobile(screenWidth) ? 60 : 100,
                  left: isMobile(screenWidth) ? 20 : 50,
                  right: isMobile(screenWidth) ? 20 : 0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        isMobile(screenWidth)
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                    children: [
                      Text(
                        "Skills Assessment for Migration",
                        style: TextStyle(
                          color: const Color(0xFFFFA000),
                          fontSize:
                              isMobile(screenWidth)
                                  ? 24
                                  : isTablet(screenWidth)
                                  ? 32
                                  : 45,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: isMobile(screenWidth) ? 20 : 30),
                      Text(
                        "Get your professional and trade skills assessed by VETASSESS.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              isMobile(screenWidth)
                                  ? 14
                                  : isTablet(screenWidth)
                                  ? 15
                                  : 16,
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
      },
    );
  }

  Widget _buildBreadcrumbs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        const TextStyle linkStyle = TextStyle(
          fontSize: 14,
          color: tealColor,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        );

        // Mobile layout - stack vertically or use smaller text
        if (isMobile(screenWidth)) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Home', style: linkStyle),
                    ),
                    const Text(' / ', style: TextStyle(color: Colors.grey)),
                    Expanded(
                      child: Text(
                        'Skills Assessment For Migration',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        // Tablet and Desktop layout
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: isMobile(screenWidth) ? 20 : 50,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Home',
                      style: linkStyle.copyWith(
                        fontSize: isTablet(screenWidth) ? 13 : 14,
                      ),
                    ),
                  ),
                  const Text(' / ', style: TextStyle(color: Colors.grey)),
                  Text(
                    'Skills Assessment For Migration',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: isTablet(screenWidth) ? 13 : 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
// Null-safe unified method for both info sections with responsive design
List<Widget> _buildInfoSection(
  String? title, 
  String? description, 
  String? additionalText,
  String? imagePath, 
  bool imageOnRight, 
  double? screenWidth, 
  double? screenHeight
) {
  
  // Null safety checks
  if (screenWidth == null || screenHeight == null) {
    return [const SizedBox.shrink()]; // Return empty widget if dimensions are null
  }
  
  // Provide default values for null strings
  final safeTitle = title ?? 'Default Title';
  final safeDescription = description ?? 'Default description text.';
  final safeAdditionalText = additionalText ?? 'Additional information.';
  final safeImagePath = imagePath ?? 'assets/images/placeholder.png'; // Make sure this asset exists
  
  // Define breakpoints with null safety
  bool isMobile = screenWidth < 768;
  bool isTablet = screenWidth >= 768 && screenWidth < 1024;
  bool isDesktop = screenWidth >= 1024;
  
  // Responsive dimensions with bounds checking
  double getInfoWidth() {
    if (isMobile) return (screenWidth * 0.9).clamp(200.0, double.infinity);
    if (isTablet) return (screenWidth * 0.45).clamp(300.0, double.infinity);
    return (screenWidth * 0.4).clamp(400.0, double.infinity);
  }
  
  double getImageWidth() {
    if (isMobile) return (screenWidth * 0.8).clamp(150.0, double.infinity);
    if (isTablet) return (screenWidth * 0.4).clamp(200.0, double.infinity);
    return (screenWidth * 0.35).clamp(300.0, double.infinity);
  }
  
  double getImageHeight() {
    if (isMobile) return (screenHeight * 0.25).clamp(150.0, 300.0);
    if (isTablet) return (screenHeight * 0.35).clamp(200.0, 400.0);
    return (screenHeight * 0.45).clamp(250.0, 500.0);
  }
  
  double getFontSize(double baseSizeMobile, double baseSizeDesktop) {
    if (isMobile) return baseSizeMobile;
    return baseSizeDesktop;
  }
  
  final Widget infoColumn = Container(
    width: getInfoWidth(),
    constraints: BoxConstraints(
      minHeight: isMobile ? 200 : 400,
      maxHeight: isMobile ? 500 : 600,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          safeTitle,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: getFontSize(24, 30),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF006064),
          ),
        ),
        SizedBox(height: isMobile ? 15 : 20),
        Text(
          safeDescription,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: getFontSize(14, 16),
            height: 1.5,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: isMobile ? 15 : 20),
        Text(
          safeAdditionalText,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: getFontSize(14, 16),
            height: 1.5,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: isMobile ? 20 : 25),
        TextButton(
          onPressed: () {
            // Add your navigation logic here
            print('Find Out More clicked');
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
          ),
          child: Text(
            'Find Out More',
            style: TextStyle(
              fontSize: getFontSize(14, 16),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF006064),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
  );

  // Null-safe image widget with error handling
  final Widget imageWidget = Container(
    width: getImageWidth(),
    height: getImageHeight(),
    child: Image.asset(
      safeImagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Return a placeholder if image fails to load
        return Container(
          color: Colors.grey[300],
          child: const Icon(
            Icons.image_not_supported,
            size: 50,
            color: Colors.grey,
          ),
        );
      },
    ),
  );

  // Mobile layout: Stack vertically
  if (isMobile) {
    return [
      Container(
        color: AppColors.color12 ?? Colors.white, // Null-safe color access
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          vertical: (screenHeight * 0.03).clamp(10.0, 50.0),
          horizontal: (screenWidth * 0.05).clamp(10.0, 50.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageOnRight 
            ? [infoColumn, const SizedBox(height: 20), imageWidget]
            : [imageWidget, const SizedBox(height: 20), infoColumn],
        ),
      )
    ];
  }

  // Tablet and Desktop layout: Side by side
  final List<Widget> rowChildren = imageOnRight
      ? [
          Expanded(flex: 3, child: infoColumn),
          SizedBox(width: (screenWidth * 0.02).clamp(10.0, 30.0)),
          Expanded(flex: 2, child: imageWidget),
        ]
      : [
          Expanded(flex: 2, child: imageWidget),
          SizedBox(width: (screenWidth * 0.02).clamp(10.0, 30.0)),
          Expanded(flex: 3, child: infoColumn),
        ];

  return [
    Container(
      color: AppColors.color12 ?? Colors.white, // Null-safe color access
      width: screenWidth,
      padding: EdgeInsets.symmetric(
        vertical: (screenHeight * 0.04).clamp(15.0, 60.0),
        horizontal: (screenWidth * 0.05).clamp(15.0, 80.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: rowChildren,
      ),
    )
  ];
}

// Safe method to get screen dimensions
Map<String, double> _getScreenDimensions(BuildContext context) {
  final MediaQueryData? mediaQuery = MediaQuery.maybeOf(context);
  
  return {
    'width': mediaQuery?.size.width ?? 375.0, // Default mobile width
    'height': mediaQuery?.size.height ?? 667.0, // Default mobile height
  };
}

// Usage example with null safety
Widget buildInfoSectionSafely(BuildContext context, {
  String? title,
  String? description, 
  String? additionalText,
  String? imagePath,
  bool imageOnRight = true,
}) {
  final dimensions = _getScreenDimensions(context);
  final sections = _buildInfoSection(
    title,
    description,
    additionalText,
    imagePath,
    imageOnRight,
    dimensions['width'],
    dimensions['height'],
  );
  
  return Column(children: sections);
}

// Alternative with LayoutBuilder for better null safety
Widget buildInfoSectionWithLayoutBuilder({
  String? title,
  String? description,
  String? additionalText,
  String? imagePath,
  bool imageOnRight = true,
}) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      // Safe access to MediaQuery
      final mediaQuery = MediaQuery.maybeOf(context);
      final screenHeight = mediaQuery?.size.height ?? 667.0;
      
      final sections = _buildInfoSection(
        title,
        description,
        additionalText,
        imagePath,
        imageOnRight,
        constraints.maxWidth > 0 ? constraints.maxWidth : 375.0,
        screenHeight,
      );
      
      return Column(children: sections);
    },
  );
}


  Widget _occupationTypeSections(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOccupationHeader(),
          _buildOccupationDescription(),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildOccupationSection(true)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildOccupationSection(false)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildOccupationSection(true),
                    const SizedBox(height: 40),
                    _buildOccupationSection(false),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // Unified method for both occupation sections
  Widget _buildOccupationSection(bool isProfessional) {
    final String title = isProfessional ? "For Professionals" : "For Trades";
    final String description =
        isProfessional
            ? "At VETASSESS, we assess more than 341 professional occupations across a number of different industries."
            : "VETASSESS can assess 27 trade occupations within the skills assessment for migration process.";
    final List<String> items =
        isProfessional
            ? [
              "Marketing Professional",
              "Management Consultant",
              "Cafe or Restaurant Manager, and",
              "Internal Auditor.",
            ]
            : ["Cook and Chef", "Electrician", "Motor Mechanic", "Welder"];
    final String linkText =
        isProfessional
            ? "See All Professional Occupations"
            : "See All Trade Occupations";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.asset(
              'assets/images/application_Outcome.jpg',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A594C),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Some of the professions we assess are:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "• ",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        linkText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0A594C),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0A594C),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOccupationHeader() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        "Choose your occupation type",
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0A594C),
        ),
      ),
    );
  }

  Widget _buildOccupationDescription() {
    return const Text(
      "At VETASSESS, we offer skills assessments for migration for a variety of different professional and trade "
      "occupation types. Explore the occupation categories below to find the right pathway for your "
      "occupation assessment.",
      style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
    );
  }

 
  Widget _exploreMigrationOptionsSection(BuildContext context) {
    final List<MigrationOption> migrationOptions = [
      MigrationOption(
        title: 'Designated Area Migration (DAMA)',
        imagePath: 'assets/images/migration_road.jpg',
      ),
      MigrationOption(
        title: 'Post-Vocational Education Work (Subclass 485) visa',
        imagePath: 'assets/images/education_work.jpg',
      ),
      MigrationOption(
        title: 'VETASSESS Points Test Advice',
        imagePath: 'assets/images/points_test.jpg',
      ),
      MigrationOption(
        title: 'Industry Labour Agreement',
        imagePath: 'assets/images/labour_agreement.jpg',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore other migration options',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A594C),
            ),
          ),
          const SizedBox(height: 32),

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      migrationOptions.map((option) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: _buildMigrationOptionCard(option),
                          ),
                        );
                      }).toList(),
                );
              } else if (constraints.maxWidth > 600) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildMigrationOptionCard(migrationOptions[0]),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMigrationOptionCard(migrationOptions[1]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildMigrationOptionCard(migrationOptions[2]),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMigrationOptionCard(migrationOptions[3]),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  children:
                      migrationOptions.map((option) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _buildMigrationOptionCard(option),
                        );
                      }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMigrationOptionCard(MigrationOption option) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.asset(
              option.imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                option.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A594C),
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Color(0xFF0A594C), size: 20),
          ],
        ),
      ],
    );
  }

  Widget _buildOccupationSearchSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  // Responsive padding based on screen width
  double getHorizontalPadding() {
    if (screenWidth > 1200) return 250;
    if (screenWidth > 768) return screenWidth * 0.15;
    if (screenWidth > 480) return 32;
    return 16;
  }
  
  // Responsive container padding
  double getContainerPadding() {
    if (screenWidth > 768) return 35;
    if (screenWidth > 480) return 24;
    return 16;
  }
  
  // Responsive title font size
  double getTitleFontSize() {
    if (screenWidth > 1200) return 32;
    if (screenWidth > 768) return 28;
    if (screenWidth > 480) return 24;
    return 20;
  }
  
  // Responsive subtitle font size
  double getSubtitleFontSize() {
    if (screenWidth > 768) return 16;
    if (screenWidth > 480) return 14;
    return 12;
  }
  
  // Responsive search container height
  double getSearchHeight() {
    if (screenWidth > 768) return 50;
    if (screenWidth > 480) return 45;
    return 40;
  }
  
  // Responsive search button width
  double getSearchButtonWidth() {
    if (screenWidth > 768) return 120;
    if (screenWidth > 480) return 100;
    return 80;
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: getHorizontalPadding()),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(getContainerPadding()),
      color: const Color(0xFF0A594C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search For Your Occupation",
            style: TextStyle(
              fontSize: getTitleFontSize(),
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFDB713),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenWidth > 768 ? 12 : 8),
          
          Text(
            "Find out if we can assess your skills and experience",
            style: TextStyle(
              fontSize: getSubtitleFontSize(),
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenWidth > 768 ? 24 : 16),
          
          // Search container with responsive design
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth > 768 ? 620 : double.infinity,
                ),
                height: getSearchHeight(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFFFDB713), width: 1),
                ),
                child: screenWidth > 480 
                  ? _buildHorizontalSearch(getSearchButtonWidth())
                  : _buildVerticalSearch(),
              );
            },
          ),
        ],
      ),
    ),
  );
}

// Horizontal layout for larger screens
Widget _buildHorizontalSearch(double buttonWidth) {
  return Row(
    children: [
      Expanded(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Color(0xFFFDB713),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your occupation",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: buttonWidth,
        color: const Color(0xFFFDB713),
        child: const Center(
          child: Text(
            "Search",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ],
  );
}

// Vertical layout for mobile screens
Widget _buildVerticalSearch() {
  return Column(
    children: [
      Expanded(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Color(0xFFFDB713),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter occupation",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 35,
        color: const Color(0xFFFDB713),
        child: const Center(
          child: Text(
            "Search",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ],
  );
}


Widget _buildPreparingAppSection(BuildContext context) {
  final List<String> navigationLinks = [
    'Apply online',
    'Track your Application',
    'View Current Processing Times',
  ];

  // Get screen dimensions
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  
  // Define breakpoints
  final bool isMobile = screenWidth < 768;
  final bool isTablet = screenWidth >= 768 && screenWidth < 1024;
  final bool isDesktop = screenWidth >= 1024;

  // Responsive values
  final double horizontalPadding = isMobile ? 16 : (isTablet ? 32 : 50);
  final double verticalPadding = isMobile ? 20 : 40;
  final double titleFontSize = isMobile ? 24 : (isTablet ? 28 : 30);
  final double bodyFontSize = isMobile ? 14 : 15;
  final double spacingBetweenSections = isMobile ? 20 : (isTablet ? 40 : 100);
  
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
    child: isMobile 
      ? _buildMobileLayout(navigationLinks, titleFontSize, bodyFontSize)
      : _buildDesktopLayout(navigationLinks, titleFontSize, bodyFontSize, spacingBetweenSections),
  );
}

// Mobile layout - stacked vertically
Widget _buildMobileLayout(List<String> navigationLinks, double titleFontSize, double bodyFontSize) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildContentSection(titleFontSize, bodyFontSize),
      const SizedBox(height: 40),
      _buildNavigationSection(navigationLinks, true),
    ],
  );
}

// Desktop/Tablet layout - side by side
Widget _buildDesktopLayout(List<String> navigationLinks, double titleFontSize, double bodyFontSize, double spacing) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 2,
        child: _buildContentSection(titleFontSize, bodyFontSize),
      ),
      SizedBox(width: spacing),
      Expanded(
        flex: 1,
        child: _buildNavigationSection(navigationLinks, false),
      ),
    ],
  );
}

// Content section with title and description
Widget _buildContentSection(double titleFontSize, double bodyFontSize) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Do you need your skills assessed? Find out how.",
        style: TextStyle(
          fontSize: titleFontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0A594C),
          height: 1.3,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        'Getting your skills assessed is a requirement for skilled migration to Australia. Below, you\'ll find information and resources on what you need to do to get your skills assessed with us.',
        style: TextStyle(
          fontSize: bodyFontSize,
          color: Colors.black87,
          height: 1.5,
        ),
      ),
    ],
  );
}

// Navigation section with links
Widget _buildNavigationSection(List<String> navigationLinks, bool isMobile) {
  return Container(
    padding: EdgeInsets.only(top: isMobile ? 0 : 40),
    child: Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: navigationLinks.asMap().entries.map((entry) {
        final int index = entry.key;
        final String link = entry.value;
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
                  const SizedBox(width: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF0A594C),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            if (index < navigationLinks.length - 1)
              Container(
                width: double.infinity,
                height: 1,
                child: CustomPaint(
                  painter: DottedLinePainter(
                    color: const Color(0xFFfd7e14),
                  ),
                ),
              ),
          ],
        );
      }).toList(),
    ),
  );
}

// Updated responsive version of your How to Apply section
Widget _buildHowToApply(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final bool isMobile = screenWidth < 768;
  final bool isTablet = screenWidth >= 768 && screenWidth < 1024;
  
  final double horizontalPadding = isMobile ? 16 : (isTablet ? 50 : 150);
  final double verticalPadding = isMobile ? 30 : 40;
  final double titleFontSize = isMobile ? 28 : 36;
  final double tabBarHeight = isMobile ? 300 : 400;

  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      vertical: verticalPadding, 
      horizontal: horizontalPadding
    ),
    decoration: const BoxDecoration(color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'How to apply',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF00695C),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                labelColor: const Color(0xFF00695C),
                unselectedLabelColor: Colors.black45,
                indicatorColor: const Color(0xFFFFA000),
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: isMobile ? 16 : 20,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: "If you're a Professional"),
                  Tab(text: 'If you have Trade skills'),
                ],
              ),
              const SizedBox(height: 48),
              SizedBox(
                height: tabBarHeight,
                child: TabBarView(
                  children: [
                    _ResponsiveProfessionalOccupationsContent(),
                    _ResponsiveTradeOccupationsContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}

// Responsive Professional Occupations Content
class _ResponsiveProfessionalOccupationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "If you're a professional choosing to migrate to Australia, chances are you're likely to be "
            "assessed by us. We assess 361 different professional occupations, assessing your skills, "
            "experience and qualifications.",
            style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
          ),
          SizedBox(height: isMobile ? 30 : 60),
          isMobile 
            ? _buildMobileStepsLayout(_getProfessionalSteps())
            : _buildDesktopStepsLayout(_getProfessionalSteps()),
        ],
      ),
    );
  }

  List<Map<String, String>> _getProfessionalSteps() {
    return [
      {
        "number": "1",
        "title": "Find",
        "description": "Find the VETASSESS occupation that most closely fits your skills and experience.",
      },
      {
        "number": "2", 
        "title": "Match",
        "description": "Match your skills and experience to your chosen occupation.",
      },
      {
        "number": "3",
        "title": "Prepare", 
        "description": "Get ready to apply by preparing all the information and documents you need.",
      },
      {
        "number": "4",
        "title": "Apply",
        "description": "Apply online when you're ready. If you're still unsure,",
        "linkText": "skills assessment support",
        "linkDescription": "is available when you need it.",
      },
    ];
  }
}

// Responsive Trade Occupations Content
class _ResponsiveTradeOccupationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "If you're a tradesperson, your skills and experience will be assessed by someone who has worked in your trade and understands your skills and qualifications. VETASSESS is Australia's leading assessment body for trades and we can assess 27 different trade occupations.",
            style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
          ),
          SizedBox(height: isMobile ? 30 : 60),
          isMobile 
            ? _buildMobileStepsLayout(_getTradeSteps())
            : _buildDesktopStepsLayout(_getTradeSteps()),
        ],
      ),
    );
  }

  List<Map<String, String>> _getTradeSteps() {
    return [
      {
        "number": "1",
        "title": "Step 1",
        "description": "Check your",
        "linkText": "eligibility ",
        "linkDescription": "apply for a Trade Skills Assessment."
      },
      {
        "number": "2",
        "title": "Step 2", 
        "description": "Understand the",
        "linkText": "Assessment Process  ",
      },
      {
        "number": "3",
        "title": "Step 3",
        "description": "Confirm the type of",
        "linkText": "evidence ",
        "linkDescription": "you may be asked to provide "
      },
      {
        "number": "4",
        "title": "Step 4",
        "description": "Find the",
        "linkText": "cost",
        "linkDescription": "you'll need to pay up front for your trade skills assessment "
      },
      {
        "number": "5",
        "title": "Step 5",
        "description": '',
        "linkText": "Apply now. ",
      },
    ];
  }
}

// Mobile steps layout - vertical stacking
Widget _buildMobileStepsLayout(List<Map<String, String>> steps) {
  return Column(
    children: steps.asMap().entries.map((entry) {
      final int index = entry.key;
      final Map<String, String> step = entry.value;
      
      return Column(
        children: [
          _ResponsiveStepColumn(
            number: step["number"]!,
            title: step["title"]!,
            description: step["description"]!,
            linkText: step["linkText"],
            linkDescription: step["linkDescription"],
            isMobile: true,
          ),
          if (index < steps.length - 1) ...[
            const SizedBox(height: 20),
            _ResponsiveDottedLine(),
            const SizedBox(height: 20),
          ],
        ],
      );
    }).toList(),
  );
}

// Desktop steps layout - horizontal row
Widget _buildDesktopStepsLayout(List<Map<String, String>> steps) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: steps.asMap().entries.map((entry) {
        final int index = entry.key;
        final Map<String, String> step = entry.value;
        
        return Row(
          children: [
            _ResponsiveStepColumn(
              number: step["number"]!,
              title: step["title"]!,  
              description: step["description"]!,
              linkText: step["linkText"],
              linkDescription: step["linkDescription"],
              isMobile: false,
            ),
            if (index < steps.length - 1) _ResponsiveDottedLine(),
          ],
        );
      }).toList(),
    ),
  );
}

// Responsive Step Column
class _ResponsiveStepColumn extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final String? linkText;
  final String? linkDescription;
  final bool isMobile;

  const _ResponsiveStepColumn({
    required this.number,
    required this.title,
    required this.description,
    this.linkText,
    this.linkDescription,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMobile ? double.infinity : 180,
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                color: Color(0xFF00695C),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF00695C),
            ),
            textAlign: isMobile ? TextAlign.left : TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
            textAlign: isMobile ? TextAlign.left : TextAlign.center,
          ),
          if (linkText != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: RichText(
                textAlign: isMobile ? TextAlign.left : TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: linkText,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0288D1),
                        decoration: TextDecoration.underline,
                        height: 1.4,
                      ),
                    ),
                    if (linkDescription != null)
                      TextSpan(
                        text: " $linkDescription",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.4,
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
}

// Responsive Dotted Line
class _ResponsiveDottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    
    return SizedBox(
      width: isMobile ? double.infinity : 60,
      height: isMobile ? 20 : 2,
      child: Center(
        child: CustomPaint(
          painter: _ResponsiveDottedLinePainter(isMobile: isMobile), 
          size: Size(isMobile ? double.infinity : 60, isMobile ? 20 : 2)
        ),
      ),
    );
  }
}

class _ResponsiveDottedLinePainter extends CustomPainter {
  final bool isMobile;
  
  const _ResponsiveDottedLinePainter({required this.isMobile});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFA000)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const dashWidth = 4.0;
    const dashSpace = 6.0;

    if (isMobile) {
      // Vertical dotted line for mobile
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashWidth),
          paint,
        );
        startY += dashWidth + dashSpace;
      }
    } else {
      // Horizontal dotted line for desktop
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Don't forget to include your DottedLinePainter class
class DottedLinePainter extends CustomPainter {
  final Color color;
  
  const DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dashWidth = 4.0;
    const dashSpace = 6.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

 

// Data model for migration options
class MigrationOption {
  final String title;
  final String imagePath;

  MigrationOption({required this.title, required this.imagePath});
}
