import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/BasePageLayout.dart';
import '../widgets/HelpSection.dart';
import 'login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BasePageLayout(
      child: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                'assets/images/internal_banner.svg',
                width: screenHeight * 0.5,
                height: screenHeight * 0.4,
              ),
              Container(
                width: double.infinity,
                height: screenHeight * 0.46,
                decoration: const BoxDecoration(color: Color(0xFF0d5257)),
                padding: EdgeInsets.only(top: 100, left: 160),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log in",
                        style: TextStyle(
                          color: Color(0xFFFFA000),
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        "Ready To Start Your Application Process?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
          Column(
            children: [
              // Breadcrumb Navigation
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 150,
                ),
                //color: Colors.grey[100],
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Home',
                        style: TextStyle(
                          color: Color(0xFF0d5257),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Text(' / ', style: TextStyle(color: Colors.grey)),
                    Text('Login', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),

              // Main Content
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 150.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 50),
                  child: Text(
                    'You can Apply below or log in to review current \napplications',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A5A5A),
                    ),
                  ),
                ),
                _buildSectionHeader('Skills assessment for migration'),
                _buildTableStructure([
                  _buildAssessmentRow(
                    context: context,
                    title:
                        'Skills assessment for \nprofessional and general \noccupations',
                    links: [
                      LinkItem(text: 'Check your occupation', hasArrow: true),
                      LinkItem(text: 'Fees', hasArrow: true),
                      LinkItem(text: 'Supporting documents', hasArrow: true),
                    ],
                    hasReadyButton: true,
                    hasLoginButton: true,
                  ),
                  _buildAssessmentRow(
                    context: context,
                    title: 'Skill assessment for trade \noccupations',
                    links: [
                      LinkItem(text: 'Check your occupation', hasArrow: true),
                      LinkItem(text: 'Fees', hasArrow: true),
                      LinkItem(text: 'Am I eligible', hasArrow: true),
                    ],
                    hasReadyButton: true,
                    hasLoginButton: true,
                  ),
                  _buildAssessmentRow(
                    context: context,
                    title:
                        'Skill assessment support (for \nprofessional and general \noccupations)',
                    links: [LinkItem(text: 'How to apply', hasArrow: true)],
                    hasReadyButton: true,
                    hasLoginButton: true,
                  ),
                  _buildAssessmentRow(
                    context: context,
                    title: 'Chinese Qualifications \nVerification',
                    links: [
                      LinkItem(text: 'Fees', hasArrow: true),
                      LinkItem(text: 'Supporting documents', hasArrow: true),
                    ],
                    hasReadyButton: true,
                    hasLoginButton: true,
                  ),
                  _buildAssessmentRow(
                    context: context,
                    title: 'Australian Technical \nCompetencies Statement',
                    links: [],
                    hasReadyButton: true,
                    hasLoginButton: false,
                  ),
                ]),
                SizedBox(height: screenHeight / 6),
                _buildSectionHeader(
                  'Qualifications and skills recognition (non migration assessment)',
                ),
                _buildTableStructure([
                  _buildAssessmentRow(
                    context: context,
                    title:
                        'Psychotherapy and counselling qualifications assessment',
                    links: [
                      LinkItem(text: 'Fees', hasArrow: true),
                      LinkItem(text: 'Supporting documents', hasArrow: true),
                    ],
                    hasReadyButton: true,
                    hasLoginButton: true,
                  ),
                  _buildAssessmentRow(
                    context: context,
                    title:
                        'Financial Adviser Standards and Ethics Authority qualifications comparison to the AQF',
                    links: [
                      LinkItem(text: 'Fees', hasArrow: true),
                      LinkItem(text: 'Supporting documents', hasArrow: true),
                    ],
                    hasReadyButton: true,
                    hasLoginButton: true,
                  ),
                ]),
                SizedBox(height: screenHeight / 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSectionHeader(String text) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 26, horizontal: 24),
    color: Color(0xFF0A5A5A),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget _buildTableStructure(List<Widget> rows) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Colors.grey.shade300),
        right: BorderSide(color: Colors.grey.shade300),
        bottom: BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Column(children: rows),
  );
}

Widget _buildAssessmentRow({
  required BuildContext context,
  required String title,
  required List<LinkItem> links,
  required bool hasReadyButton,
  required bool hasLoginButton,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade300)),
    ),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left column - Title
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 30,
              ),

              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A5A5A),
                ),
              ),
            ),
          ),

          // Middle column - Links
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey.shade300),
                  right: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: links.map((link) => _buildLink(link)).toList(),
              ),
            ),
          ),

          // Right column - Buttons
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.only(
                top: 70,
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasReadyButton)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },

                      label: Text(
                        "I'm ready to apply",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF5A623),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        minimumSize: Size(190, 66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // No border radius
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(Icons.edit, color: Colors.black),
                    ),
                  SizedBox(width: 12),
                  if (hasLoginButton)
                    OutlinedButton.icon(
                      onPressed: () {},

                      label: Text(
                        'Agent login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF0A5A5A),
                        side: BorderSide(color: Color(0xFF0A5A5A), width: 4),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        minimumSize: Size(190, 66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // No border radius
                        ),
                      ),
                      icon: Icon(Icons.login, color: Color(0xFF0A5A5A)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildLink(LinkItem link) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            link.text,
            style: TextStyle(
              color: Color(0xFF0A5A5A),
              decoration: TextDecoration.underline,

              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          if (link.hasArrow)
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Icon(
                Icons.arrow_forward,
                size: 18,
                color: Color(0xFF0A5A5A),
              ),
            ),
        ],
      ),
    ),
  );
}

// Helper class for link items
class LinkItem {
  final String text;
  final bool hasArrow;

  LinkItem({required this.text, required this.hasArrow});
}
