import 'package:flutter/material.dart';

class SkillsMatchSection extends StatelessWidget {
  const SkillsMatchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> cards = [
      {
        "image": "assets/images/trades_assessment.png",
        "title": "Am I eligible for a trades \nskilled migration \nassessment?",
        "description":
            "Check your visa subclass, occupation and other requirements before you begin.",
        "link": "Find out if you are eligible",
        "buttonIcon": Icons.arrow_forward,
      },
      {
        "image": "assets/images/professional_general.png",
        "title": "Am I eligible for a \nprofessional & general \noccupation?",
        "description":
            "Find out if your occupation is a professional or general occupation with VETASSESS.",
        "link": "Find out more",
        "buttonIcon": Icons.arrow_forward,
      },
      {
        "image": "assets/images/application_status.jpg",
        "title": "Can I view the status of my \napplication?",
        "description":
            "Check the progress of your application via our online portal.",
        "link": "View your application status",
        "buttonIcon": Icons.arrow_forward,
      },
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          const Text(
            "Match your skills and experience to an\nAustralian occupation.",
            style: TextStyle(
              fontSize: 36,
              color: Color(0xFF00695C),
              fontWeight: FontWeight.w800,
              height: 1.2,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Are you looking to move to Australia – either temporarily or permanently – and continue to work in\nyour trade, profession or specialised occupation? VETASSESS can recognise and validate the skills,\nqualifications and experience you gained in your home country to give you the opportunity to\ncontinue your skilled career in Australia.",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF54555A),
              fontWeight: FontWeight.w400,
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 800;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children:
                    cards.map((card) {
                      double cardWidth =
                          isMobile
                              ? constraints.maxWidth
                              : (constraints.maxWidth - 48) / 3;

                      return Container(
                        width: cardWidth,
                        height: 500, // Fixed height for consistency
                        margin: const EdgeInsets.only(bottom: 16),
                        child: _CardItem(
                          image: card["image"],
                          title: card["title"],
                          description: card["description"],
                          link: card["link"],
                          buttonIcon: card["buttonIcon"],
                        ),
                      );
                    }).toList(),
              );
            },
          ),
          SizedBox(height: 50),
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
  final IconData buttonIcon;

  const _CardItem({
    required this.image,
    required this.title,
    required this.description,
    required this.link,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with green line
          Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // Fixed height for the image
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  color: const Color(0xFF008996), // Green line below the image
                ),
              ),
            ],
          ),
          // Content section with flexible layout
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF54555A),
                      height: 1.4,
                      letterSpacing: 0.1,
                    ),
                  ),
                  // Push the gesture detector to the bottom
                  const Spacer(),
                  // Link with arrow
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              link,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF00695C),
                              ),
                            ),
                            Container(
                              height: 2,
                              width:
                                  link.length *
                                  7.3, // Width based on text length
                              color: const Color(0xFF00695C),
                              margin: const EdgeInsets.only(top: 1),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF00695C),
                          ),
                          child: Icon(
                            buttonIcon,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
