import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '*',
          builder: (context, state) => const NotFoundScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'VETASSESS - Skills Assessment Australia',
      routerConfig: router,
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
      ),
    );
  }
}
