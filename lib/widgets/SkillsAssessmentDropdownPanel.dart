import 'package:flutter/material.dart';

class SkillsAssessmentDropdownPanel extends StatelessWidget {
  const SkillsAssessmentDropdownPanel({super.key});

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
            _CategoryBlock(
              title: "Skilled Assessments for Migration",
              description:
              "We recognise and assess your skills and experience enabling you to continue skilled employment in Australia.",
              showButton: true,
            ),
            const SizedBox(width: 40),
            _LinkBlock(
              title: "Professionals",
              links: [
                "Application Process",
                "Nominate an Occupation",
                "Fees",
                "Eligibility Criteria",
                "Skills Assessment Support",
                "Priority Processing",
              ],
            ),
            const SizedBox(width: 40),
            _LinkBlock(
              title: "Trades",
              links: [
                "Application Process",
                "Fees",
                "Eligibility Criteria",
              ],
            ),
            const SizedBox(width: 40),
            _LinkBlock(
              title: "Other",
              links: [
                "Designated Area Migration Agreements (DAMA)",
                "Chinese Qualifications Verification",
                "Post-Vocational Education Work (Subclass 485) Visa",
                "Industry Labour Agreement",
                "Forms and Templates",
              ],
            ),
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
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF004D40),
              )),
          const SizedBox(height: 8),
          Text(description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              )),
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
      width: 240,
      child: Column(
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
          ...links.map(
                (link) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                link,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.teal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Color(0xFF004D40),
                width: 2,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "View All",
              style: TextStyle(
                color: Color(0xFF004D40),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
