import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      scaffoldBackgroundColor: Colors.transparent,

      colorScheme: const ColorScheme.light(
        primary: Color(0xFF272240),
        secondary: Color(0xFF6C63FF),
        surface: Color(0xFFFFFFFF),
        onPrimary: Colors.white,
        onSurface: Color(0xFF1A1825),
      ),

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: Color(0xFF1A1825),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1825),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Color(0xFF6F6C8F),
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFFFFFFFF),
      ),

      iconTheme: const IconThemeData(
        color: Color(0xFF6F6C8F),
      ),
    );
  }
}