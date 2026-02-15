import 'package:flutter/material.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color _accentColor = Color(0xFF6C63FF);
  static const Color _cardBg = Color(0xFF1E1B36);
  static const Color _pillBg = Color(0xFF2A2750);
  static const Color _softGrey = Color(0xFF9FA3C8);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverToBoxAdapter(child: _buildTopBar()),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildGreetingSection()),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildStatsSection()),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildQuickActionsSection()),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildFoldersSection()),
        const SliverToBoxAdapter(child: SizedBox(height: 28)),
        SliverToBoxAdapter(child: _buildRecentInsightsSection()),
        const SliverToBoxAdapter(child: SizedBox(height: 140)),
      ],
    );
  }

  Widget _buildTopBar() {
    return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Image.asset('assets/logo.png', height: 46, color: Colors.white70),
          const SizedBox(width: 14),
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              'SaveInsight',
              style: TextStyle(
                color: Colors.white,
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
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.09),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: _cardBg,
                child: Icon(Icons.person, color: _softGrey, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
    });
  }

  // D) Improved typography hierarchy
  Widget _buildGreetingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good Evening, Krunal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Capture ideas before they disappear.',
            style: TextStyle(
              color: _softGrey.withValues(alpha: 0.75),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildStatCard('48', 'Texts'),
          const SizedBox(width: 12),
          _buildStatCard('23', 'Images'),
          const SizedBox(width: 12),
          _buildStatCard('12', 'Videos'),
        ],
      ),
    );
  }

  // C) Micro tap scale on stat cards
  Widget _buildStatCard(String count, String label) {
    return Expanded(
      child: _TapScaleCard(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                count,
                style: const TextStyle(
                  color: _accentColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: _softGrey,
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

  Widget _buildQuickActionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildActionCard(Icons.text_fields, 'Add Text'),
              const SizedBox(width: 12),
              _buildActionCard(Icons.image_search, 'Scan OCR'),
              const SizedBox(width: 12),
              _buildActionCard(Icons.link, 'Add Link'),
            ],
          ),
        ],
      ),
    );
  }

  // C) Micro tap scale on action cards
  Widget _buildActionCard(IconData icon, String label) {
    return Expanded(
      child: _TapScaleCard(
        child: Container(
          height: 130,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: _accentColor),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
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

  Widget _buildFoldersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Folders',
            style: TextStyle(
              color: Colors.white,
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
              _buildFolderPill('Work', true),
              const SizedBox(width: 12),
              _buildFolderPill('Personal', false),
              const SizedBox(width: 12),
              _buildFolderPill('Ideas', false),
              const SizedBox(width: 12),
              _buildFolderPill('+ Add', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFolderPill(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? _accentColor : _pillBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive ? _accentColor : Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRecentInsightsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Insights',
            style: TextStyle(
              color: Colors.white,
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
          ),
          const SizedBox(height: 12),
          _buildInsightCard(
            'UI Design Trends',
            'Modern minimalism in design...',
            'Yesterday',
          ),
          const SizedBox(height: 12),
          _buildInsightCard(
            'Mobile Development',
            'Cross-platform strategies...',
            '2 days ago',
          ),
        ],
      ),
    );
  }

  // C) Micro tap scale on insight cards
  Widget _buildInsightCard(String title, String preview, String date) {
    return _TapScaleCard(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              preview,
              style: const TextStyle(
                color: _softGrey,
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
                  style: const TextStyle(
                    color: _softGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Icon(Icons.note, size: 16, color: _accentColor),
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
