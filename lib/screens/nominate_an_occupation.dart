import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vetassess/theme.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

class NominateScreen extends StatelessWidget {
  const NominateScreen({super.key});

  static const Color tealColor = Color(0xFF00565B);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrLarger = screenWidth > 768;
    final screenHeight = MediaQuery.of(context).size.height;

    return BasePageLayout(
      child: Column(
        children: [
          _buildResponsiveHeaderBanner(),
          _buildResponsiveBreadcrumbs(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._buildProcessSteps(screenWidth, screenHeight),
                const SizedBox(height: 90),
                _buildSkillednominate(context),
                const SizedBox(height: 90),

                // Content sections with dividers between them
                _buildContentSection(
                  context,
                  title: 'Which occupation should I nominate?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: _buildContentWidgets(context),
                ),

                _buildContentSection(
                  context,
                  title: 'What if my occupation is not listed?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: _buildmyoccupationWidgets(context),
                ),

                _buildContentSection(
                  context,
                  title: 'What is a highly relevant field of study?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'When your education qualifications are assessed, we will consider the relevance of your education to your nominated occupation',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'A highly relevant field of study is the major field of your qualification that matches your nominated occupation for skills assessment purposes. It is the discipline (study area) which is assessed as suitable preparation for employment in your nominated occupation in Australia.',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'In order to determine whether a qualification is in a highly relevant field of study to the nominated occupation, VETASSESS considers a number of factors including:',
                    ),
                    _buildSpacing(20),
                    _buildBulletPoints(
                      'Whether you hold a specialised qualification or whether your qualification has a major or major field of study that is suitable for the occupation in Australia',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'The depth (progression) and breadth of study in the major',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'The employment outcomes of the qualification in the country where it was awarded',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'Course requirements - including whether any thesis work, major projects, internships/work placements were needed for the qualification to be achieved.',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title: 'What is study at the required educational level?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'Your qualification must be at the educational level required for your nominated occupation. Each occupation requires a specific educational level based on the Australian Qualifications Framework (AQF). Occupations are also defined by an employment skill level. For example, the occupation of Actuary (ANZSCO Code 224111) requires an applicant to hold a formal academic qualification assessed at Australian Bachelor degree or a higher degree level.',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'To determine how the educational level comparability of an overseas qualification compares against the AQF, we consider:',
                    ),
                    _buildSpacing(20),
                    _buildBulletPoints(
                      'The education system of the country where qualifications were obtained',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'The accreditation status and recognition of the awarding institution and the program of study in the home country',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'The level, structure, length and content of the program of study undertaken',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'Please note that we will not assess an Australian Graduate Diploma or comparable overseas postgraduate diploma, either alone or in combination with underpinning sub-degree qualifications, for comparability to the educational level of an Australian Bachelor degree. This is due to the different nature and learning outcomes of an Australian Bachelor degree compared to other qualifications on the AQF. Therefore, a qualification assessed at AQF Graduate Diploma level cannot be used to meet the requirements of occupations that require a minimum of an AQF Bachelor degree level. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'The Postgraduate Diploma may, however, be considered for assessment against the requirements of occupations that require a qualification at AQF Diploma or Advanced Diploma/Associate degree level.',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title: 'What is highly relevant employment?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'Only full time (at least 20 hours per week) and paid employment can be considered for skills assessment purposes. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'The major tasks undertaken in your everyday work should closely match major tasks usually undertaken in that occupation in Australia. The employment to be assessed must also be performed at the required skill level of the nominated occupation. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'For employment to be considered'
                      'skilled'
                      ','
                      'it must meet two requirements:',
                    ),
                    _buildSpacing(20),
                    _buildBulletPoints(
                      'That it was undertaken after you met the entry level requirements for the nominated occupation',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'That it involved your primary/main duties being performed at the level of depth and complexity for the nominated occupation. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'Each ANZCO Unit Group of occupations lists a range of tasks based on the nature of each occupation as well as the differing skill levels required. Occupation tasks may vary in terms of the scope of responsibilities, knowledge and skills required.',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title: 'Leave periods',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'Only periods of leave on full pay may be counted as paid employment for assessment purposes. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'Irregular work periods that average out to 20 hours per week over a year will not be considered. For example, if you have worked in your nominated occupation for 12 hours per week over a three-month period and then worked 40 hours per week over a seven-month period, only the seven-month period would be considered for skills assessment purposes. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'Unpaid/partially paid leave, volunteer services or work towards gaining professional skills and/or qualifications will not be considered as paid employment at the required skill level of a nominated occupation for skills assessment purposes.',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title: 'What is the qualifying period?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'Qualifying Period is the employment duration required to meet the required skills assessment criteria for the nominated occupation. As such, the years of work experience required to meet the skills assessment criteria will not be included in the total number of years assessed positively for points test purposes.',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title: 'What is pre- and post-qualification employment?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'The skill level for employment is considered to be post-qualification if the employment follows a qualification that is assessed at the required educational level for the nominated occupation. For Groups A and E, the employment must be post-qualification. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'In some cases, applicants may have gained relevant employment experience prior to achieving the required qualification. If your selected occupation is classified in Groups B, C, D and F, pre-qualification employment may be considered for skills assessment purposes. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'The criteria for pre-qualification employment include a period of "qualifying" employment preceding the required one year of highly relevant employment at an appropriate skill level.',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'Pre-qualification employment requirements for groups B, C, D and F are as follows:',
                    ),
                    _buildSpacing(20),
                    _buildBulletPoints(
                      'Group B – five years of relevant employment required in addition to at least one year of highly relevant employment performed at the required skill level in the last 5 years before applying',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'Groups C, D and F – three years of relevant employment required in addition to at least one year of highly relevant employment performed at the required skill level in the last 5 years before applying. ',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title:
                      'What is'
                      'Date Deemed Skilled'
                      '?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'As part of the assessment process, VETASSESS will determine the date you met the skill level requirements for the nominated occupation. VETASSESS will only count skilled employment post the Date Deemed Skilled as eligible for points test purposes. ',
                    ),
                    _buildSpacing(20),
                    _buildLinkText(
                      context,
                      'The Date Deemed Skilled noted on the VETASSESS outcome letter is determined by assessing your qualifications and employment against the VETASSESS skills assessment criteria for your nominated occupation. For information on the criteria that applies to your selected occupation, please click ',
                      'here',
                      '',
                    ),
                    _buildSpacing(20),
                    _buildLinkText(
                      context,
                      'Once we have determined the Date that your qualifications and employment meet our criteria for the occupation, all highly relevant and/or',
                      'closly related',
                      ' work experience post that Date and within the last ten years before applying is considered as skilled employment that is eligible for points test purposes.',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'Your outcome letter will state the work experience that was considered towards meeting the criteria (Qualifying Period) and the employment post that can be considered towards calculation of points.',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title: 'What is closely related employment?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'VETASSESS will only count skilled employment post the Date Deemed Skilled as eligible for points test purposes. In these circumstances, the claimed employment will need to be related to and at the skill level of your nominated occupation. This means that you must have undertaken closely related employment that is paid employment of at least 20 hours per week in an occupation in the same Unit Group of ANZSCO (the Australian and New Zealand Standard Classification of Occupations) as the nominated occupation. Generally, all ANZSCO unit groups are at one skill level, which is defined as a function of the range and complexity of the set of tasks performed in a particular occupation. In addition to this, VETASSESS will also consider closely related employment that is consistent with a career advancement pathway relating to your nominated occupation. Career advancement would usually take the form of a promotion to a senior role or higher level that relates to your nominated occupation and incorporates greater responsibility.',
                    ),
                  ],
                ),

                const SizedBox(height: 90),
                _buildSkilledOccupationsListsSection(context),

                _buildContentSection(
                  context,
                  title: 'What is ANZSCO?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'The occupations in ANZSCO have a 6 digit code and are grouped by occupation type: ',
                    ),
                    _buildSpacing(20),
                    _buildBulletPoints('Major Group 1 Managers'),
                    _buildSpacing(10),
                    _buildBulletPoints('Major Group 2 Professionals '),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'Major Group 3 Technicians and Trades Workers',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'Major Group 4 Community and Personal services Workers ',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'Major Group 5 Clerical and Administrative Workers',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints('Major Group 6 Sales Workers'),
                    _buildSpacing(10),
                    _buildBulletPoints(
                      'Major Group 7 Machinery Operators and Drivers',
                    ),
                    _buildSpacing(10),
                    _buildBulletPoints('Major Group 8 Labourers'),
                    _buildSpacing(20),
                    _buildLinkText(
                      context,
                      'To find out more information about the definition of ANZSCO Codes, refer to the ',
                      ' Australian Bureau of Statistics (ABS) ',
                      ' website. ',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title:
                      'ANZSCO has been updated. Has this affected VETASSESS assessments?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'We conduct assessments based on the ANZSCO codes the Australian Government has authorised us to do. The occupation codes we use are those specified in the legislative instruments giving us the authority to assess occupations for migration purposes, and not necessarily those in the latest ANZSCO updates. ',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title:
                      "What is an 'nec' occupation and how does VETASSESS assess this type of occupation?",
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      "'nec' which means 'not elsewhere classified'. These are occupations that are not separately identified in ANZSCO, the Australian and New Zealand Standard Classification of Occupations used to determine the education and employment experience needed for a job role. Applicants for a skills assessment nominate an occupation under the 'nec' code when they hold qualifications and employment that do not better fit under any other ANZSCO code. ",
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'If nominating one of these occupations, you must ensure that your qualifications and employment are highly relevant to one of the occupation titles given in the ANZSCO description for that occupation. Other specific occupation titles that cannot be found elsewhere in ANZSCO will be considered on a case-by-case basis as long as they are relevant to the'
                      'nec'
                      ' codes. In order to be assessed against an NEC code, your occupation would generally be described as non-classified, yet specialised or related to its ANZSCO Unit Group description. ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'Your employment in these nominated occupations should not better match another ANZSCO code (whether assessed by VETASSESS or not). ',
                    ),
                    _buildSpacing(20),
                    _buildText(
                      'When considering whether to nominate a'
                      'nec'
                      'occupation, you should consider the sub-major group description and determine whether your skills best fit this category. ',
                    ),
                  ],
                ),

