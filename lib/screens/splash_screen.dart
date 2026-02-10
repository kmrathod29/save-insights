import 'package:flutter/material.dart';
import 'home_screen.dart';

/// Splash Screen for SaveInsight app
/// Displays branding and loads initial app resources
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  /// Navigate to home screen after 3 seconds
  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9), // Soft Off-White
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Brain Logo
            Image.asset(
              'assets/logo.png',
              width: 120,
              height: 120,
            ),

            const SizedBox(height: 32),

            // App Name
            const Text(
              'SAVE INSIGHT',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Neue Machina',
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Color(0xFF1E1F3B), // Midnight Indigo
              ),
            ),

            const SizedBox(height: 8),

            // Subtitle
            const Text(
              'Personal Knowledge',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: Color(0xFF6B7280), // Slate Grey
              ),
            ),

            const SizedBox(height: 48),

            // Loading Indicator
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF6D6AF0), // Muted Violet
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

