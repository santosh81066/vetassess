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
                _buildPreparingAppSection(),
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

  // Unified method for both info sections (reducing duplicate code)
  List<Widget> _buildInfoSection(
    String title,
    String description,
    String additionalText,
    String imagePath,
    bool imageOnRight,
    double screenWidth,
    double screenHeight,
  ) {
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
          Text(
            additionalText,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 25),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            child: const Text(
              'Find Out More',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF006064),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );

    final Widget imageWidget = Image.asset(
      imagePath,
      height: 400,
      width: 500,
      fit: BoxFit.fitHeight,
    );

    final List<Widget> rowChildren =
        imageOnRight ? [infoColumn, imageWidget] : [imageWidget, infoColumn];

    return [
      Container(
        color: AppColors.color12,
        width: screenWidth,
        padding: EdgeInsets.symmetric(vertical: screenHeight / 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      ),
    ];
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

  Widget _buildPreparingAppSection() {
    final List<String> navigationLinks = [
      'Apply online',
      'Track your Application',
      'View Current Processing Times',
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: 450,
            padding: const EdgeInsets.only(top: 40, bottom: 40, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Do you need your skills assessed? Find out how.",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A594C),
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Getting your skills assessed is a requirement for skilled migration to Australia. Below, you'
                  'll find information and resources on what you need to do to get your skills assessed with us.',
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
          flex: 1,
          child: Container(
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  navigationLinks.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final String link = entry.value;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                link,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
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
          ),
        ),
      ],
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

  Widget _buildHowToApply(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 150),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'How to apply',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: Color(0xFF00695C),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Color(0xFF00695C),
                  unselectedLabelColor: Colors.black45,
                  indicatorColor: Color(0xFFFFA000),
                  indicatorWeight: 4,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(text: "If you're a Professional"),
                    Tab(text: 'If you have Trade skills'),
                  ],
                ),
                const SizedBox(height: 48),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    children: [
                      _ProfessionalOccupationsContent(),
                      _TradeOccupationsContent(),
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

class _ProfessionalOccupationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "If you're a professional choosing to migrate to Australia, chances are you're likely to be "
          "assessed by us. We assess 361 different professional occupations, assessing your skills, "
          "experience and qualifications.",
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _StepColumn(
              number: "1",
              title: "Find",
              description:
                  "Find the VETASSESS occupation that most closely fits your skills and experience.",
            ),
            _DottedLine(),
            _StepColumn(
              number: "2",
              title: "Match",
              description:
                  "Match your skills and experience to your chosen occupation.",
            ),
            _DottedLine(),
            _StepColumn(
              number: "3",
              title: "Prepare",
              description:
                  "Get ready to apply by preparing all the information and documents you need.",
            ),
            _DottedLine(),
            _StepColumn(
              number: "4",
              title: "Apply",
              description:
                  "Apply online when you're ready. If you're still unsure,",
              linkText: "skills assessment support",
              linkDescription: "is available when you need it.",
            ),
          ],
        ),
      ],
    );
  }
}

class _TradeOccupationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "If you're a tradesperson, your skills and experience will be assessed by someone who has worked in your trade and understands your skills and qualifications. VETASSESS is Australia's leading assessment body for trades and we can assess 27 different trade occupations.",
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _StepColumn(
              number: "1",
              title: "Step 1",
              description: "Check your",
              linkText: "eligibility ",
              linkDescription: "apply for a Trade Skills Assessment.",
            ),
            _DottedLine(),
            _StepColumn(
              number: "2",
              title: "Step 2",
              description: "Understand the",
              linkText: "Assessment Process  ",
            ),
            _DottedLine(),
            _StepColumn(
              number: "3",
              title: "Step 3",
              description: "Confirm the type of",
              linkText: "evidence ",
              linkDescription: "you may be asked to provide ",
            ),
            _DottedLine(),
            _StepColumn(
              number: "4",
              title: "Step 4",
              description: "Find the",
              linkText: "cost",
              linkDescription:
                  "you'll need to pay up front for your trade skills assessment ",
            ),
            _DottedLine(),
            _StepColumn(
              number: "5",
              title: "Step 5",
              description: '',
              linkText: "Apply now. ",
            ),
          ],
        ),
      ],
    );
  }
}

class _StepColumn extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final String? linkText;
  final String? linkDescription;

  const _StepColumn({
    required this.number,
    required this.title,
    required this.description,
    this.linkText,
    this.linkDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          if (linkText != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: RichText(
                textAlign: TextAlign.center,
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

class _DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Center(
        child: CustomPaint(painter: _DottedLinePainter(), size: Size(60, 2)),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFFA000)
          ..strokeWidth = 3
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
