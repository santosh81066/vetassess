import 'package:flutter/material.dart';
import 'package:vetassess/widgets/skills_assessment_page.dart';

class SkillsAssessmentDropdownPanel extends StatelessWidget {
  const SkillsAssessmentDropdownPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      elevation: 4,
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: screenHeight*0.8,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: Container(

          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CategoryBlock(
                title: "Skilled Assessments\nfor Migration",
                description:
                "We recognise and assess your skills and experience enabling you to continue skilled employment in Australia.",
                buttonColor: const Color(0xFFFFA000),
                buttonTextColor: Colors.black,
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
                buttonColor: Colors.transparent,
                buttonBorderColor: const Color(0xFF004D40),
              ),
              const SizedBox(width: 40),
              _LinkBlock(
                title: "Trades",
                links: [
                  "Application Process",
                  "Fees",
                  "Eligibility Criteria",
                ],
                buttonColor: Colors.transparent,
                buttonBorderColor: const Color(0xFF004D40),
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
                buttonColor: Colors.transparent,
                buttonBorderColor: const Color(0xFF004D40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryBlock extends StatelessWidget {
  final String title;
  final String description;
  final Color buttonColor;
  final Color buttonTextColor;

  const _CategoryBlock({
    required this.title,
    required this.description,
    required this.buttonColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: theme.textTheme.bodyMedium,

          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: buttonTextColor,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SkillsAssessmentPage()),
              );
            },
            child: const Text("View All"),
          )
        ],
      ),
    );
  }
}

class _LinkBlock extends StatelessWidget {
  final String title;
  final List<String> links;
  final Color buttonColor;
  final Color buttonBorderColor;

  const _LinkBlock({
    required this.title,
    required this.links,
    required this.buttonColor,
    required this.buttonBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 16),
          ...links.map(
                (link) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                link,
                style: theme.textTheme.titleSmall,
              ),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: buttonColor,
              side: BorderSide(
                color: buttonBorderColor,
                width: 2,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SkillsAssessmentPage()),
              );
            },
            child: Text(
              "View All",
              style: theme.textTheme.labelLarge?.copyWith(
                color: const Color(0xFF004D40),
              ),
            ),

          )
        ],
      ),
    );
  }
}