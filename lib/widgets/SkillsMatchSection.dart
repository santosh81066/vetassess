import 'package:flutter/material.dart';

class SkillsMatchSection extends StatelessWidget {
  const SkillsMatchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> cards = [
      {
        "image": "assets/images/trades_assessment.png",
        "title": "Am I eligible for a trades skilled migration assessment?",
        "description": "Check your visa subclass, occupation and other requirements before you begin.",
        "link": "Find out if you are eligible",
      },
      {
        "image": "assets/images/professional_general.png",
        "title": "Am I eligible for a professional & general occupation?",
        "description": "Find out if your occupation is a professional or general occupation with VETASSESS.",
        "link": "Find out more",
      },
      {
        "image": "assets/images/application_status.jpg",
        "title": "Can I view the status of my application?",
        "description": "Check the progress of your application via our online portal.",
        "link": "View your application status",
      },
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Match your skills and experience to an Australian occupation.",
            style: TextStyle(
              fontSize: 28,
              color: Color(0xFF004D40),
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Are you looking to move to Australia – either temporarily or permanently – "
                "and continue to work in your trade, profession or specialised occupation? "
                "VETASSESS can recognise and validate the skills, qualifications and experience "
                "you gained in your home country to give you the opportunity to continue your skilled career in Australia.",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF54555A),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 800;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: cards.map((card) {
                  double cardWidth = isMobile
                      ? constraints.maxWidth
                      : (constraints.maxWidth - 48) / 3;

                  return SizedBox(
                    width: cardWidth,
                    child: _CardItem(
                      image: card["image"]!,
                      title: card["title"]!,
                      description: card["description"]!,
                      link: card["link"]!,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String link;

  const _CardItem({
    required this.image,
    required this.title,
    required this.description,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // only top corners rounded
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: AspectRatio(
              aspectRatio: 500 / 300,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D40),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF54555A),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // text with underline below (like CSS border-bottom)
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              link,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF004D40),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2,
                              color: Color(0xFF004D40),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF004D40),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
