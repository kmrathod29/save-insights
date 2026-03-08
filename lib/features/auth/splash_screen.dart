import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// =========================
// 🔹 Splash State: Fade-In + Scale Animation
// =========================
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller: 1.1s total fade-in
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    // Fade from 0 → 1 (starts after a short delay offset)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeOut),
      ),
    );

    // Subtle scale 0.92 → 1.0 for the logo
    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    // Start animation after a brief initial pause
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _controller.forward();
    });

    // Navigate to home after 3.5 seconds
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🔹 1. Full-Screen Gradient Background
          _buildBackground(c),

          // 🔹 2. Radial Glow (subtle accent glow centered behind logo)
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, _) => _buildRadialGlow(c),
          ),

          // 🔹 3. Centered Branding Content (logo, title, tagline)
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: child,
                );
              },
              child: _buildBrandingContent(c),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // 🔹 Background Gradient
  // =========================
  Widget _buildBackground(AppThemeColors c) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: c.backgroundGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  // =========================
  // 🔹 Radial Glow Behind Logo
  // =========================
  Widget _buildRadialGlow(AppThemeColors c) {
    return Center(
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              c.accent.withValues(alpha: c.isDark ? 0.18 : 0.10),
              c.accent.withValues(alpha: c.isDark ? 0.06 : 0.03),
              Colors.transparent,
            ],
            stops: const [0.0, 0.55, 1.0],
          ),
        ),
      ),
    );
  }

  // =========================
  // 🔹 Branding: Logo + Title + Tagline
  // =========================
  Widget _buildBrandingContent(AppThemeColors c) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo with subtle scale animation
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
          child: Image.asset(
            'assets/logo.png',
            height: 100, // Slightly larger for stronger brand presence
            color: c.logoTint,
          ),
        ),

        const SizedBox(height: 28),

        // App Title
        Text(
          'SaveInsight',
          style: TextStyle(
            color: c.textPrimary,
            fontSize: 34,
            fontFamily: 'NeueMachina',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
            height: 1.1,
          ),
        ),

        const SizedBox(height: 10),

        // Tagline — lighter, subtle opacity
        Text(
          'Your Second Brain',
          style: TextStyle(
            color: c.textSecondary.withValues(
              alpha: c.isDark ? 0.75 : 0.85,
            ),
            fontSize: 15,
            fontFamily: 'PlayfairDisplay',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
