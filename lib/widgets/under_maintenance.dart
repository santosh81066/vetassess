import 'package:flutter/material.dart';
import 'package:vetassess/widgets/BasePageLayout.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePageLayout(
      child: Container(
        color: const Color(0xFFF5F5F5),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Maintenance Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.build_rounded,
                size: 80,
                color: Color(0xFF004D40),
              ),
            ),

            const SizedBox(height: 40),

            // Main Title
            const Text(
              'Under Maintenance',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40),
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Subtitle
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: const Text(
                'We\'re currently performing scheduled maintenance to improve your experience. Please check back shortly.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 40),

            // Loading indicator
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF004D40)),
              ),
            ),

            const SizedBox(height: 30),

            // Footer text
            const Text(
              'Thank you for your patience',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF888888),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
