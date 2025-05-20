import 'package:flutter/material.dart';
import 'package:vetassess/screens/application_type%20.dart';
import 'package:vetassess/screens/empoyment.dart';
import 'package:vetassess/screens/licence.dart';
import 'package:vetassess/screens/tertiary_education.dart';
import 'package:vetassess/widgets/login_page_layout.dart';

class AppliOptions extends StatelessWidget {
  const AppliOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPageLayout(
      child: Padding(
        padding: const EdgeInsets.all(150.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              _buildOptionCard(
                title: 'Create a New Application',
                icon: Icons.add_box_outlined,
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationTypeSelectionScreen(),
                      ),
                    );
                },
                color: const Color(0xFF006257),
              ),
              const SizedBox(height: 16),
              _buildOptionCard(
                title: 'Continue Incomplete Application',
                icon: Icons.edit_note,
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TertiaryEducationForm(),
                      ),
                    );
                },
                color: const Color(0xFF006257),
              ),
              const SizedBox(height: 16),
              _buildOptionCard(
                title: 'View Submitted Applications',
                icon: Icons.description_outlined,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmploymentForm(),
                      ),
                    );
                },
                color: const Color(0xFF006257),
              ),
              const SizedBox(height: 16),
              _buildOptionCard(
                title: 'Update my details',
                icon: Icons.person_outline,
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LicenceForm(),
                      ),
                    );
                },
                color: const Color(0xFF006257),
              ),
            ],
          ),
      ),
        );
      
  }

  Widget _buildOptionCard({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    List<String> words = title.split(' ');
    String firstPart = words.first;
    String remainingPart = words.skip(1).join(' ');

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 20, color: Colors.white),
                children: [
                  TextSpan(
                    text: '$firstPart ',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: remainingPart,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
