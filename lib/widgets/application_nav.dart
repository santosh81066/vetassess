import 'package:flutter/material.dart';

class ApplicationNav extends StatelessWidget {
  const ApplicationNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: const Text(
              'Personal details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          // Menu Items
          _buildMenuItem('Occupation'),
          _buildMenuItem('General education'),
          _buildMenuItem('Tertiary education'),
          _buildMenuItem('Documents upload'),
          _buildMenuItem('Review and confirm'),
          _buildMenuItem('Payment', isLast: true),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, {bool isLast = false}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom:
              isLast
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.brown[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
