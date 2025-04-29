import 'package:flutter/material.dart';

class FeaturedCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String linkText;

  const FeaturedCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.linkText = "Read more",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                Text(
                  linkText,
                  style: TextStyle(color: Colors.orange[600], fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
