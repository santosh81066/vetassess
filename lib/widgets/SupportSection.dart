import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768;

    return Container(
      color: const Color(0xFF00565A), // Darker teal color as shown in screenshot
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1244),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "I need help, what support is available?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36, // Larger font size to match screenshot
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40), // Adjusted spacing
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: const _SupportCard(
                        title: "Help with a Skills Assessment",
                        description:
                        "Skills Assessment Support (SAS) services are for migration agents, legal practitioners and prospective applicants who are yet to submit their Skills Assessment application to VETASSESS.",
                        linkText: "Skills Assessment Support",
                        linkUrl: "/skills-assessment-for-migration/skills-assessment-support",
                      ),
                    ),
                  ),
                  const SizedBox(width: 16, height: 24),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: const _SupportCard(
                        title: "Help with an urgent application",
                        description:
                        "For general and professional occupations, priority processing can be used to fast-track urgent applications.",
                        linkText: "Fast-track applications",
                        linkUrl: "/skills-assessment-for-migration/professional-occupations/priority-processing",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  final String title;
  final String description;
  final String linkText;
  final String linkUrl;

  const _SupportCard({
    required this.title,
    required this.description,
    required this.linkText,
    required this.linkUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00565A),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            // Link with underline and circle arrow
            GestureDetector(
              onTap: () {
                context.go(linkUrl);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        linkText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00565A),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 24,
                        width: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00565A),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 2,
                    width: 210, // Match the width to the text + margin
                    margin: const EdgeInsets.only(top: 8),
                    color: const Color(0xFF00565A),
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