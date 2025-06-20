import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

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
          GestureDetector(
            onTap: () => context.go('/personal_form'),
            child: Container(
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
          ),

          // Menu Items
          _buildMenuItem('Occupation',onTap: () => context.go('/occupation_form'),),
          _buildMenuItem('General education',onTap: () => context.go('/education_form'),),
          _buildMenuItem('Tertiary education',onTap: () => context.go('/tertiary_education_form'),),
          _buildMenuItem('Documents upload',onTap: () => context.go('/doc_upload'),),
          _buildMenuItem('Review and confirm',onTap: () => context.go('/get_all_forms'),),
          _buildMenuItem('Payment',onTap: () => context.go('/cashfree_pay'), isLast: true),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, {bool isLast = false,required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
