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
      double nextPos = currentPos + 300; // Approximate width of one card plus padding
      
      // If we're near the end, loop back to the top
      if (nextPos >= maxExtent) {
        _autoScrollController.animateTo(
          maxExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ).then((_) {
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
        _autoScrollController.animateTo(
          nextPos,
          duration: _scrollAnimDuration,
          curve: Curves.easeInOut,
        ).then((_) {
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
                  screenHeight
                ),
                 const SizedBox(height: 50),
                 _exploreMigrationOptionsSection(context),
                 const SizedBox(height: 50),
                _buildOccupationSearchSection(context),
                const SizedBox(height: 50),
                _buildSectionTitle(context, 'The application process'),
                const SizedBox(height: 30),
                  _buildApplicationSteps(context),
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
                SizedBox(height: 50,), 
                _supportSection( context),
                SizedBox(height: 50,),
                 _buildFaqSection(
                  'Explore FAQs',
                  [
                    'What is a highly relevant employment?',
                   
                  ],
                  false,
                  tealColor,
                  yellowColor,
                  dottedLineColor,
                  context,
                ),
                SizedBox(height: 50,),
                _otherMigrationPathwaysavailable( context),
               
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
      double bannerHeight = isMobile(screenWidth) 
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
              width: isMobile(screenWidth) 
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
                  mainAxisAlignment: isMobile(screenWidth) 
                      ? MainAxisAlignment.center 
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      "Skills Assessment for Professional Occupations",
                      style: TextStyle(
                        color: const Color(0xFFFFA000),
                        fontSize: isMobile(screenWidth) 
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
                        fontSize: isMobile(screenWidth) 
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
                  child: Text('Home', 
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


  // Unified method for both info sections (reducing duplicate code)
  List<Widget> _buildInfoSection(String title, String description,  
      String imagePath, bool imageOnRight, double screenWidth, double screenHeight) {
    
    final Widget infoColumn = SizedBox(
      width: screenWidth * 0.4,
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006064),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 20),
         
         
        ],
      ),
    );

    final Widget imageWidget = Image.asset(
      imagePath,
      height: 400,
      width: 500,
      fit: BoxFit.fitHeight,
    );

    final List<Widget> rowChildren = imageOnRight
        ? [infoColumn, imageWidget]
        : [imageWidget, infoColumn];

    return [
      Container(
        color: AppColors.color12,
        width: screenWidth,
        padding: EdgeInsets.symmetric(vertical: screenHeight / 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      )
    ];
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
              children: migrationOptions.map((option) {
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
        title: 'Chinese Qualification Verification Service',
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
                  children: migrationOptions.map((option) {
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
                        Expanded(child: _buildotherMigrationOptionCard(migrationOptions[0])),
                        const SizedBox(width: 16),
                        Expanded(child: _buildotherMigrationOptionCard(migrationOptions[1])),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child:_buildotherMigrationOptionCard(migrationOptions[2])),
                        const SizedBox(width: 16),
                        Expanded(child: _buildotherMigrationOptionCard(migrationOptions[3])),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  children: migrationOptions.map((option) {
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
            const Icon(
              Icons.arrow_forward,
              color: Color(0xFF0A594C),
              size: 20,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOccupationSearchSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 250),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 35),
        color: const Color(0xFF0A594C),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Search For Your Occupation",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFDB713),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            
            const Text(
              "Find out if we can assess your skills and experience",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            Container(
              constraints: const BoxConstraints(maxWidth: 620),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: const Color(0xFFFDB713), width: 1),
              ),
              child: Row(
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
                    width: 120,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildApplicationSteps(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 35),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step 1
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberedStep(context, '1', 'Nominate'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5A5A5A),
                  ),
                  children: [
                    const TextSpan(
                      text: 'Nominate an occupation',
                      style: TextStyle(
                        color: Color(0xFF006064),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                      ),
                    ),
                    const TextSpan(text: ' Check the qualification and employment requirements for your occupation.'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Connector line for step 1 to 2 - Modified to be shorter
        SizedBox(
          width: 80, // Reduced width
          child: Row(
            children: [
              Container(
                width: 80, // Matches the SizedBox width
                margin: const EdgeInsets.only(top: 30),
                height: 2,
                color: Colors.amber,
              ),
            ],
          ),
        ),
        // Step 2
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberedStep(context, '2', 'Check'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5A5A5A),
                  ),
                  children: [
                    const TextSpan(
                      text: 'Check your occupation description.',
                      style: TextStyle(
                        color: Color(0xFF006064),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                      ),
                    ),
                    const TextSpan(text: ' View the Professional Occupations list to understand whether your work experience matches the occupation description.'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Connector line for step 2 to 3 - Modified to be shorter
        SizedBox(
          width: 80, // Reduced width
          child: Row(
            children: [
              Container(
                width: 80, // Matches the SizedBox width
                margin: const EdgeInsets.only(top: 30),
                height: 2,
                color: Colors.amber,
              ),
            ],
          ),
        ),
        // Step 3
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberedStep(context, '3', 'Prepare'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5A5A5A),
                  ),
                  children: [
                    const TextSpan(text: 'Prepare for your application. Still unsure about the application criteria or documents? We have some optional services. '),
                    const TextSpan(
                      text: 'Get Skills Assessment Support.',
                      style: TextStyle(
                        color: Color(0xFF006064),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: ' Find out about '),
                    const TextSpan(
                      text: 'Priority Processing',
                      style: TextStyle(
                        color: Color(0xFF006064),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(text: ' to fast track your application.'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Connector line for step 3 to 4 - Modified to be shorter
        SizedBox(
          width: 80, // Reduced width
          child: Row(
            children: [
              Container(
                width: 80, // Matches the SizedBox width
                margin: const EdgeInsets.only(top: 30),
                height: 2,
                color: Colors.amber,
              ),
            ],
          ),
        ),
        // Step 4
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNumberedStep(context, '4', 'Apply'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF5A5A5A),
                  ),
                  children: [
                    const TextSpan(text: 'Apply now. You can '),
                    const TextSpan(
                      text: 'apply online.',
                      style: TextStyle(
                        color: Color(0xFF006064),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
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
     padding: const EdgeInsets.symmetric(horizontal: 15),
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
   Widget _supportSection(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768;
    
    return Container(
      color: const Color(0xFF00565A), // Base teal background color
      child: Stack(
        children: [
          // Background pattern - positioned to cover the right side
          Positioned(
            right: 0,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/block-bg.svg',
              width: MediaQuery.of(context).size.width * 0.5, // Cover about 70% of the width
              height: MediaQuery.of(context).size.height * 0.8, // Cover most of the height
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
            ),
          ),
          
          // Content container
          Container(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 26),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1244),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "I need help, what support is available?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    isDesktop
                        ? IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: _SupportCard(
                                      title: "Help with a Skills Assessment",
                                      description:
                                          "Skills Assessment Support (SAS) services are for migration agents, legal practitioners and prospective applicants who are yet to submit their Skills Assessment application to VETASSESS.",
                                      linkText: "Skills Assessment Support",
                                      linkUrl:
                                          "/skills-assessment-for-migration/skills-assessment-support",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 24),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: _SupportCard(
                                      title: "Help with an urgent application",
                                      description:
                                          "For general and professional occupations, priority processing can be used to fast-track urgent applications.",
                                      linkText: "Fast-track applications",
                                      linkUrl:
                                          "/skills-assessment-for-migration/professional-occupations/priority-processing",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: const [
                              _SupportCard(
                                title: "Help with a Skills Assessment",
                                description:
                                    "Skills Assessment Support (SAS) services are for migration agents, legal practitioners and prospective applicants who are yet to submit their Skills Assessment application to VETASSESS.",
                                linkText: "Skills Assessment Support",
                                linkUrl:
                                    "/skills-assessment-for-migration/skills-assessment-support",
                              ),
                              SizedBox(height: 24),
                              _SupportCard(
                                title: "Help with an urgent application",
                                description:
                                    "For general and professional occupations, priority processing can be used to fast-track urgent applications.",
                                linkText: "Fast-track applications",
                                linkUrl:
                                    "/skills-assessment-for-migration/professional-occupations/priority-processing",
                              ),
                            ],
                          ),
                  ],
                ),
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
    final Paint paint = Paint()
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

  MigrationOption({
    required this.title,
    required this.imagePath,
  });
}

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
    return Container(
      constraints: const BoxConstraints(minHeight: 260),
      decoration: BoxDecoration(
        
        color: Colors.white,
        borderRadius: BorderRadius.circular(4), // Slight rounding of corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00565A),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => context.go(linkUrl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        linkText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00565A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 26,
                        width: 26,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00565A),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 2,
                    width: 210,
                    margin: const EdgeInsets.only(top: 8),
                    color: const Color(0xFF00565A),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}