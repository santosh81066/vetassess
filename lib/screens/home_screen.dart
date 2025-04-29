import 'package:flutter/material.dart';
import '../widgets/SkillsMatchSection.dart';
import '../widgets/call_to_action_section.dart';
import '../widgets/featured_section.dart';
import '../widgets/header.dart';
import '../widgets/hero_slider.dart';

import '../widgets/footer.dart';
import '../widgets/services_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Services section data
    final List<Map<String, String>> servicesCards = [
      {
        "title": "Skills Assessment for Migration",
        "description": "Get your skills assessed for your visa application to Australia.",
        "linkText": "Learn More"
      },
      {
        "title": "Professional Year Program",
        "description": "Enhance your professional skills and employability in Australia.",
        "linkText": "Explore Programs"
      },
      {
        "title": "Trade Occupations",
        "description": "Assessment services for trade occupations under the Migration Skills Assessment program.",
        "linkText": "View Occupations"
      },
      {
        "title": "Points Test Advice",
        "description": "Advice on how many points you would score for your skills for Australia's General Skilled Migration.",
        "linkText": "Get Advice"
      },
      {
        "title": "International Qualifications",
        "description": "Services for the assessment of international qualifications for employment and higher education.",
        "linkText": "Find Out More"
      },
      {
        "title": "Workforce Development",
        "description": "Customized solutions to help organizations develop their workforce capabilities.",
        "linkText": "Explore Solutions"
      },
    ];

    // Featured news data
    final List<Map<String, String>> newsCards = [
      {
        "image": "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
        "title": "New Skills Assessment Guidelines",
        "description": "Updates to the assessment criteria for migration skills assessment for 2023.",
        "linkText": "Read More"
      },
      {
        "image": "https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
        "title": "Professional Year Changes",
        "description": "Important changes to the Professional Year Program starting July 2023.",
        "linkText": "Learn More"
      },
      {
        "image": "https://images.unsplash.com/photo-1576267423048-15c0040fec78?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
        "title": "Webinar: Migration Pathways",
        "description": "Join our upcoming webinar on migration pathways to Australia through skills assessment.",
        "linkText": "Register Now"
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeroSection(),
                  SkillsMatchSection(),
                  ServicesSection(
                    title: "Our Services",
                    subtitle: "Australia's leading provider of skills assessment services",
                    cards: servicesCards,
                  ),
                  CallToActionSection(
                    title: "Ready to start your journey?",
                    description: "Whether you're applying for migration, seeking employment, or developing your workforce, VETASSESS has the expertise to help you succeed.",
                    buttonText: "Apply Now",
                    backgroundImage: "https://images.unsplash.com/photo-1488998427799-e3362cec87c3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
                  ),
                  FeaturedSection(
                    title: "Latest News & Events",
                    subtitle: "Stay updated with the latest news, events, and changes from VETASSESS",
                    cards: newsCards,
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
