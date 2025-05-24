import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(height: 2, color: Colors.teal[700]),
        Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left:
                screenWidth * 0.1, // Approx 170 on 393px width (common mobile)
          ),
          width: screenWidth,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Privacy',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                ' | ',
                style: TextStyle(color: Colors.black87, fontSize: 14.0),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Disclaimer',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Text(
                ' | ',
                style: TextStyle(color: Colors.black87, fontSize: 14.0),
              ),
              Text(
                'Copyright © 2025 VETASSESS. All rights reserved.',
                style: TextStyle(color: Colors.black87, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
