import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vetassess/screens/application_process.dart';
import 'package:vetassess/screens/eligibility_criteria.dart';
import 'package:vetassess/screens/fee_screen.dart';
import 'package:vetassess/screens/skills_assessment_support.dart';
import 'package:vetassess/widgets/under_maintenance.dart';

class EverythingYouNeedToKnow extends StatelessWidget {
  const EverythingYouNeedToKnow({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Everything you need to know:',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              ),
            ),
            const SizedBox(height: 24),
            TabBar(
                labelColor: const Color(0xFF004D40),
                unselectedLabelColor: Colors.black54,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xFFFFA000), width: 3),
                  insets: EdgeInsets.symmetric(horizontal: 1), // Adjust this value to change length
                ),
                labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'For professional skilled migration'),
                  Tab(text: 'For trades skilled migration'),
                ],
              ),

            const SizedBox(height: 24),
            SizedBox(
              height: 600, // give it enough height for content
              child: TabBarView(
               children: [
                  _TabContent(
                    title: 'For professional skilled migration',
                    description:
                        'Browse the resources below to help you understand the professional skills migration assessment journey. They have essential information about the process, what fees you may need to pay and frequently asked questions.',
                    linkData: [
                      {
                        'text': 'Fees',
                        'onTap': () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => FeeScreen(),));
                        }
                      },
                      {
                        'text': 'Check my eligibility',
                        'onTap': () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => EligibilityCriteria(),));
                        }
                      },
                      {
                        'text': 'Understand the Assessment Process',
                        'onTap': () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                        }
                      },
                      {
                        'text': 'Renew my assessment',
                        'onTap': () {
                         Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                        }
                      },
                      {
                        'text': 'Required Documents',
                        'onTap': () {
                         Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                        }
                      },
                      {
                        'text': 'Skills Assessment Support Service',
                        'onTap': () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                        }
                      },
                    ],
                    buttonText: 'View all information about Professional Occupations',
                    buttonOnTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                    },
                    imageAsset: 'assets/images/EverythingYouNeedToKnow.png',
                  ),
                  _TabContent(
                    title: 'For trades skilled migration',
                    description:
                        'Browse resources below to understand the trades skills migration assessment process. This includes assessment fees, eligibility criteria, required documents and FAQs.',
                    linkData: [
                      {
                        'text': 'Fees',
                        'onTap': () {
                         Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                        }
                      },
                      {
                        'text': 'Assessment Locations',
                        'onTap': () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                        }
                      },
                      {
                        'text': 'Required Documents',
                        'onTap': () {
                         Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage()),);
                        }
                      },
                      {
                        'text': 'Understand the Assessment Process',
                        'onTap': () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                        }
                      },
                    ],
                    buttonText: 'View all information about Trade Occupations',
                    buttonOnTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:(context) => MaintenancePage(),));
                    },
                    imageAsset: 'assets/images/EverythingYouNeedToKnow2.png',
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

class _TabContent extends StatelessWidget {
  final String title;
  final String description;
  final List<Map<String, dynamic>> linkData;
  final String buttonText;
  final String imageAsset;
  final VoidCallback buttonOnTap;

  const _TabContent({
    required this.title,
    required this.description,
   required this.linkData,
    required this.buttonText,
    required this.imageAsset,
     required this.buttonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth > 800;

      return SingleChildScrollView(
        child: Column(
          children: [
            isWide
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: constraints.maxWidth * 0.65,
                  child: _LeftContent(
                    title: title,
                    description: description,
                    linkData: linkData,
                    
                    buttonText: buttonText,
                    buttonOnTap: buttonOnTap,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: constraints.maxWidth * 0.3,
                  child: Image.asset(imageAsset),
                ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LeftContent(
                   title: title,
                    description: description,
                    linkData: linkData,
                    buttonText: buttonText,
                    buttonOnTap: buttonOnTap,
                  ),
                const SizedBox(height: 20),
                Image.asset(imageAsset),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _LeftContent extends StatelessWidget {
  final String title;
  final String description;
 final List<Map<String, dynamic>> linkData;
  final String buttonText;
  final VoidCallback buttonOnTap;

  const _LeftContent({
    required this.title,
    required this.description,
    required this.linkData,
    required this.buttonText,
    required this.buttonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF004D40),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        GridView.count(
           crossAxisCount: 2,
            mainAxisSpacing: 6, // Reduced vertical spacing
            crossAxisSpacing: 12,
            childAspectRatio: 6, // Increased ratio to make each item shorter vertically
            shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          
              children: linkData.map((linkItem) {
            final linkText = linkItem['text'] as String;
            final linkOnTap = linkItem['onTap'] as VoidCallback;
            
            return InkWell(
              onTap: linkOnTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          linkText,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF004D40),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        height: 2.5,
                        width: linkText.length * 8.5,
                        color: const Color(0xFF004D40),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Color(0xFF004D40),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFA000),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          onPressed: () {},
          child: Text(buttonText),
        ),
      ],
    );
  }
}
