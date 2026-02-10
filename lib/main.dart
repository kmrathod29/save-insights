import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const SaveInsightApp());
}

class SaveInsightApp extends StatelessWidget {
  const SaveInsightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App Configuration
      title: 'SaveInsight',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F7F9), // Soft Off-White
        primaryColor: const Color(0xFF1E1F3B), // Midnight Indigo
        useMaterial3: true,
      ),

      // Initial Route
      home: const SplashScreen(),
    );
  }
}