import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFFFF); // Blue
  static const Color secondary = Color(0xFFFFD100); // Yellow
  static const Color background = Color(0xFFFFFF); // White background
  static const Color textPrimary = Color(0xFF000000); // Black text
  static const Color textSecondary = Color(0xFF666666); // Grey text
  static const Color color1 = Color(0xFF00838F);
  static const Color color2 = Color(0xFF06b0AA);
  static const Color color3 = Color(0xFF0d5257);
  static const Color color4 = Color(0xFF161616);
  static const Color color5 = Color(0xFF54555A);
  static const Color color6 = Color(0xFFCCCCCC);
  static const Color color7 = Color(0xFFEEEEEE);
  static const Color color8 = Color(0xFFEFA200);
  static const Color color9 = Color(0xFFF0F0F0);
  static const Color color10 = Color(0xFFF2F2F2);
  static const Color color11 = Color(0xFFF5F5F5);
  static const Color color12 = Color(0xFFFBFBFB);
  static const Color color13 = Color(0xFFFFFFFF);
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
