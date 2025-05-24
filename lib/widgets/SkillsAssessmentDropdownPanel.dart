import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SkillsAssessmentDropdownPanel extends StatelessWidget {
  const SkillsAssessmentDropdownPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 1200;
    final bool isMediumScreen =
        screenSize.width >= 1200 && screenSize.width < 1600;
    final bool isLargeScreen = screenSize.width >= 1600;

    return Material(
      elevation: 4,
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height:
            isSmallScreen ? screenSize.height * 0.9 : screenSize.height * 0.8,
        padding: EdgeInsets.symmetric(
          horizontal:
              isSmallScreen
                  ? 16
                  : isMediumScreen
                  ? 24
                  : 40,
          vertical: isSmallScreen ? 16 : 32,
        ),
        child:
            isSmallScreen
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context, isMediumScreen),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isMediumScreen) {
    final double spacing = isMediumScreen ? 20 : 40;
    final double blockWidth = isMediumScreen ? 200 : 230;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMediumScreen ? 40 : 80,
          vertical: 32,
        ),
        child: Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CategoryBlock(
              title: "Skilled Assessments\nfor Migration",
              description:
                  "We recognise and assess your skills and experience enabling you to continue skilled employment in Australia.",
              buttonColor: const Color(0xFFFFA000),
              buttonTextColor: Colors.black,
              width: blockWidth,
            ),
            SizedBox(width: spacing),
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
              showButton: true,
              width: blockWidth,
              onLinkTap: (String link) {
                if (link == "Application Process") {
                  context.go('/application_process');
                }
                if (link == "Fees") {
                  context.go('/fee_screen');
                }
                if (link == "Skills Assessment Support") {
                  context.go('/skills_assess_support');
                }
                if (link == "Nominate an Occupation") {
                  context.go('/nominate_screen');
                }
                if (link == "Eligibility Criteria") {
                  context.go('/eligibility_criteria');
                }
                if (link == "Priority Processing") {
                  context.go('/priority_processing');
                }
              },
            ),
            SizedBox(width: spacing),
            _LinkBlock(
              title: "Trades",
              links: ["Application Process", "Fees", "Eligibility Criteria"],
              buttonColor: Colors.transparent,
              buttonBorderColor: const Color(0xFF004D40),
              showButton: true,
              width: blockWidth,
              onLinkTap: (String link) {
                context.go('/maintenance');
              },
            ),
            SizedBox(width: spacing),
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
              showButton: false,
              width: blockWidth,
              onLinkTap: (String link) {
                context.go('/maintenance');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CategoryBlock(
              title: "Skilled Assessments\nfor Migration",
              description:
                  "We recognise and assess your skills and experience enabling you to continue skilled employment in Australia.",
              buttonColor: const Color(0xFFFFA000),
              buttonTextColor: Colors.black,
              width: double.infinity,
            ),
            const SizedBox(height: 32),
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
              showButton: true,
              width: double.infinity,
              onLinkTap: (String link) {
                if (link == "Application Process") {
                  context.go('/application_process');
                }
                if (link == "Fees") {
                  context.go('/fee_screen');
                }
                if (link == "Skills Assessment Support") {
                  context.go('/skills_assess_support');
                }
                if (link == "Nominate an Occupation") {
                  context.go('/nominate_screen');
                }
                if (link == "Eligibility Criteria") {
                  context.go('/eligibility_criteria');
                }
                if (link == "Priority Processing") {
                  context.go('/priority_processing');
                }
              },
            ),
            const SizedBox(height: 32),
            _LinkBlock(
              title: "Trades",
              links: ["Application Process", "Fees", "Eligibility Criteria"],
              buttonColor: Colors.transparent,
              buttonBorderColor: const Color(0xFF004D40),
              showButton: true,
              width: double.infinity,
              onLinkTap: (String link) {
                context.go('/maintenance');
              },
            ),
            const SizedBox(height: 32),
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
              showButton: false,
              width: double.infinity,
              onLinkTap: (String link) {
                context.go('/maintenance');
              },
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
  final Color buttonColor;
  final Color buttonTextColor;
  final double width;

  const _CategoryBlock({
    required this.title,
    required this.description,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(description, style: theme.textTheme.bodyMedium),
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
              context.go('/skill_assess_viewall');
            },
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
  final Color buttonColor;
  final Color buttonBorderColor;
  final bool showButton;
  final double width;
  final Function(String) onLinkTap;

  const _LinkBlock({
    required this.title,
    required this.links,
    required this.buttonColor,
    required this.buttonBorderColor,
    required this.width,
    required this.onLinkTap,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
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
              child: InkWell(
                onTap: () => onLinkTap(link),
                child: Text(link, style: theme.textTheme.titleSmall),
              ),
            ),
          ),
          if (showButton) ...[
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: buttonColor,
                side: BorderSide(color: buttonBorderColor, width: 2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                context.go('/professionals_viewall');
              },
              child: Text(
                "View All",
                style: theme.textTheme.labelLarge?.copyWith(
                  color: const Color(0xFF004D40),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
