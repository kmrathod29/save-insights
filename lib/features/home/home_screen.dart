import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';
import '../auth/profile_screen.dart';
import '../item/item_detail_screen.dart';
import '../../models/insight.dart';

// =========================
// 🔹 Micro-Interaction: Scale-on-tap Wrapper
// =========================
class ScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const ScaleButton({super.key, required this.child, this.onTap});

  @override
  State<ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}

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
    const double horizontalPadding = 24.0;
    const double avatarRadius = 22.0;
    const double logoHeight = 46.0;
    const double spacing = 14.0;

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
                fontFamily: 'NeueMachina',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          ),
          const Spacer(),
          // Profile avatar button
          ScaleButton(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ProfileScreen(),
                  transitionDuration: const Duration(milliseconds: 250),
                  reverseTransitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(opacity: animation, child: child),
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
                    blurRadius: 10,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting with name accent
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: c.textPrimary,
                fontSize: 25,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
                height: 1.2,
              ),
              children: [
                const TextSpan(text: 'Good morning,\n'),
                TextSpan(
                  text: 'Krunal 👋',
                  style: TextStyle(
                    color: c.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Subtitle
          Text(
            'You have 5 new insights waiting',
            style: TextStyle(
              color: c.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.1,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          // Primary stat: Insights (wider + highlighted)
          _buildStatCard('24', 'Insights', c, isPrimary: true, flex: 3),
          const SizedBox(width: 10),
          _buildStatCard('8', 'Folders', c, flex: 2),
          const SizedBox(width: 10),
          _buildStatCard('12', 'Favorites', c, flex: 2),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    AppThemeColors c, {
    bool isPrimary = false,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: ScaleButton(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isPrimary ? 20 : 16,
          ),
          decoration: BoxDecoration(
            // Primary card gets accent-tinted background
            color: isPrimary
                ? c.accent.withValues(alpha: c.isDark ? 0.16 : 0.08)
                : c.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isPrimary
                  ? c.accent.withValues(alpha: 0.25)
                  : c.border,
              width: isPrimary ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isPrimary
                    ? c.accent.withValues(alpha: c.isDark ? 0.12 : 0.08)
                    : c.cardShadow,
                blurRadius: isPrimary ? 14 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: isPrimary
                      ? (c.isDark ? Colors.white : c.accent)
                      : c.textPrimary,
                  fontSize: isPrimary ? 28 : 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary
                      ? (c.isDark
                          ? Colors.white.withValues(alpha: 0.75)
                          : c.accent.withValues(alpha: 0.80))
                      : c.textSecondary,
                  fontSize: 12,
                  fontWeight:
                      isPrimary ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // 🔹 Quick Actions Section
  // =========================
  Widget _buildQuickActionsSection(AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Quick Actions', null, c),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildActionButton('New Idea', Icons.add_circle_outline_rounded, c),
              const SizedBox(width: 12),
              _buildActionButton('Search', Icons.search_rounded, c),
              const SizedBox(width: 12),
              _buildActionButton('Share', Icons.ios_share_rounded, c),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, AppThemeColors c) {
    return Expanded(
      child: ScaleButton(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: c.border),
            boxShadow: [
              BoxShadow(
                color: c.cardShadow,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: c.accent, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: c.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // 🔹 Folders Section
  // =========================
  Widget _buildFoldersSection(AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('My Folders', 'View All', c),
          const SizedBox(height: 14),
          _buildFolderItem('Work', 12, Icons.work_outline_rounded, c),
          const SizedBox(height: 10),
          _buildFolderItem('Personal', 8, Icons.person_outline_rounded, c),
          const SizedBox(height: 10),
          _buildFolderItem('Ideas', 4, Icons.lightbulb_outline_rounded, c),
        ],
      ),
    );
  }

  Widget _buildFolderItem(
      String name, int count, IconData icon, AppThemeColors c) {
    return ScaleButton(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          // Slightly different from plain surface for contrast
          color: c.surfaceSoft,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: c.border),
          boxShadow: [
            BoxShadow(
              color: c.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Folder icon in accent-tinted pill
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: c.accent.withValues(alpha: c.isDark ? 0.12 : 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: c.accent, size: 16),
            ),
            const SizedBox(width: 14),
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
            // Count badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: c.isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFE6E4F2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: c.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // 🔹 Recent Insights Section
  // =========================
  Widget _buildRecentInsightsSection(BuildContext context, AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Recent Insights', 'View All', c),
          const SizedBox(height: 14),
          _buildInsightCard(
              context, 'Flutter Best Practices', 'Ideas', '2h ago', c),
          const SizedBox(height: 10),
          _buildInsightCard(
              context, 'Team Meeting Notes', 'Work', '4h ago', c),
          const SizedBox(height: 10),
          _buildInsightCard(
              context, 'Project Ideas', 'Ideas', 'Yesterday', c),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
    BuildContext context,
    String title,
    String folder,
    String timeAgo,
    AppThemeColors c,
  ) {
    return ScaleButton(
      onTap: () {
        // Navigate to detail with fade transition
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
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: c.border),
          boxShadow: [
            BoxShadow(
              color: c.cardShadow,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: c.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.bookmark_border_rounded,
                    color: c.textSecondary, size: 18),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Folder chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: c.accent.withValues(alpha: c.isDark ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    folder,
                    style: TextStyle(
                      color: c.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: c.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // 🔹 Reusable Section Header
  // =========================
  Widget _buildSectionHeader(
      String title, String? actionLabel, AppThemeColors c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: c.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        if (actionLabel != null)
          Text(
            actionLabel,
            style: TextStyle(
              color: c.accent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
