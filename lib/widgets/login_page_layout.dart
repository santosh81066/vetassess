import 'package:flutter/material.dart';
import 'login_footer.dart';
import 'login_header.dart';

class LoginPageLayout extends StatelessWidget {
  final Widget child;

  const LoginPageLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [LoginHeader(), child, const LoginFooter()]),
    );
  }
}
