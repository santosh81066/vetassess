import 'package:flutter/material.dart';

class SkillsAssessmentDropdownPanel extends StatelessWidget {
  const SkillsAssessmentDropdownPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryBlock(
              title: "Skilled Assessments for Migration",
              description:
              "We recognise and assess your skills and experience enabling you to continue skilled employment in Australia.",
              showButton: true,
            ),
            const SizedBox(width: 40),
            _LinkBlock(title: "Professionals", links: [
              "Application Process",
              "Nominate an Occupation",
              "Fees",
              "Eligibility Criteria",
              "Skills Assessment Support",
              "Priority Processing",
            ]),
            const SizedBox(width: 40),
            _LinkBlock(title: "Trades", links: [
              "Application Process",
              "Fees",
              "Eligibility Criteria",
            ]),
            const SizedBox(width: 40),
            _LinkBlock(title: "Other", links: [
              "Designated Area Migration Agreements (DAMA)",
              "Chinese Qualifications Verification",
              "Post-Vocational Education Work (Subclass 485) Visa",
              "Industry Labour Agreement",
              "Forms and Templates",
            ]),
          ],
        ),
      ),
    );
  }
}


class _CategoryBlock extends StatelessWidget {
  final String title;
  final String description;
  final bool showButton;

  const _CategoryBlock({
    required this.title,
    required this.description,
    this.showButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
              )),
          const SizedBox(height: 8),
          Text(description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              )),
          const SizedBox(height: 16),
          if (showButton)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA000),
              ),
              onPressed: () {},
              child: const Text("View All"),
            ),
        ],
      ),
    );
  }
}

class _LinkBlock extends StatelessWidget {
  final String title;
  final List<String> links;

  const _LinkBlock({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 12),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              link,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.teal,
                decoration: TextDecoration.underline,
              ),
            ),
          )),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            child: const Text("View All"),
          )
        ],
      ),
    );
  }
}
