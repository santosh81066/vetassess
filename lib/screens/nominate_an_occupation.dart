import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

class NominateScreen extends StatelessWidget {
  const NominateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTabletOrLarger = screenWidth > 768;
    
    return BasePageLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 90),

          _buildSkillednominateanoccupation(context),

           const SizedBox(height: 90),
          _buildSkillednominate(context),
           
           const SizedBox(height: 90),
            
            // Content sections
            _buildDivider(),
            
            _buildSection(
              context,
              title: 'Which occupation should I nominate?',
              isTabletOrLarger: isTabletOrLarger,
              contentBuilder: _buildContentWidgets,
            ),
            
            _buildDivider(),
            
            _buildSection(
              context,
              title: 'What if my occupation is not listed?',
              isTabletOrLarger: isTabletOrLarger,
              contentBuilder: _buildmyoccupationWidgets,
            ),
            
            _buildDivider(),
            
            // Add standard section for consistent formatting
            _buildStandardSection(
              context, 
              'What is a highly relevant field of study?',
              [
                const Text(
                  'When your education qualifications are assessed, we will consider the relevance of your education to your nominated occupation',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'A highly relevant field of study is the major field of your qualification that matches your nominated occupation for skills assessment purposes. It is the discipline (study area) which is assessed as suitable preparation for employment in your nominated occupation in Australia.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'In order to determine whether a qualification is in a highly relevant field of study to the nominated occupation, VETASSESS considers a number of factors including:',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                _buildBulletPoints(
                  'Whether you hold a specialised qualification or whether your qualification has a major or major field of study that is suitable for the occupation in Australia',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'The depth (progression) and breadth of study in the major',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'The employment outcomes of the qualification in the country where it was awarded',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Course requirements - including whether any thesis work, major projects, internships/work placements were needed for the qualification to be achieved.',
                ),
              ],
            ),
            
            _buildDivider(),
            
            _buildStandardSection(
              context,
              'What is study at the required educational level?',
              [
                const Text(
                  'Your qualification must be at the educational level required for your nominated occupation. Each occupation requires a specific educational level based on the Australian Qualifications Framework (AQF). Occupations are also defined by an employment skill level. For example, the occupation of Actuary (ANZSCO Code 224111) requires an applicant to hold a formal academic qualification assessed at Australian Bachelor degree or a higher degree level.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'To determine how the educational level comparability of an overseas qualification compares against the AQF, we consider:',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                _buildBulletPoints(
                  'The education system of the country where qualifications were obtained',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'The accreditation status and recognition of the awarding institution and the program of study in the home country',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'The level, structure, length and content of the program of study undertaken',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please note that we will not assess an Australian Graduate Diploma or comparable overseas postgraduate diploma, either alone or in combination with underpinning sub-degree qualifications, for comparability to the educational level of an Australian Bachelor degree. This is due to the different nature and learning outcomes of an Australian Bachelor degree compared to other qualifications on the AQF. Therefore, a qualification assessed at AQF Graduate Diploma level cannot be used to meet the requirements of occupations that require a minimum of an AQF Bachelor degree level. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'The Postgraduate Diploma may, however, be considered for assessment against the requirements of occupations that require a qualification at AQF Diploma or Advanced Diploma/Associate degree level.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
              ],
            ),
            
            _buildDivider(),
            
            _buildStandardSection(
              context,
              'What is highly relevant employment?',
              [
                const Text(
                  'Only full time (at least 20 hours per week) and paid employment can be considered for skills assessment purposes. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'The major tasks undertaken in your everyday work should closely match major tasks usually undertaken in that occupation in Australia. The employment to be assessed must also be performed at the required skill level of the nominated occupation. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'For employment to be considered' 'skilled' ',' 'it must meet two requirements:',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                _buildBulletPoints(
                  'That it was undertaken after you met the entry level requirements for the nominated occupation',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'That it involved your primary/main duties being performed at the level of depth and complexity for the nominated occupation. ',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Each ANZCO Unit Group of occupations lists a range of tasks based on the nature of each occupation as well as the differing skill levels required. Occupation tasks may vary in terms of the scope of responsibilities, knowledge and skills required.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
              ],
            ),
            
            _buildDivider(),
            
            _buildStandardSection(
              context,
              'Leave periods',
              [
                const Text(
                  'Only periods of leave on full pay may be counted as paid employment for assessment purposes. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Irregular work periods that average out to 20 hours per week over a year will not be considered. For example, if you have worked in your nominated occupation for 12 hours per week over a three-month period and then worked 40 hours per week over a seven-month period, only the seven-month period would be considered for skills assessment purposes. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Unpaid/partially paid leave, volunteer services or work towards gaining professional skills and/or qualifications will not be considered as paid employment at the required skill level of a nominated occupation for skills assessment purposes.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
              ],
            ),
            
            _buildDivider(),
            
            _buildStandardSection(
              context,
              'What is the qualifying period?',
              [
                const Text(
                  'Qualifying Period is the employment duration required to meet the required skills assessment criteria for the nominated occupation. As such, the years of work experience required to meet the skills assessment criteria will not be included in the total number of years assessed positively for points test purposes.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
              ],
            ),
            
            _buildDivider(),
            
            _buildStandardSection(
              context,
              'What is pre- and post-qualification employment?',
              [
                const Text(
                  'The skill level for employment is considered to be post-qualification if the employment follows a qualification that is assessed at the required educational level for the nominated occupation. For Groups A and E, the employment must be post-qualification. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'In some cases, applicants may have gained relevant employment experience prior to achieving the required qualification. If your selected occupation is classified in Groups B, C, D and F, pre-qualification employment may be considered for skills assessment purposes. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'The criteria for pre-qualification employment include a period of "qualifying" employment preceding the required one year of highly relevant employment at an appropriate skill level.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Pre-qualification employment requirements for groups B, C, D and F are as follows:',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                _buildBulletPoints(
                  'Group B – five years of relevant employment required in addition to at least one year of highly relevant employment performed at the required skill level in the last 5 years before applying',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Groups C, D and F – three years of relevant employment required in addition to at least one year of highly relevant employment performed at the required skill level in the last 5 years before applying. ',
                ),
              ],
            ),
            
            _buildDivider(),
            
            _buildStandardSection(
              context,
              'What is' 'Date Deemed Skilled''?',
              [
                const Text(
                  'As part of the assessment process, VETASSESS will determine the date you met the skill level requirements for the nominated occupation. VETASSESS will only count skilled employment post the Date Deemed Skilled as eligible for points test purposes. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: 'The Date Deemed Skilled noted on the VETASSESS outcome letter is determined by assessing your qualifications and employment against the VETASSESS skills assessment criteria for your nominated occupation. For information on the criteria that applies to your selected occupation, please click ',
                      ),
                      TextSpan(
                        text: 'here',
                        style: const TextStyle(
                          color: Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: 'Once we have determined the Date that your qualifications and employment meet our criteria for the occupation, all highly relevant and/or',
                      ),
                      TextSpan(
                        text: 'closly related',
                        style: const TextStyle(
                          color: Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: ' work experience post that Date and within the last ten years before applying is considered as skilled employment that is eligible for points test purposes.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your outcome letter will state the work experience that was considered towards meeting the criteria (Qualifying Period) and the employment post that can be considered towards calculation of points.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
              ],
            ),
            
            _buildDivider(),
            
            _buildStandardSection(
              context,
              'What is closely related employment?',
              [
                const Text(
                  'VETASSESS will only count skilled employment post the Date Deemed Skilled as eligible for points test purposes. In these circumstances, the claimed employment will need to be related to and at the skill level of your nominated occupation. This means that you must have undertaken closely related employment that is paid employment of at least 20 hours per week in an occupation in the same Unit Group of ANZSCO (the Australian and New Zealand Standard Classification of Occupations) as the nominated occupation. Generally, all ANZSCO unit groups are at one skill level, which is defined as a function of the range and complexity of the set of tasks performed in a particular occupation. In addition to this, VETASSESS will also consider closely related employment that is consistent with a career advancement pathway relating to your nominated occupation. Career advancement would usually take the form of a promotion to a senior role or higher level that relates to your nominated occupation and incorporates greater responsibility.',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
              ],
            ),
             const SizedBox(height: 90),

           // for Skilled Occupations Lists.......
           _buildSkilledOccupationsListsSection(context),
           

            _buildDivider(),
       
            _buildStandardSection(
              context,
              'What is ANZSCO?',
              [
                const Text(
                  'The occupations in ANZSCO have a 6 digit code and are grouped by occupation type: ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                const SizedBox(height: 20),
                _buildBulletPoints(
                  'Major Group 1 Managers',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Major Group 2 Professionals ',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Major Group 3 Technicians and Trades Workers',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Major Group 4 Community and Personal Service Workers ',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Major Group 5 Clerical and Administrative Workers',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Major Group 6 Sales Workers',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Major Group 7 Machinery Operators and Drivers',
                ),
                const SizedBox(height: 10),
                _buildBulletPoints(
                  'Major Group 8 Labourers',
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: 'To find out more information about the definition of ANZSCO Codes, refer to the ',
                      ),
                      
                      TextSpan(
                        text: ' Australian Bureau of Statistics (ABS) ',
                        style: const TextStyle(
                          color: Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: 'website. ',
                      ),
                    ],
                  ),
                ),
               
              ],
            ),


             _buildDivider(),
            
            _buildStandardSection(
              context,
              'ANZSCO has been updated. Has this affected VETASSESS assessments?',
              [
                const Text(
                  'We conduct assessments based on the ANZSCO codes the Australian Government has authorised us to do. The occupation codes we use are those specified in the legislative instruments giving us the authority to assess occupations for migration purposes, and not necessarily those in the latest ANZSCO updates. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
              ],
            ),

             _buildDivider(),
            
            _buildStandardSection(
              context,
              'What is an ‘nec’ occupation and how does VETASSESS assess this type of occupation?',
              [
                const Text(
                  '‘nec’ which means ‘not elsewhere classified’. These are occupations that are not separately identified in ANZSCO, the Australian and New Zealand Standard Classification of Occupations used to determine the education and employment experience needed for a job role. Applicants for a skills assessment nominate an occupation under the ‘nec’ code when they hold qualifications and employment that do not better fit under any other ANZSCO code. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                 const SizedBox(height: 20),
                 const Text(
                  'If nominating one of these occupations, you must ensure that your qualifications and employment are highly relevant to one of the occupation titles given in the ANZSCO description for that occupation. Other specific occupation titles that cannot be found elsewhere in ANZSCO will be considered on a case-by-case basis as long as they are relevant to the' 'nec'' codes. In order to be assessed against an NEC code, your occupation would generally be described as non-classified, yet specialised or related to its ANZSCO Unit Group description. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                 const SizedBox(height: 20),
                 const Text(
                  'Your employment in these nominated occupations should not better match another ANZSCO code (whether assessed by VETASSESS or not). ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                 const SizedBox(height: 20),
                 const Text(
                  'When considering whether to nominate a' 'nec' 'occupation, you should consider the sub-major group description and determine whether your skills best fit this category. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                 const SizedBox(height: 20),
              ],
            ),


             _buildDivider(),
            
            _buildStandardSection(
              context,
              'Which occupation do you recommend for my visa option?',
              [
                const Text(
                  'VETASSESS can only provide information regarding our assessment process. We are unable to tell you which visa is best for you, which state or territory list your occupation appears on, or whether you will meet the visa requirements. For any questions regarding visa requirements and/ or eligibility, you should contact the Department of Home Affairs. ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                ),
                 const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: 'You need to decide which occupation to nominate before submitting an application for assessment with VETASSESS. If you are unsure about which occupation may be best suited to your credentials, you may consider using our Skills Assessment Support (SAS) consultation service. You can read more about the SAS consultation service by clicking',
                      ),
                      
                      TextSpan(
                        text: ' here ',
                        style: const TextStyle(
                          color: Color(0xFF0d5257),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  
                    ],
                  ),
                ),
                
              ],
            ),
            
            _buildDivider(),



            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // Helper method to create consistent dividers
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

  // Helper method to build sections with responsive layout
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required bool isTabletOrLarger,
    required List<Widget> Function(BuildContext) contentBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: isTabletOrLarger
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
                    children: contentBuilder(context),
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
                ...contentBuilder(context),
              ],
            ),
    );
  }

  // Helper method to build standard sections for consistent layout
  Widget _buildStandardSection(BuildContext context, String title, List<Widget> content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Title
          Expanded(
            flex: 3,
            child: Column(
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
              ],
            ),
          ),
          
          // Right column - Content
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
        ],
      ),
    );
  }
Widget _buildSkilledOccupationsListsSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        const Text(
          'Skilled Occupations Lists',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D5C63),
          ),
        ),
        const SizedBox(height: 24),
        
        // Content with image on the right
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text content
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Occupations may be removed from the Skilled Occupation List at any time and without notice by the Australian Government. You are responsible for ensuring that your proposed occupation is eligible at the date you submit your application to VETASSESS. Should your application be affected by the removal of an occupation from any of these lists please be advised that VETASSESS will continue with the assessment for suitability against your selected occupation.',
                    style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF5A5A5A),
                      ),
                      children: [
                        const TextSpan(
                          text: 'For visa-related requirements including caveats that may apply for certain occupations, please visit the ',
                        ),
                        TextSpan(
                          text: 'Department of Home Affairs',
                          style: const TextStyle(
                            color: Color(0xFF0D5C63),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // Link functionality would go here
                          },
                        ),
                        const TextSpan(
                          text: ' website.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Image
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
      ],
    ),
  );
}

