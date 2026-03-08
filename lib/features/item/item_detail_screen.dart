import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';
import '../../models/insight.dart';

/// Detail Screen for SaveInsight app
/// Displays full content of a selected insight with theme-aware styling
class DetailScreen extends StatelessWidget {
  final Insight insight;

  const DetailScreen({
    super.key,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    return Scaffold(
      backgroundColor: c.surface, // Use surface color instead of hardcoded

      // =========================
      // 🔹 App Bar with Title
      // =========================
      appBar: AppBar(
        title: const Text(
          'Insight',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: c.accent, // Use accent for app bar
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      // =========================
      // 🔹 Detail Content
      // =========================
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        padding: const EdgeInsets.all(24), // Horizontal & vertical padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // 🔹 Insight Title
            // =========================
            Text(
              insight.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: c.textPrimary,
                height: 1.3, // Line height for readability
              ),
            ),

            const SizedBox(height: 24), // Spacing between title and body

            // =========================
            // 🔹 Insight Body Content
            // =========================
            Text(
              insight.body,
              style: TextStyle(
                fontSize: 16,
                color: c.textSecondary,
                height: 1.6, // Line height for readability
                letterSpacing: 0.2, // Subtle letter spacing for elegance
              ),
            ),
          ],
        ),
      ),
    );
  }
}
