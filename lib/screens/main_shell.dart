import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'folders_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import 'add_insight_screen.dart';

/// Main shell that owns the gradient background, bottom navigation,
/// ambient glow, and FAB. Tab pages live inside an IndexedStack so
/// state is preserved across tab switches without rebuilds.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const Color _accentColor = Color(0xFF6C63FF);
  static const Color _cardBg = Color(0xFF1E1B36);
  static const Color _softGrey = Color(0xFF9FA3C8);

  static const _pages = <Widget>[
    HomeScreen(),
    SearchScreen(),
    FoldersScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Shared gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF151326),
                  Color(0xFF1C1930),
                  Color(0xFF272240),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Tab pages
          SafeArea(
            bottom: false,
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),

          // Ambient glow at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 140,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomCenter,
                    radius: 1.2,
                    colors: [
                      _accentColor.withValues(alpha: 0.10),
                      _accentColor.withValues(alpha: 0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Bottom floating nav bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: _buildFloatingNavBar(),
            ),
          ),

          // FAB — only visible on Home tab
          if (_selectedIndex == 0)
            Positioned(
              bottom: 95,
              right: 15,
              child: SafeArea(
                top: false,
                child: _buildFloatingActionButton(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AddInsightScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            reverseTransitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
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
              color: _accentColor.withValues(alpha: 0.40),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.20),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    const navItems = [
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
              color: _cardBg.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, -2),
                ),
                BoxShadow(
                  color: _accentColor.withValues(alpha: 0.06),
                  blurRadius: 30,
                  spreadRadius: 0,
                ),
              ],
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
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
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
