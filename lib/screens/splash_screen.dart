import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_theme_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    return Scaffold(
      body: Stack(
        children: [
          _buildGradientBackground(c),
          SafeArea(
            child: Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 800),
                child: _buildGlassContainer(c),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground(AppThemeColors c) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: c.backgroundGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildGlassContainer(AppThemeColors c) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: 320,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 36),
          decoration: BoxDecoration(
            color: c.isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: c.isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : const Color(0xFFE6E4F2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: c.cardShadow,
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 90,
                color: c.logoTint,
              ),
              const SizedBox(height: 24),
              Text(
                'SaveInsight',
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: 30,
                  fontFamily: 'neuemachina',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your Second Brain',
                style: TextStyle(
                  color: c.textSecondary,
                  fontSize: 15,
                  fontFamily: 'playfairdisplay',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
