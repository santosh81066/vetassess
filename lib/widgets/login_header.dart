import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with logo and title
        Container(
          height: MediaQuery.of(context).size.height / 6,
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/vetassess_logo.png', height: 60),
              const SizedBox(width: 40),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  'Skills Recognition General Occupations',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.teal[800],
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Teal border line
        Container(height: 2, color: Colors.teal[700]),

        // Navigation bar
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.orange[900]),
                onPressed: () {},
              ),
              for (final item in ['Contact us', 'Useful links', 'FAQs'])
                TextButton(
                  onPressed: () {},
                  child: Text(
                    item,
                    style: TextStyle(color: Colors.orange[900]),
                  ),
                ),
              const SizedBox(width: 175),
            ],
          ),
        ),
      ],
    );
  }
}
