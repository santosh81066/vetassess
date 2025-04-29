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
            "Match your skills and experience to an\nAustralian occupation.",
            style: TextStyle(
              fontSize: 32,
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
              fontSize: 16,
              color: Colors.black54,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 40),

          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 800;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: cards.map((card) {
                  return SizedBox(
                    width: isMobile
                        ? double.infinity
                        : (constraints.maxWidth - 48) / 3,
                    child: _HoverCard(
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

class _HoverCard extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String link;

  const _HoverCard({
    required this.image,
    required this.title,
    required this.description,
    required this.link,
  });

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: isHovering
            ? Matrix4.translationValues(0, -8, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: isHovering
              ? [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.image,
                height: 300,
                width: 500,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  widget.link,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF004D40),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: isHovering
                      ? Matrix4.translationValues(4, 0, 0)
                      : Matrix4.identity(),
                  child: const Icon(Icons.arrow_right_alt, size: 20, color: Color(0xFF004D40)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
