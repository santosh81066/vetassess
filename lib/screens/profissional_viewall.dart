import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vetassess/theme.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

class ProfessionalViewall extends StatefulWidget {
  const ProfessionalViewall({Key? key}) : super(key: key);

  @override
  State<ProfessionalViewall> createState() => _ProfessionalviewallState();
}

class _ProfessionalviewallState extends State<ProfessionalViewall> {
  static const Color tealColor = Color(0xFF00565B);
  // Add these variables at the class level where your state is managed
  ScrollController _autoScrollController = ScrollController();
  Timer? _scrollTimer;
  bool _isScrolling = false;
  final Duration _scrollPauseDuration = Duration(seconds: 3);
  final Duration _scrollAnimDuration = Duration(seconds: 1);
  bool isMobile(double width) => width < 600;
  bool isTablet(double width) => width >= 600 && width < 1024;
  bool isDesktop(double width) => width >= 1024;

  @override
  void initState() {
    super.initState();
    // Start auto-scrolling after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _autoScrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    // Start a repeating timer for scrolling
    _scrollTimer = Timer.periodic(_scrollPauseDuration, (timer) {
      if (!_isScrolling && _autoScrollController.hasClients) {
        _isScrolling = true;

        double maxExtent = _autoScrollController.position.maxScrollExtent;
        double currentPos = _autoScrollController.offset;

        // Calculate next position - adjust this based on your card width
        double nextPos =
            currentPos + 300; // Approximate width of one card plus padding

        // If we're near the end, loop back to the top
        if (nextPos >= maxExtent) {
          _autoScrollController
              .animateTo(
                maxExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              )
              .then((_) {
                // Jump back to start after a brief pause
                Future.delayed(Duration(milliseconds: 100), () {
                  if (_autoScrollController.hasClients) {
                    _autoScrollController.jumpTo(0);
                    _isScrolling = false;
                  }
                });
              });
        } else {
          // Normal scroll to next position
          _autoScrollController
              .animateTo(
                nextPos,
                duration: _scrollAnimDuration,
                curve: Curves.easeInOut,
              )
              .then((_) {
                _isScrolling = false;
              });
        }
      }
    });
  }

  void _stopAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Color constants
    const Color tealColor = Color(0xFF00565B);
    const Color yellowColor = Color(0xFFF9C700);
    const Color dottedLineColor = Color(0xFF008996);

