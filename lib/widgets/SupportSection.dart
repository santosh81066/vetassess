import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // If you're using go_router for navigation

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768;

    return Container(
      color: const Color(0xFF0F5D60), // teal background
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "I need help, what support is available?",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _SupportCard(
                  title: "Help with a Skills Assessment",
                  description:
                  "Skills Assessment Support (SAS) services are for migration agents, legal practitioners and prospective applicants who are yet to submit their Skills Assessment application to VETASSESS.",
                  linkText: "Skills Assessment Support",
                  linkUrl: "/skills-assessment-for-migration/skills-assessment-support",
                ),
              ),
              const SizedBox(width: 24, height: 24),
              Expanded(
                child: _SupportCard(
                  title: "Help with an urgent application",
                  description:
                  "For general and professional occupations, priority processing can be used to fast-track urgent applications.",
                  linkText: "Fast-track applications",
                  linkUrl: "/skills-assessment-for-migration/professional-occupations/priority-processing",
                ),
              ),
            ],
          ),
        ],
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
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                context.go(linkUrl); // if using go_router
                // Or Navigator.pushNamed(context, linkUrl);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    linkText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF004D40),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(0xFF004D40),
                    child: Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
