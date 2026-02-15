import 'dart:ui';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavIndex = 0;

  static const Color _accentColor = Color(0xFF6C63FF);
  static const Color _brandBase = Color(0xFF272240);
  static const Color _cardBg = Color(0xFF1E1B36);
  static const Color _pillBg = Color(0xFF2A2750);
  static const Color _softGrey = Color(0xFF9FA3C8);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          _buildGradientBackground(),
          SafeArea(
            bottom: false,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: topPadding * 0.3, bottom: 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      _buildTopBar(),
                      const SizedBox(height: 28),
                      _buildGreetingSection(),
                      const SizedBox(height: 28),
                      _buildStatsSection(),
                      const SizedBox(height: 28),
                      _buildQuickActionsSection(),
                      const SizedBox(height: 28),
                      _buildFoldersSection(),
                      const SizedBox(height: 28),
                      _buildRecentInsightsSection(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                // Bottom navigation FIRST (below FAB in stack)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildFloatingNavBar(),
                ),
                // FAB AFTER nav bar so it renders ABOVE it
                Positioned(
                  bottom: 95,
                  right: 15,
                  child: _buildFloatingActionButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF151326), Color(0xFF1C1930), Color(0xFF272240)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Image.asset('assets/logo.png', height: 46, color: Colors.white70),
          const SizedBox(width: 14),
          const Text(
            'SaveInsight',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'sfprodisplay',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 20,
            backgroundColor: _cardBg,
            child: const Icon(Icons.person, color: _softGrey, size: 20),
          ),
        ],
      ),
    );
  }

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
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Capture ideas before they disappear.',
            style: TextStyle(
              color: _softGrey,
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

  Widget _buildStatCard(String count, String label) {
    return Expanded(
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
              fontSize: 18,
              fontWeight: FontWeight.w600,
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

  Widget _buildActionCard(IconData icon, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),

            // boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withValues(alpha: 0.3),
            //   blurRadius: 8,
            //   offset: const Offset(0, 4),
            // ),
            // ],
          ),
          child: Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: const Text(
            'Folders',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
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
              fontSize: 18,
              fontWeight: FontWeight.w600,
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

  Widget _buildInsightCard(String title, String preview, String date) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: const Color.fromARGB(255, 62, 62, 62).withValues(alpha: 0.2),
        //     blurRadius: 12,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
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
    );
  }

  Widget _buildFloatingActionButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_accentColor, Color(0xFF5A4FE8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.55),
              blurRadius: 25,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.25),
              blurRadius: 30,
              spreadRadius: 4,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    final navItems = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.search, 'label': 'Search'},
      {'icon': Icons.folder, 'label': 'Folders'},
      {'icon': Icons.favorite, 'label': 'Favorites'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            decoration: BoxDecoration(
              color: _cardBg.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < navItems.length; i++)
                  _buildNavItem(
                    navItems[i]['icon'] as IconData,
                    navItems[i]['label'] as String,
                    i,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: isActive ? _accentColor : _softGrey),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? _accentColor : _softGrey,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
