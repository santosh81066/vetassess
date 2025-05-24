import 'package:flutter/material.dart';
import 'header.dart';
import 'footer.dart';

class BasePageLayout extends StatelessWidget {
  final Widget child;

  const BasePageLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [const Header(), child, const Footer()]),
    );
  }
}
