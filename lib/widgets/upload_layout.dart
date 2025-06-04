import 'package:flutter/material.dart';
import 'package:vetassess/widgets/upload_footer.dart';
import 'package:vetassess/widgets/upload_header.dart';
import 'login_footer.dart';
import 'login_header.dart';

class UploadLayout extends StatelessWidget {
  final Widget child;

  const UploadLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [VetassessHeader(), child, const UploadFooter()]),
    );
  }
}