    return BasePageLayout(
      child: Column(
        children: [
          _buildHeaderBanner(),
          _buildBreadcrumbs(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ..._buildInfoSection(
                  'Get your qualifications and experience verified.',
                  'A Skills Assessment is an important part of the professional occupations recognition process when migrating to Australia. It will determine if you have the skills and knowledge required to work in your occupation in Australia.',

                  'assets/images/blog_metropolis.jpg',
                  true,
                  screenWidth,
                  screenHeight,
                ),
                const SizedBox(height: 50),
                _exploreMigrationOptionsSection(context),
                const SizedBox(height: 50),
                _buildOccupationSearchSection(context),
                const SizedBox(height: 50),
                _buildSectionTitle(context, 'The application process'),
                const SizedBox(height: 30),
                _buildApplicationSteps(context),
                SizedBox(height: 50),
                _buildPreparingApplSection(),
                SizedBox(height: 50),
                _supportSection(context),
                SizedBox(height: 50),
                _buildFaqSection(
                  'Explore FAQs',
                  ['What is a highly relevant employment?'],
                  false,
                  tealColor,
                  yellowColor,
                  dottedLineColor,
                  context,
                ),
                SizedBox(height: 50),
                _otherMigrationPathwaysavailable(context),
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
                        "Skills Assessment for Professional Occupations",
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
                        "At VETASSESS, we assess more than 341 professional and other non-trade occupations.",
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
                    const Text(' / ', style: TextStyle(color: Colors.grey)),
                    Expanded(
                      child: Text(
                        'Skills Assessment for professional occupations',
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
                  const Text(' / ', style: TextStyle(color: Colors.grey)),
                  Text(
                    'Skills Assessment for professional occupations',
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
      "Which visa types can I apply for after a successful skills assessment?",
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
                SizedBox(height: 10),
                Text(
                  "It's important to understand both the qualification and employment experience required for an occupation in Australia.",
                  style: TextStyle(
                    fontSize: 16,

                    color: Colors.grey,
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

  // Null-safe unified method for both info sections with responsive design
  List<Widget> _buildInfoSection(
    String? title,
    String? description,

    String? imagePath,
    bool imageOnRight,
    double? screenWidth,
    double? screenHeight,
  ) {
    // Null safety checks
    if (screenWidth == null || screenHeight == null) {
      return [
        const SizedBox.shrink(),
      ]; // Return empty widget if dimensions are null
    }

    // Provide default values for null strings
    final safeTitle = title ?? 'Default Title';
    final safeDescription = description ?? 'Default description text.';

    final safeImagePath =
        imagePath ??
        'assets/images/placeholder.png'; // Make sure this asset exists

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
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
          color: AppColors?.color12 ?? Colors.white, // Null-safe color access
          width: screenWidth,
          padding: EdgeInsets.symmetric(
            vertical: (screenHeight * 0.03).clamp(10.0, 50.0),
            horizontal: (screenWidth * 0.05).clamp(10.0, 50.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                imageOnRight
                    ? [infoColumn, const SizedBox(height: 20), imageWidget]
                    : [imageWidget, const SizedBox(height: 20), infoColumn],
          ),
        ),
      ];
    }

    // Tablet and Desktop layout: Side by side
    final List<Widget> rowChildren =
        imageOnRight
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
      ),
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
  Widget buildInfoSectionSafely(
    BuildContext context, {
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

          imagePath,
          imageOnRight,
          constraints.maxWidth > 0 ? constraints.maxWidth : 375.0,
          screenHeight,
        );

        return Column(children: sections);
      },
    );
  }

  // Update your _exploreMigrationOptionsSection method to use horizontal auto-scrolling
  Widget _exploreMigrationOptionsSection(BuildContext context) {
    final List<MigrationOption> migrationOptions = [
      MigrationOption(
        title: 'Art & Education',
        imagePath: 'assets/images/migration_road.jpg',
      ),
      MigrationOption(
        title: 'Business & Finance',
        imagePath: 'assets/images/education_work.jpg',
      ),
      MigrationOption(
        title: 'Construction & Manufacturing',
        imagePath: 'assets/images/points_test.jpg',
      ),
      MigrationOption(
        title: 'Hospitality & Retail',
        imagePath: 'assets/images/labour_agreement.jpg',
      ),
      MigrationOption(
        title: 'Science, Health & Agriculture',
        imagePath: 'assets/images/labour_agreement.jpg',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VETASSESS Professional Occupations include',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A594C),
            ),
          ),
          const SizedBox(height: 32),

          // Horizontal scrolling container
          Container(
            height: 250, // Adjust based on your card height
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                // Pause auto-scrolling when user manually scrolls
                if (notification is ScrollStartNotification) {
                  _stopAutoScroll();
                } else if (notification is ScrollEndNotification) {
                  // Resume auto-scrolling after a delay
                  Future.delayed(Duration(seconds: 15), () {
                    _startAutoScroll();
                  });
                }
                return false;
              },
              child: ListView(
                controller: _autoScrollController,
                scrollDirection: Axis.horizontal,
                children:
                    migrationOptions.map((option) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: _buildProfessionCard(option),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card layout for horizontal scrolling
  Widget _buildProfessionCard(MigrationOption option) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Handle navigation to category page
          print('Navigating to ${option.title}');
        },
        child: Container(
          width: 280, // Adjust width as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    option.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),

              // Title and arrow at the bottom
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        option.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A594C),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF0A594C),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otherMigrationPathwaysavailable(BuildContext context) {
    final List<MigrationOption> migrationOptions = [
      MigrationOption(
        title: 'Post-Vocational Education Work (Subclass 485) visa',
        imagePath: 'assets/images/education_work.jpg',
      ),
      MigrationOption(
        title: 'Designated Area Migration (DAMA)',
        imagePath: 'assets/images/migration_road.jpg',
      ),

      MigrationOption(
        title: 'Chinese Qualification Verification services',
        imagePath: 'assets/images/points_test.jpg',
      ),
      MigrationOption(
        title: 'Vetassess Points Test',
        imagePath: 'assets/images/labour_agreement.jpg',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Other Migration Pathways available',
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
                            child: _buildotherMigrationOptionCard(option),
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
                          child: _buildotherMigrationOptionCard(
                            migrationOptions[0],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildotherMigrationOptionCard(
                            migrationOptions[1],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildotherMigrationOptionCard(
                            migrationOptions[2],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildotherMigrationOptionCard(
                            migrationOptions[3],
                          ),
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
                          child: _buildotherMigrationOptionCard(option),
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

  Widget _buildotherMigrationOptionCard(MigrationOption option) {
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
                    border: Border.all(
                      color: const Color(0xFFFDB713),
                      width: 1,
                    ),
                  ),
                  child:
                      screenWidth > 480
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
                const Icon(Icons.search, color: Color(0xFFFDB713), size: 24),
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
                const Icon(Icons.search, color: Color(0xFFFDB713), size: 20),
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

  Widget _buildApplicationSteps(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;

    // Responsive padding
    double horizontalPadding = isMobile ? 16 : (isTablet ? 24 : 35);

    // Responsive connector width
    double connectorWidth = isMobile ? 40 : (isTablet ? 60 : 80);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child:
          isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context, connectorWidth),
    );
  }

  // Mobile layout - vertical stack
  Widget _buildMobileLayout(BuildContext context) {
    final steps = [
      _StepData(
        '1',
        'Nominate',
        'Nominate an occupation',
        ' Check the qualification and employment requirements for your occupation.',
      ),
      _StepData(
        '2',
        'Check',
        'Check your occupation description.',
        ' View the Professional Occupations list to understand whether your work experience matches the occupation description.',
      ),
      _StepData(
        '3',
        'Prepare',
        'Prepare for your application. Still unsure about the application criteria or documents? We have some optional services. ',
        null,
        [
          _LinkData('Get Skills Assessment Support.', true),
          _LinkData(' Find out about ', false),
          _LinkData('Priority Processing', true),
          _LinkData(' to fast track your application.', false),
        ],
      ),
      _StepData('4', 'Apply', 'Apply now. You can ', null, [
        _LinkData('apply online.', true),
      ]),
    ];

    return Column(
      children:
          steps.asMap().entries.map((entry) {
            int index = entry.key;
            _StepData step = entry.value;
            bool isLast = index == steps.length - 1;

            return Column(
              children: [
                _buildMobileStep(context, step),
                if (!isLast) _buildVerticalConnector(context),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildMobileStep(BuildContext context, _StepData step) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNumberBox(
                context,
                step.number,
                screenWidth * 0.15,
              ), // 15% of screen width
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  step.title,
                  style: TextStyle(
                    fontSize: screenWidth < 360 ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0d5257),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildStepDescription(context, step),
        ],
      ),
    );
  }

  Widget _buildVerticalConnector(BuildContext context) {
    return Container(
      width: 3,
      height: 30,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.amber,
    );
  }

  // Desktop/Tablet layout - horizontal row
  Widget _buildDesktopLayout(BuildContext context, double connectorWidth) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 1
            _buildDesktopStep(
              context,
              '1',
              'Nominate',
              'Nominate an occupation',
              ' Check the qualification and employment requirements for your occupation.',
            ),
            _buildHorizontalConnector(context, connectorWidth),

            // Step 2
            _buildDesktopStep(
              context,
              '2',
              'Check',
              'Check your occupation description.',
              ' View the Professional Occupations list to understand whether your work experience matches the occupation description.',
            ),
            _buildHorizontalConnector(context, connectorWidth),

            // Step 3
            _buildDesktopStep(
              context,
              '3',
              'Prepare',
              'Prepare for your application. Still unsure about the application criteria or documents? We have some optional services. ',
              null,
              [
                _LinkData('Get Skills Assessment Support.', true),
                _LinkData(' Find out about ', false),
                _LinkData('Priority Processing', true),
                _LinkData(' to fast track your application.', false),
              ],
            ),
            _buildHorizontalConnector(context, connectorWidth),

            // Step 4
            _buildDesktopStep(
              context,
              '4',
              'Apply',
              'Apply now. You can ',
              null,
              [_LinkData('apply online.', true)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopStep(
    BuildContext context,
    String number,
    String title,
    String mainText,
    String? additionalText, [
    List<_LinkData>? links,
  ]) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    // Responsive step width
    double stepWidth = isTablet ? 200 : 250;

    return SizedBox(
      width: stepWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNumberedStep(context, number, title),
          const SizedBox(height: 10),
          _buildStepDescription(
            context,
            _StepData(number, title, mainText, additionalText, links),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalConnector(BuildContext context, double width) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(top: 30),
      height: 2,
      color: Colors.amber,
    );
  }

  Widget _buildNumberedStep(BuildContext context, String number, String title) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isMobile = screenWidth < 768;

    // Responsive sizing
    double boxSize = isMobile ? 50 : (isTablet ? 55 : 60);
    double numberFontSize = isMobile ? 32 : (isTablet ? 36 : 40);
    double titleFontSize = isMobile ? 20 : (isTablet ? 22 : 24);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNumberBox(context, number, boxSize, fontSize: numberFontSize),
        const SizedBox(height: 15),
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0d5257),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberBox(
    BuildContext context,
    String number,
    double size, {
    double? fontSize,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(8), // Added rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            fontSize: fontSize ?? 40,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0d5257),
          ),
        ),
      ),
    );
  }

  Widget _buildStepDescription(BuildContext context, _StepData step) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    double fontSize = isMobile ? 14 : 16;

    List<TextSpan> spans = [];

    // Add main text with link styling
    spans.add(
      TextSpan(
        text: step.mainText,
        style: TextStyle(
          color: const Color(0xFF006064),
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          fontSize: fontSize,
        ),
      ),
    );

    // Add additional text if present
    if (step.additionalText != null) {
      spans.add(
        TextSpan(
          text: step.additionalText,
          style: TextStyle(color: const Color(0xFF5A5A5A), fontSize: fontSize),
        ),
      );
    }

    // Add links if present
    if (step.links != null) {
      for (_LinkData link in step.links!) {
        spans.add(
          TextSpan(
            text: link.text,
            style: TextStyle(
              color:
                  link.isLink
                      ? const Color(0xFF006064)
                      : const Color(0xFF5A5A5A),
              fontWeight: link.isLink ? FontWeight.bold : FontWeight.normal,
              decoration:
                  link.isLink ? TextDecoration.underline : TextDecoration.none,
              fontSize: fontSize,
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          color: const Color(0xFF5A5A5A),
          height: 1.4, // Better line height for readability
        ),
        children: spans,
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    double fontSize = isMobile ? 24 : (isTablet ? 28 : 30);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0d5257),
            fontSize: fontSize,
          ),
        ),
      ],
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
        double titleFontSize = _getpreparingResponsiveTitleFontSize(
          screenWidth,
        );
        double descriptionFontSize = _getpreparingResponsiveDescriptionFontSize(
          screenWidth,
        );
        double linkFontSize = _getResponsiveLinkFontSize(screenWidth);
        double iconSize = _getResponsiveIconSize(screenWidth);
        double containerSize = _getResponsiveContainerSize(screenWidth);
        double verticalSpacing = _getResponsiveVerticalSpacing(screenWidth);

        return Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child:
              isMobile
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
            children:
                links.asMap().entries.map((entry) {
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
                              decoration: BoxDecoration(shape: BoxShape.circle),
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
            width:
                screenWidth *
                (isTablet ? 0.55 : 0.6), // Responsive width based on screen
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
            width:
                screenWidth *
                (isTablet ? 0.35 : 0.3), // Responsive width based on screen
            padding: EdgeInsets.only(
              top: verticalSpacing,
              bottom: verticalSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  links.asMap().entries.map((entry) {
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
      child: CustomPaint(painter: DottedLinePainter(color: color)),
    );
  }

  Widget _supportSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define breakpoints
    final bool isMobile = screenWidth < 576;
    final bool isTablet = screenWidth >= 576 && screenWidth < 768;
    final bool isDesktop = screenWidth >= 768;
    final bool isLargeDesktop = screenWidth >= 1200;

    // Responsive typography
    double getTitleFontSize() {
      if (isMobile) return 24;
      if (isTablet) return 28;
      if (isDesktop) return 32;
      return 36; // Large desktop
    }

    // Responsive padding
    EdgeInsets getContainerPadding() {
      if (isMobile) {
        return EdgeInsets.symmetric(
          vertical: screenHeight * 0.08, // 8% of screen height
          horizontal: 16,
        );
      } else if (isTablet) {
        return EdgeInsets.symmetric(
          vertical: screenHeight * 0.10, // 10% of screen height
          horizontal: 24,
        );
      } else {
        return EdgeInsets.symmetric(
          vertical: screenHeight * 0.12, // 12% of screen height
          horizontal: 32,
        );
      }
    }

    // Responsive background pattern sizing
    double getPatternWidth() {
      if (isMobile) return screenWidth * 0.6;
      if (isTablet) return screenWidth * 0.55;
      return screenWidth * 0.5;
    }

    double getPatternHeight() {
      if (screenHeight < 600) return screenHeight * 0.7;
      if (screenHeight < 800) return screenHeight * 0.75;
      return screenHeight * 0.8;
    }

    // Responsive card spacing
    double getCardSpacing() {
      if (isMobile) return 16;
      if (isTablet) return 20;
      return 24;
    }

    // Responsive max width for content container
    double getMaxContentWidth() {
      if (isMobile) return double.infinity;
      if (isTablet) return 768;
      if (isDesktop) return 1024;
      return 1244; // Large desktop
    }

    return Container(
      color: const Color(0xFF00565A),
      constraints: BoxConstraints(
        minHeight: isMobile ? 400 : 500, // Minimum height for small screens
      ),
      child: Stack(
        children: [
          // Background pattern - responsive positioning and sizing
          Positioned(
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/block-bg.svg',
              width: getPatternWidth(),
              height: getPatternHeight(),
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
            ),
          ),

          // Content container with responsive padding
          Container(
            padding: getContainerPadding(),
            width: double.infinity,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: getMaxContentWidth()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Responsive title
                    Text(
                      "I need help, what support is available?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getTitleFontSize(),
                        fontWeight: FontWeight.bold,
                        height: 1.2, // Line height for better readability
                      ),
                    ),
                    SizedBox(height: isMobile ? 16 : 20),

                    // Responsive layout for cards
                    _buildResponsiveCards(context, getCardSpacing()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveCards(BuildContext context, double spacing) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 768;

    const supportCards = [
      _SupportCard(
        title: "Help with a Skills Assessment",
        description:
            "Skills Assessment Support (SAS) services are for migration agents, legal practitioners and prospective applicants who are yet to submit their Skills Assessment application to VETASSESS.",
        linkText: "Skills Assessment Support",
        linkUrl: "/skills-assessment-for-migration/skills-assessment-support",
      ),
      _SupportCard(
        title: "Help with an urgent application",
        description:
            "For general and professional occupations, priority processing can be used to fast-track urgent applications.",
        linkText: "Fast-track applications",
        linkUrl:
            "/skills-assessment-for-migration/professional-occupations/priority-processing",
      ),
    ];

    if (isDesktop) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                child: supportCards[0],
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                child: supportCards[1],
              ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [supportCards[0], SizedBox(height: spacing), supportCards[1]],
      );
    }
  }
}

// Helper classes for better code organization
class _StepData {
  final String number;
  final String title;
  final String mainText;
  final String? additionalText;
  final List<_LinkData>? links;

  _StepData(
    this.number,
    this.title,
    this.mainText,
    this.additionalText, [
    this.links,
  ]);
}

class _LinkData {
  final String text;
  final bool isLink;

  _LinkData(this.text, this.isLink);
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

// Data model for migration options
class MigrationOption {
  final String title;
  final String imagePath;

  MigrationOption({required this.title, required this.imagePath});
}

// Enhanced SupportCard with responsive design
class _SupportCard extends StatelessWidget {
  final String title;
  final String description;
  final String linkText;
  final String linkUrl;

  const _SupportCard({
    required this.title,
    required this.description,
    required this.linkText,
    required this.linkUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 576;
    final bool isTablet = screenWidth >= 576 && screenWidth < 768;

    // Responsive card padding
    EdgeInsets getCardPadding() {
      if (isMobile) return const EdgeInsets.all(20);
      if (isTablet) return const EdgeInsets.all(24);
      return const EdgeInsets.all(28);
    }

    // Responsive typography for card content
    double getTitleFontSize() {
      if (isMobile) return 18;
      if (isTablet) return 20;
      return 22;
    }

    double getDescriptionFontSize() {
      if (isMobile) return 14;
      if (isTablet) return 15;
      return 16;
    }

    double getLinkFontSize() {
      if (isMobile) return 14;
      if (isTablet) return 15;
      return 16;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: getCardPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: getTitleFontSize(),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00565A),
                height: 1.3,
              ),
            ),
            SizedBox(height: isMobile ? 12 : 16),
            Text(
              description,
              style: TextStyle(
                fontSize: getDescriptionFontSize(),
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 20),
            GestureDetector(
              onTap: () {
                // Handle navigation
                Navigator.pushNamed(context, linkUrl);
              },
              child: Text(
                linkText,
                style: TextStyle(
                  fontSize: getLinkFontSize(),
                  color: const Color(0xFF00565A),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
