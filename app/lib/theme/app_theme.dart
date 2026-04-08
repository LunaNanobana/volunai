import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryOrange = Color(0xFFE8622A);
  static const Color primaryTeal = Color(0xFF26A69A);
  static const Color darkTeal = Color(0xFF1B5E52);
  static const Color lightTeal = Color(0xFF4ECDC4);
  static const Color background = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color textGrey = Color(0xFF7F8C8D);
  static const Color divider = Color(0xFFECECEC);
  static const Color gold = Color(0xFFFFD700);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color bronze = Color(0xFFCD7F32);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryOrange,
        secondary: AppColors.primaryTeal,
        surface: AppColors.background,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGrey)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.textGrey)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryOrange)),
        hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14),
      ),
      scaffoldBackgroundColor: AppColors.background,
    );
  }
}
