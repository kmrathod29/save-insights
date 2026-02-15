import 'package:flutter/material.dart';
import '../core/theme/app_theme_colors.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
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
        SliverToBoxAdapter(child: _buildRecentInsightsSection(c)),
        const SliverToBoxAdapter(child: SizedBox(height: 140)),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context, AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Image.asset('assets/logo.png', height: 46, color: c.logoTint),
          const SizedBox(width: 14),
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
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: c.avatarBg,
                child: Icon(Icons.person, color: c.avatarIcon, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingSection(AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Evening, Krunal',
            style: TextStyle(
              color: c.textPrimary,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Capture ideas before they disappear.',
            style: TextStyle(
              color: c.textSecondary.withValues(alpha: 0.75),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildStatCard('48', 'Texts', c),
          const SizedBox(width: 12),
          _buildStatCard('23', 'Images', c),
          const SizedBox(width: 12),
          _buildStatCard('12', 'Videos', c),
        ],
      ),
    );
  }

  Widget _buildStatCard(String count, String label, AppThemeColors c) {
    return Expanded(
      child: _TapScaleCard(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: c.borderSubtle, width: 1),
            boxShadow: [
              BoxShadow(
                color: c.cardShadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                count,
                style: TextStyle(
                  color: c.accent,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: c.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection(AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              color: c.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildActionCard(Icons.text_fields, 'Add Text', c),
              const SizedBox(width: 12),
              _buildActionCard(Icons.image_search, 'Scan OCR', c),
              const SizedBox(width: 12),
              _buildActionCard(Icons.link, 'Add Link', c),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String label, AppThemeColors c) {
    return Expanded(
      child: _TapScaleCard(
        child: Container(
          height: 130,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: c.borderSubtle, width: 1),
            boxShadow: [
              BoxShadow(
                color: c.cardShadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: c.accent),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoldersSection(AppThemeColors c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Folders',
            style: TextStyle(
              color: c.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              _buildFolderPill('Work', true, c),
              const SizedBox(width: 12),
              _buildFolderPill('Personal', false, c),
              const SizedBox(width: 12),
              _buildFolderPill('Ideas', false, c),
              const SizedBox(width: 12),
              _buildFolderPill('+ Add', false, c),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFolderPill(String label, bool isActive, AppThemeColors c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? c.folderActiveBg : c.folderInactiveBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive ? c.folderActiveBg : c.folderInactiveBorder,
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : c.folderInactiveText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRecentInsightsSection(AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Insights',
            style: TextStyle(
              color: c.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildInsightCard(
            'Flutter Best Practices',
            'Building scalable applications...',
            'Today',
            c,
          ),
          const SizedBox(height: 12),
          _buildInsightCard(
            'UI Design Trends',
            'Modern minimalism in design...',
            'Yesterday',
            c,
          ),
          const SizedBox(height: 12),
          _buildInsightCard(
            'Mobile Development',
            'Cross-platform strategies...',
            '2 days ago',
            c,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
      String title, String preview, String date, AppThemeColors c) {
    return _TapScaleCard(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: c.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: c.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              preview,
              style: TextStyle(
                color: c.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    color: c.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.note, size: 16, color: c.accent),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

/// Reusable micro tap-scale widget for cards.
/// Scales to 0.96 on press, back to 1.0 on release with 120ms easeOut.
class _TapScaleCard extends StatefulWidget {
  final Widget child;
  const _TapScaleCard({required this.child});

  @override
  State<_TapScaleCard> createState() => _TapScaleCardState();
}

class _TapScaleCardState extends State<_TapScaleCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
