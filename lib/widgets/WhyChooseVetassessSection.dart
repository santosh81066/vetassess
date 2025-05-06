import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // ADD THIS!
import 'package:go_router/go_router.dart'; // if using go_router

class WhyChooseVetassessSection extends StatelessWidget {
  const WhyChooseVetassessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Why choose VETASSESS for your skills assessment",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 32,
            runSpacing: 32,
            children: [
              _IconCard(
                iconAsset: 'assets/images/icon-logo_3.svg',
                title: "25+ YEARS  OF EXPERIENCE",
                description:
                "We are the Australian leader and go-to organisation for assessing qualifications, skills and experience.",
              ),
              _IconCard(
                iconAsset: 'assets/images/icon-logo_3.svg',
                title: "QUALIFIED TRADE ASSESSORS",
                description:
                "Your skills and experience will be assessed by someone who has worked in your trade and understands your skills and qualifications.",
              ),
              _IconCard(
                iconAsset: 'assets/images/icon-logo_3.svg',
                title: "WORK WITH INDUSTRY LEADERS",
                description:
                "We are Australia's largest supplier of skills assessment services, as authorised by the Australian Government.",
              ),
              _IconCard(
                iconAsset: 'assets/images/icon-logo_3.svg',
                title: "INTERNATIONAL  ASSESSMENTS",
                description:
                "We operate assessment centres in India, United Kingdom, China, South Africa and Southeast Asia to assess your practical skills globally, not just in Australia.",
              ),
              _IconCard(
                iconAsset: 'assets/images/icon-logo_3.svg',
                title: "GET HELPFUL CUSTOMER SUPPORT",
                description:
                "Our dedicated customer service and assessment teams help you navigate the skills assessment process, every step of the way.",
              ),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              context.go('/about-us');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFA000),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            child: const Text("About Us"),
          ),
        ],
      ),
    );
  }
}

class _IconCard extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String description;

  const _IconCard({
    required this.iconAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            height: 32,
            width: 32,
          ),
          const SizedBox(height: 12),
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
