import 'package:flutter/material.dart';
import 'featured_card_widget.dart';

class FeaturedSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Map<String, String>> cards;

  const FeaturedSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      child: Column(
        children: [
          Text(title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.blue[800],
                fontWeight: FontWeight.bold,
              )),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(subtitle!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
            ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: cards.map((card) {
              return SizedBox(
                width: 300,
                child: FeaturedCardWidget(
                  imageUrl: card['image']!,
                  title: card['title']!,
                  description: card['description']!,
                  linkText: card['linkText'] ?? 'Read more',
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