Widget _buildSkillednominateanoccupation (BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        const Text(
          'You will need to nominate an occupation when you apply for a Skills Assessment',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D5C63),
          ),
        ),
        const SizedBox(height: 24),
        
        // Content with image on the right
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text content
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Generally, for a Skills Assessment application lodged under either ENS, GSM, RSMS or SID visa categories, applicants are required to hold a qualification that is at the educational level required and which is in a highly relevant field to the nominated occupation. ',
                    style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                  ),
                  const SizedBox(height: 20),
                 const Text(
                    'In addition to the qualification requirements you also have to provide evidence of having at least one year of highly relevant employment performed at the required skill level within the last five years, from the date of lodging your application. ',
                    style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Image
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
          ],
        ),
      ],
    ),
  );
}

Widget _buildSkillednominate(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Content with image on the left
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on the left
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

            // Text content on the right
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'For some Group classifications, you can still apply with a qualification that is not highly relevant to the occupation, but only if you can provide evidence that you have additional years of highly relevant employment, performed at the required skill level.',
                    style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'For applicants who meet the skills assessment criteria, we will then determine the date that you were “deemed”, or considered to be, skilled in your nominated occupation within a ten-year period.  ',
                    style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                  ),
                   const SizedBox(height: 20),
                  const Text(
                    'For applicants who meet the skills assessment criteria, we will then determine the date that you were “deemed”, or considered to be, skilled in your nominated occupation within a ten-year period.  ',
                    style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A)),
                  ),
                ],
              ),
            ),
          ],
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
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF5A5A5A),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method for bullet points with highlighted text
  Widget _buildBulletPoint(String prefix, String highlighted, String suffix, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF5A5A5A),
            fontWeight: FontWeight.bold,
          )
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(text: prefix),
                TextSpan(
                  text: highlighted,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: suffix),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper method for bullet points with multiple highlighted segments
  Widget _buildBulletPointWithMultipleHighlights(List<Map<String, dynamic>> textSegments, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF5A5A5A),
            fontWeight: FontWeight.bold,
          )
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: textSegments.map((segment) {
                return TextSpan(
                  text: segment['text'],
                  style: segment['isHighlighted'] 
                      ? const TextStyle(fontWeight: FontWeight.bold) 
                      : null,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // Content widgets for the first section
  List<Widget> _buildContentWidgets(BuildContext context) {
    return [
      RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(
              text: 'Before nominating an occupation, make sure it is available for migration under the relevant visa type. For information about visa types, visit ',
            ),
            TextSpan(
              text: 'Department of Home Affairs',
              style: const TextStyle(
                color: Color(0xFF0D5C63),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                // Link functionality would go here
              },
            ),
            const TextSpan(
              text: ' website.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      
      const Text(
        'We conduct skills assessment under ANZSCO criteria as set by the Australian Government.',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF5A5A5A),
        ),
      ),
      const SizedBox(height: 20),
      
      _buildBulletPoint(
        'For most occupations, assessments are based on ',
        'ANZSCO 2013',
        ', as referenced in the applicable legislation.',
        context
      ),
      const SizedBox(height: 10),
      
      _buildBulletPointWithMultipleHighlights([
        {'text': 'For the ', 'isHighlighted': false},
        {'text': 'Core Skills stream', 'isHighlighted': true},
        {'text': ' of the ', 'isHighlighted': false},
        {'text': 'Skills in Demand (subclass 482) visa', 'isHighlighted': true},
        {'text': ' and the ', 'isHighlighted': false},
        {'text': 'Direct Entry stream of the Employer Nomination Scheme (subclass 186) visa', 'isHighlighted': true},
        {'text': ', assessments align with ', 'isHighlighted': false},
        {'text': 'ANZSCO 2022', 'isHighlighted': true},
        {'text': '. This later version of ANZSCO benchmarks the Core Skills Occupation List (CSOL), which the Government released in December 2024.', 'isHighlighted': false},
      ], context),
      const SizedBox(height: 20),
      
      const Text(
        'It is important to check the specific requirements of your intended visa and relevant legislation to confirm the correct ANZSCO version applicable for the skills assessment of your nominated occupation.',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF5A5A5A),
        ),
      ),
      const SizedBox(height: 20),
      
      RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(
              text: 'For information about the Australian and New Zealand Standard Classification of Occupations (ANZSCO), please refer to the ',
            ),
            TextSpan(
              text: 'Australian Bureau of Statistics (ABS)',
              style: const TextStyle(
                color: Color(0xFF0D5C63),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                // Link functionality would go here
              },
            ),
            const TextSpan(
              text: ' website. Please note that many occupations listed in ANZSCO may not be available for skilled visa purposes.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      
      RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(
              text: 'We offer an optional service of a customised consultation for professional and other non-trade occupations. Click ',
            ),
            TextSpan(
              text: 'here to find out more about our Skills Assessment Support (SAS) service',
              style: const TextStyle(
                color: Color(0xFF0D5C63),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                // Link functionality would go here
              },
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    ];
  }

  // Content widgets for the occupation section
  List<Widget> _buildmyoccupationWidgets(BuildContext context) {
    return [
      RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(
              text: 'If your occupation is not listed with us, you can try locating the occupation on the ',
            ),
            TextSpan(
              text: 'Department of Home Affairs',
              style: const TextStyle(
                color: Color(0xFF0D5C63),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                // Link functionality would go here
              },
            ),
            const TextSpan(
              text: ' website. Details of the relevant assessing authority will be listed there too.',
            ),
          ],
        ),
      ),
    ];
  }
}