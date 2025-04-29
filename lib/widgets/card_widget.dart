import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? linkText;

  const CardWidget({
    super.key,
    required this.title,
    required this.description,
    this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
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
          if (linkText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                linkText!,
                style: TextStyle(color: Colors.orange[600], fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