                _buildContentSection(
                  context,
                  title:
                      'Which occupation do you recommend for my visa option?',
                  isTabletOrLarger: isTabletOrLarger,
                  content: [
                    _buildText(
                      'VETASSESS can only provide information regarding our assessment process. We are unable to tell you which visa is best for you, which state or territory list your occupation appears on, or whether you will meet the visa requirements. For any questions regarding visa requirements and/ or eligibility, you should contact the Department of Home Affairs. ',
                    ),
                    _buildSpacing(20),
                    _buildLinkText(
                      context,
                      'You need to decide which occupation to nominate before submitting an application for assessment with VETASSESS. If you are unsure about which occupation may be best suited to your credentials, you may consider using our Skills Assessment Support (SAS) consultation services. You can read more about the SAS consultation services by clicking',
                      ' here ',
                      '',
                    ),
                  ],
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create spacing
  Widget _buildSpacing(double height) => SizedBox(height: height);

  // Helper method to create consistent text
  Widget _buildText(String text) => Text(
    text,
    style: const TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
  );

  // Helper method to create consistent dividers
  Widget _buildDivider() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          height: 1,
          color: const Color(0xFFF9D342),
          width: double.infinity,
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // Helper method to build content sections with responsive layout and dividers
  Widget _buildContentSection(
    BuildContext context, {
    required String title,
    required bool isTabletOrLarger,
    required List<Widget> content,
  }) {
    final sectionWidget = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child:
          isTabletOrLarger
              ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D5C63),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: content,
                    ),
                  ),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D5C63),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...content,
                ],
              ),
    );

    return Column(children: [sectionWidget, _buildDivider()]);
  }

  Widget _buildSkilledOccupationsListsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skilled Occupations Lists',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D5C63),
            ),
          ),
          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildText(
                      'Occupations may be removed from the Skilled Occupation List at any time and without notice by the Australian Government. You are responsible for ensuring that your proposed occupation is eligible at the date you submit your application to VETASSESS. Should your application be affected by the removal of an occupation from any of these lists please be advised that VETASSESS will continue with the assessment for suitability against your selected occupation.',
                    ),
                    _buildSpacing(20),
                    _buildLinkText(
                      context,
                      'For visa-related requirements including caveats that may apply for certain occupations, please visit the ',
                      'Department of Home Affairs',
                      ' website.',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: SizedBox(
                    height: 400,
                    child: Image.asset(
                      'assets/images/application_status.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildSkillednominate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/consultation_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText(
                  'For some Group classifications, you can still apply with a qualification that is not highly relevant to the occupation, but only if you can provide evidence that you have additional years of highly relevant employment, performed at the required skill level.',
                ),
                _buildSpacing(20),
                _buildText(
                  'For applicants who meet the skills assessment criteria, we will then determine the date that you were "deemed", or considered to be, skilled in your nominated occupation within a ten-year period.',
                ),
                _buildSpacing(20),
                _buildText(
                  'For applicants who meet the skills assessment criteria, we will then determine the date that you were "deemed", or considered to be, skilled in your nominated occupation within a ten-year period.',
                ),
              ],
            ),
          ),
        ],
      ),
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
            style: const TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
          ),
        ),
      ],
    );
  }

  // Helper method for text with links
  Widget _buildLinkText(
    BuildContext context,
    String prefix,
    String linkText,
    String suffix,
  ) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 16,
          color: const Color(0xFF5A5A5A),
        ),
        children: [
          TextSpan(text: prefix),
          TextSpan(
            text: linkText,
            style: const TextStyle(
              color: Color(0xFF0D5C63),
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    // Link functionality would go here
                  },
          ),
          TextSpan(text: suffix),
        ],
      ),
    );
  }

  List<Widget> _buildProcessSteps(double screenWidth, double screenHeight) {
    // Determine if we're on a mobile device
    bool isMobile = screenWidth < 768;
    bool isTablet = screenWidth >= 768 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;

    // Calculate responsive dimensions
    double horizontalPadding =
        screenWidth *
        (isMobile
            ? 0.05
            : isTablet
            ? 0.08
            : 0.1);
    double verticalPadding = screenHeight * (isMobile ? 0.02 : 0.03);

    // Responsive font sizes
    double titleFontSize =
        isMobile
            ? 18
            : isTablet
            ? 22
            : 24;
    double bodyFontSize = isMobile ? 14 : 16;

    // Image dimensions
    double imageHeight =
        isMobile
            ? 250
            : isTablet
            ? 300
            : 400;
    double imageWidth =
        isMobile
            ? screenWidth * 0.9
            : isTablet
            ? 600
            : 800;

    return [
      Container(
        color: AppColors.color12,
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child:
            isMobile
                ? _buildMobileLayout(
                  screenWidth,
                  titleFontSize,
                  bodyFontSize,
                  imageHeight,
                  imageWidth,
                )
                : _buildDesktopLayout(
                  screenWidth,
                  titleFontSize,
                  bodyFontSize,
                  imageHeight,
                  imageWidth,
                ),
      ),
    ];
  }

  Widget _buildMobileLayout(
    double screenWidth,
    double titleFontSize,
    double bodyFontSize,
    double imageHeight,
    double imageWidth,
  ) {
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
                'You will need to nominate an occupation when you apply for a Skills Assessment',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF006064),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Generally, for a Skills Assessment application lodged under either ENS, GSM, RSMS or SID visa categories, applicants are required to hold a qualification that is at the educational level required and which is in a highly relevant field to the nominated occupation.',
                style: TextStyle(
                  fontSize: bodyFontSize,
                  height: 1.5,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'In addition to the qualification requirements you also have to provide evidence of having at least one year of highly relevant employment performed at the required skill level within the last five years, from the date of lodging your application.',
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

  Widget _buildDesktopLayout(
    double screenWidth,
    double titleFontSize,
    double bodyFontSize,
    double imageHeight,
    double imageWidth,
  ) {
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
                  'You will need to nominate an occupation when you apply for a Skills Assessment',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF006064),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Generally, for a Skills Assessment application lodged under either ENS, GSM, RSMS or SID visa categories, applicants are required to hold a qualification that is at the educational level required and which is in a highly relevant field to the nominated occupation.',
                  style: TextStyle(
                    fontSize: bodyFontSize,
                    height: 1.5,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'In addition to the qualification requirements you also have to provide evidence of having at least one year of highly relevant employment performed at the required skill level within the last five years, from the date of lodging your application.',
                  style: TextStyle(
                    fontSize: bodyFontSize,
                    height: 1.5,
                    letterSpacing: 0.3,
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

  // Content widgets for the first section
  List<Widget> _buildContentWidgets(BuildContext context) {
    return [
      _buildLinkText(
        context,
        'Before nominating an occupation, make sure it is available for migration under the relevant visa type. For information about visa types, visit ',
        'Department of Home Affairs',
        ' website.',
      ),
      _buildSpacing(20),

      _buildText(
        'We conduct skills assessment under ANZSCO criteria as set by the Australian Government.',
      ),
      _buildSpacing(20),

      Row(
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
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(
                    text: 'For most occupations, assessments are based on ',
                  ),
                  const TextSpan(
                    text: 'ANZSCO 2013',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ', as referenced in the applicable legislation.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      _buildSpacing(10),

      Row(
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
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(text: 'For the '),
                  const TextSpan(
                    text: 'Core Skills stream',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' of the '),
                  const TextSpan(
                    text: 'Skills in Demand (subclass 482) visa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' and the '),
                  const TextSpan(
                    text:
                        'Direct Entry stream of the Employer Nomination Scheme (subclass 186) visa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ', assessments align with '),
                  const TextSpan(
                    text: 'ANZSCO 2022',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text:
                        '. This later version of ANZSCO benchmarks the Core Skills Occupation List (CSOL), which the Government released in December 2024.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      _buildSpacing(20),

      _buildText(
        'It is important to check the specific requirements of your intended visa and relevant legislation to confirm the correct ANZSCO version applicable for the skills assessment of your nominated occupation.',
      ),
      _buildSpacing(20),

      _buildLinkText(
        context,
        'For information about the Australian and New Zealand Standard Classification of Occupations (ANZSCO), please refer to the ',
        'Australian Bureau of Statistics (ABS)',
        ' website. Please note that many occupations listed in ANZSCO may not be available for skilled visa purposes.',
      ),
      _buildSpacing(20),

      _buildLinkText(
        context,
        'We offer an optional services of a customised consultation for professional and other non-trade occupations. Click ',
        'here to find out more about our Skills Assessment Support (SAS) services',
        '.',
      ),
    ];
  }

  // Content widgets for the occupation section
  List<Widget> _buildmyoccupationWidgets(BuildContext context) {
    return [
      _buildLinkText(
        context,
        'If your occupation is not listed with us, you can try locating the occupation on the ',
        'Department of Home Affairs',
        ' website. Details of the relevant assessing authority will be listed there too.',
      ),
    ];
  }

  // Add this helper method to determine device type
  bool _isMobile(double width) => width < 600;
  bool _isTablet(double width) => width >= 600 && width < 1024;
  bool _isDesktop(double width) => width >= 1024;

  Widget _buildHeaderBanner(double screenHeight, double screenWidth) {
    final isMobile = _isMobile(screenWidth);
    final isTablet = _isTablet(screenWidth);

    return Container(
      width: screenWidth,
      height: isMobile ? screenHeight * 0.50 : screenHeight * 0.60,
      decoration: const BoxDecoration(color: tealColor),
      child: Stack(
        children: [
          // Background image - responsive positioning
          Positioned(
            right: 0,
            child: Image.asset(
              'assets/images/internal_page_banner.png',
              height: isMobile ? screenHeight * 0.50 : screenHeight * 0.60,
              fit: BoxFit.fitHeight,
            ),
          ),

          // Content container - responsive width and padding
          Container(
            width:
                isMobile
                    ? screenWidth * 0.95
                    : isTablet
                    ? screenWidth * 0.8
                    : screenWidth * 0.66,
            padding: EdgeInsets.only(
              top:
                  isMobile
                      ? 60
                      : isTablet
                      ? 80
                      : 100,
              left:
                  isMobile
                      ? 20
                      : isTablet
                      ? 40
                      : 170,
              right: isMobile ? 20 : 0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    isMobile
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                children: [
                  Text(
                    "Nominate an Occupation",
                    style: TextStyle(
                      color: const Color(0xFFFFA000),
                      fontSize:
                          isMobile
                              ? 28
                              : isTablet
                              ? 36
                              : 42,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 30),
                  Text(
                    isMobile
                        ? "The process begins by nominating the occupation that is most relevant to your qualification/s and employment."
                        : "The process begins by nominating the occupation that is most relevant to your \nqualification/s and employment.",
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
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs(double screenWidth) {
    final isMobile = _isMobile(screenWidth);
    final isTablet = _isTablet(screenWidth);

    const TextStyle linkStyle = TextStyle(
      fontSize: 14,
      color: tealColor,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal:
            isMobile
                ? 20
                : isTablet
                ? 40
                : 150,
      ),
      child:
          isMobile
              ? _buildMobileBreadcrumbs(linkStyle)
              : _buildDesktopBreadcrumbs(linkStyle),
    );
  }

  // Mobile breadcrumbs - stacked vertically for better readability
  Widget _buildMobileBreadcrumbs(TextStyle linkStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text('Home', style: linkStyle),
        ),
        const SizedBox(height: 4),
        Text(
          'Application process for a professional or general skills application',
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  // Desktop breadcrumbs - horizontal layout
  Widget _buildDesktopBreadcrumbs(TextStyle linkStyle) {
    return Row(
      children: [
        TextButton(onPressed: () {}, child: Text('Home', style: linkStyle)),
        const Text(' / ', style: TextStyle(color: Colors.grey)),
        Flexible(
          child: Text(
            'Application process for a professional or general skills application',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Alternative approach using LayoutBuilder for more precise control
  Widget _buildResponsiveHeaderBanner() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = MediaQuery.of(context).size.height;

        return _buildHeaderBanner(screenHeight, screenWidth);
      },
    );
  }

  Widget _buildResponsiveBreadcrumbs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildBreadcrumbs(constraints.maxWidth);
      },
    );
  }
}
