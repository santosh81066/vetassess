import 'package:flutter/material.dart';
import 'package:vetassess/screens/admin_screens/admin_footer.dart';
import 'package:vetassess/screens/admin_screens/admin_header.dart';


class AdminLayout extends StatelessWidget {
  final Widget child;

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [AdminHeader(), child, const AdminFooter()]),
    );
  }
}
