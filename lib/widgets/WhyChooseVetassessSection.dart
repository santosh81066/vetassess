import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WhyChooseVetassessSection extends StatelessWidget {
  const WhyChooseVetassessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Why choose VETASSESS for your skills assessment",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 40),
          // First row with 3 cards
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 32,
            children: [
              _BenefitCard(
                iconPath: 'assets/images/icon-logo_3.svg',
                title: "25+ YEARS OF EXPERIENCE",
                description:
                "We are the Australian leader and go-to organisation for assessing qualifications, skills and experience.",
              ),
              _BenefitCard(
                iconPath: 'assets/images/icon-logo_3.svg',
                title: "QUALIFIED TRADE ASSESSORS",
                description:
                "Your skills and experience will be assessed by someone who has worked in your trade and understands your skills and qualifications.",
              ),
              _BenefitCard(
                iconPath: 'assets/images/icon-logo_3.svg',
                title: "WORK WITH INDUSTRY LEADERS",
                description:
                "We are Australia's largest supplier of skills assessment services, as authorised by the Australian Government.",
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Second row with 2 cards
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 32,
            children: [
              _BenefitCard(
                iconPath: 'assets/images/icon-logo_3.svg',
                title: "INTERNATIONAL ASSESSMENTS",
                description:
                "We operate assessment centres in India, United Kingdom, China, South Africa and Southeast Asia to assess your practical skills globally, not just in Australia.",
              ),
              _BenefitCard(
                iconPath: 'assets/images/icon-logo_3.svg',
                title: "GET HELPFUL CUSTOMER SUPPORT",
                description:
                "Our dedicated customer service and assessment teams help you navigate the skills assessment process, every step of the way.",
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              context.go('/about-us');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFA000),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // Square button
              ),
            ),
            child: const Text(
              "About Us",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const _BenefitCard({
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Custom icon with green-yellow gradient
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(8),

            child: SvgPicture.asset(
              iconPath,

            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}