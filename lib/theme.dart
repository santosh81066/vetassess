import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFFFF); // Blue
  static const Color secondary = Color(0xFFFFD100); // Yellow
  static const Color background = Color(0xFFFFFF); // White background
  static const Color textPrimary = Color(0xFF000000); // Black text
  static const Color textSecondary = Color(0xFF666666); // Grey text
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textSecondary,
        ),
      ),
      useMaterial3: true, // For better Material Design 3 styling
    );
  }
}
