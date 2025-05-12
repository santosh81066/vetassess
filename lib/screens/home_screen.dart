import 'package:flutter/material.dart';
import '../widgets/BasePageLayout.dart';
import '../widgets/Everything you need to know.dart';
import '../widgets/HelpSection.dart';
import '../widgets/HowToPreparePage.dart';
import '../widgets/NewsSection.dart';
import '../widgets/SkillsMatchSection.dart';
import '../widgets/SupportSection.dart';
import '../widgets/WhyChooseVetassessSection.dart';
import '../widgets/call_to_action_section.dart';
import '../widgets/featured_section.dart';
import '../widgets/hero_slider.dart';
import '../widgets/services_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const servicesCards = [
    {
      "title": "Skills Assessment for Migration",
      "description":
          "Get your skills assessed for your visa application to Australia.",
      "linkText": "Learn More",
    },
    {
      "title": "Professional Year Program",
      "description":
          "Enhance your professional skills and employability in Australia.",
      "linkText": "Explore Programs",
    },
    {
      "title": "Trade Occupations",
      "description":
          "Assessment services for trade occupations under the Migration Skills Assessment program.",
      "linkText": "View Occupations",
    },
    {
      "title": "Points Test Advice",
      "description":
          "Advice on how many points you would score for your skills for Australia's General Skilled Migration.",
      "linkText": "Get Advice",
    },
    {
      "title": "International Qualifications",
      "description":
          "Services for the assessment of international qualifications for employment and higher education.",
      "linkText": "Find Out More",
    },
    {
      "title": "Workforce Development",
      "description":
          "Customized solutions to help organizations develop their workforce capabilities.",
      "linkText": "Explore Solutions",
    },
  ];

  static const newsCards = [
    {
      "image":
          "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?auto=format&fit=crop&w=1950&q=80",
      "title": "New Skills Assessment Guidelines",
      "description":
          "Updates to the assessment criteria for migration skills assessment for 2023.",
      "linkText": "Read More",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1557804506-669a67965ba0?auto=format&fit=crop&w=1950&q=80",
      "title": "Professional Year Changes",
      "description":
          "Important changes to the Professional Year Program starting July 2023.",
      "linkText": "Learn More",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1576267423048-15c0040fec78?auto=format&fit=crop&w=1950&q=80",
      "title": "Webinar: Migration Pathways",
      "description":
          "Join our upcoming webinar on migration pathways to Australia through skills assessment.",
      "linkText": "Register Now",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BasePageLayout(
      child: Column(
        children: [
          const HeroSection(),
          SkillsMatchSection(),
          HowToPreparePage(),
          EverythingYouNeedToKnow(),
          SupportSection(),
          WhyChooseVetassessSection(),

          NewsUpdatesSection(),
        ],
      ),
    );
  }
}
