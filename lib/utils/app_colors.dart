import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6C63FF);
  static const primaryLight = Color(0xFF9C89FF);
  static const primaryDark = Color(0xFF4A3FCC);

  static const secondary = Color(0xFF00C9A7);
  static const secondaryLight = Color(0xFF92FE9D);
  static const secondaryDark = Color(0xFF009688);

  static const background = Color(0xFFF5F6FA);
  static const backgroundLight = Color(0xFFFFFFFF);
  static const backgroundDark = Color(0xFFEDE7F6);

  static const surface = Color(0xFFFFFFFF);
  static const card = Color(0xFFFFFFFF);

  static const textPrimary = Color(0xFF1E1E1E);
  static const textSecondary = Color(0xFF6B6B6B);
  static const textLight = Color(0xFFFFFFFF);

  static const border = Color(0xFFE0E0E0);
  static const divider = Color(0xFFEEEEEE);

  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFFF5252);
  static const warning = Color(0xFFFFC107);
  static const info = Color(0xFF2196F3);

  static const shadowLight = Color(0x1A000000);
  static const shadowMedium = Color(0x33000000);
  static const shadowDark = Color(0x55000000);

  static const gradientPrimary = LinearGradient(
    colors: [
      Color(0xFF6C63FF),
      Color(0xFF9C89FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientSecondary = LinearGradient(
    colors: [
      Color(0xFF00C9A7),
      Color(0xFF92FE9D),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBlue = LinearGradient(
    colors: [
      Color(0xFF2196F3),
      Color(0xFF6EC6FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientPink = LinearGradient(
    colors: [
      Color(0xFFFF6A88),
      Color(0xFFFF99AC),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBackground = LinearGradient(
    colors: [
      Color(0xFFF5F6FA),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}