import 'package:flutter/material.dart';

class SkillsAssessmentNonMigrationDropdownPanel extends StatelessWidget {
  const SkillsAssessmentNonMigrationDropdownPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width.clamp(300, 1200),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Section
            SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Skills Assessment for Non Migration",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Already in Australia? Here’s how to get your skills and experience assessed with VETASSESS",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA000),
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("View All"),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 60),

            // Right Section
            Expanded(
              child: Wrap(
                spacing: 60,
                runSpacing: 12,
                children: [
                  _linkColumn("Popular Pages", [
                    "Australian Technical Competencies Statement Assessment",
                    "Post Gap Assessment",
                    "Complementary Health Therapies Assessment",
                  ]),
                  _linkColumn("", [
                    "Psychotherapy and Counselling Qualifications Assessment",
                    "Financial Adviser Licensing Qualifications Comparison to the AQF",
                    "Marketing Credentials",
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _linkColumn(String heading, List<String> links) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading.isNotEmpty) ...[
            Text(
              heading,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF004D40),
              ),
            ),
            const SizedBox(height: 12),
          ],
          ...links.map(
                (text) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.teal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
