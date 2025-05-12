import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vetassess/screens/application_process.dart';
import 'package:vetassess/screens/login_page.dart';
import 'package:vetassess/screens/not_found_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const VetassessApp());
}

class VetassessApp extends StatelessWidget {
  const VetassessApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '*', builder: (context, state) => const NotFoundScreen()),
        GoRoute(
          path: 'apply',
          builder: (context, state) => const ApplicationProcess(),
        ),
        GoRoute(path: 'login', builder: (context, state) => const LoginPage()),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'VETASSESS - Skills Assessment Australia',
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'Axiforma',
        useMaterial3: true,
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            // Section titles
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xFF004D40),
            height: 1.2,
          ),
          bodyMedium: TextStyle(
            // Paragraphs
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
            height: 1.5,
          ),
          labelLarge: TextStyle(
            // Buttons
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          titleSmall: TextStyle(
            // Links
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.teal,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
