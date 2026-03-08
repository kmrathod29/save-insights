import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';
import '../auth/profile_screen.dart';
import '../item/item_detail_screen.dart';
import '../../models/insight.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    // =========================
    // 🔹 Main Scrollable Content
    // =========================
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverToBoxAdapter(child: _buildTopBar(context, c)),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildGreetingSection(c)),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildStatsSection(c)),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildQuickActionsSection(c)),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildFoldersSection(c)),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildRecentInsightsSection(context, c)),
        const SliverToBoxAdapter(child: SizedBox(height: 140)),
      ],
    );
  }

  // =========================
  // 🔹 Top Bar with Logo & Avatar
  // =========================
  Widget _buildTopBar(BuildContext context, AppThemeColors c) {
    const double horizontalPadding = 24.0; // Main side padding
    const double avatarRadius = 22.0; // Avatar size
    const double logoHeight = 46.0; // Logo size
    const double spacing = 14.0; // Space between logo and title

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          // Logo image
          Image.asset('assets/logo.png', height: logoHeight, color: c.logoTint),
          const SizedBox(width: spacing),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              'SaveInsight',
              style: TextStyle(
                color: c.textPrimary,
                fontFamily: 'neuemachina',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          ),
          const Spacer(),
          // Profile avatar button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ProfileScreen(),
                  transitionDuration: const Duration(milliseconds: 250),
                  reverseTransitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: c.avatarBorder, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: c.cardShadow,
                    blurRadius: 10, // Shadow blur intensity
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: c.avatarBg,
                child: Icon(Icons.person, color: c.avatarIcon, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // 🔹 Greeting Section
  // =========================
  Widget _buildGreetingSection(AppThemeColors c) {
    const double horPadding = 24.0; // Horizontal padding
    const double titleSpacing = 8.0; // Space between title and subtitle

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning, Krunal',
            style: TextStyle(
              color: c.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: titleSpacing),
          Text(
            'You have 5 new insights waiting',
            style: TextStyle(
              color: c.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // 🔹 Stats Section
  // =========================
  Widget _buildStatsSection(AppThemeColors c) {
    const double horPadding = 24.0;
    const double statSpacing = 12.0; // Space between stat cards

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horPadding),
      child: Row(
        children: [
          _buildStatCard('24', 'Insights', c),
          const SizedBox(width: statSpacing),
          _buildStatCard('8', 'Folders', c),
          const SizedBox(width: statSpacing),
          _buildStatCard('12', 'Favorites', c),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, AppThemeColors c) {
    const double padding = 16.0;
    const double borderRadius = 16.0;
    const double valueFontSize = 22.0;
    const double labelFontSize = 12.0;
    const double shadowBlur = 8.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: padding),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: c.border),
          boxShadow: [
            BoxShadow(
              color: c.cardShadow,
              blurRadius: shadowBlur,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: c.textPrimary,
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: c.textSecondary,
                fontSize: labelFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // 🔹 Quick Actions Section
  // =========================
  Widget _buildQuickActionsSection(AppThemeColors c) {
    const double horPadding = 24.0;
    const double actionSpacing = 12.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              color: c.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildActionButton('New', Icons.add, c),
              const SizedBox(width: actionSpacing),
              _buildActionButton('Search', Icons.search, c),
              const SizedBox(width: actionSpacing),
              _buildActionButton('Share', Icons.share, c),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, AppThemeColors c) {
    const double padding = 12.0;
    const double iconSize = 20.0;
    const double fontSize = 11.0;
    const double borderRadius = 12.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: padding),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: c.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: c.accent, size: iconSize),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: c.textSecondary,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // 🔹 Folders Section
  // =========================
  Widget _buildFoldersSection(AppThemeColors c) {
    const double horPadding = 24.0;
    const double folderSpacing = 8.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Folders',
            style: TextStyle(
              color: c.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildFolderItem('Work', 12, c),
          const SizedBox(height: folderSpacing),
          _buildFolderItem('Personal', 8, c),
          const SizedBox(height: folderSpacing),
          _buildFolderItem('Ideas', 4, c),
        ],
      ),
    );
  }

  Widget _buildFolderItem(String name, int count, AppThemeColors c) {
    const double padding = 14.0;
    const double borderRadius = 12.0;
    const double iconSize = 18.0;
    const double iconSpacing = 12.0;

    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          Icon(Icons.folder, color: c.accent, size: iconSize),
          const SizedBox(width: iconSpacing),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: c.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '$count items',
            style: TextStyle(
              color: c.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // 🔹 Recent Insights Section
  // =========================
  Widget _buildRecentInsightsSection(BuildContext context, AppThemeColors c) {
    const double horPadding = 24.0;
    const double cardSpacing = 8.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Insights',
            style: TextStyle(
              color: c.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildInsightCard(
            context,
            'Flutter Best Practices',
            'Ideas',
            c,
          ),
          const SizedBox(height: cardSpacing),
          _buildInsightCard(
            context,
            'Team Meeting Notes',
            'Work',
            c,
          ),
          const SizedBox(height: cardSpacing),
          _buildInsightCard(
            context,
            'Project Ideas',
            'Ideas',
            c,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
    BuildContext context,
    String title,
    String folder,
    AppThemeColors c,
  ) {
    const double padding = 14.0;
    const double borderRadius = 12.0;
    const double shadowBlur = 4.0;
    const double titleFontSize = 14.0;
    const double folderFontSize = 12.0;

    return GestureDetector(
      onTap: () {
        // Navigate to detail screen with fade transition
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => DetailScreen(
              insight: Insight(
                id: 1,
                title: title,
                body: 'Detail view for $title',
              ),
            ),
            transitionDuration: const Duration(milliseconds: 250),
            reverseTransitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: c.border),
          boxShadow: [
            BoxShadow(
              color: c.cardShadow,
              blurRadius: shadowBlur,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: c.textPrimary,
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  folder,
                  style: TextStyle(
                    color: c.accent,
                    fontSize: folderFontSize,
                  ),
                ),
                Icon(Icons.favorite_border, color: c.textSecondary, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
