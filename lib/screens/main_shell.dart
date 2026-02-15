import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_theme_colors.dart';
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
    final c = AppThemeColors.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Shared gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: c.backgroundGradient,
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
                      c.accent.withValues(alpha: c.glowAlpha1),
                      c.accent.withValues(alpha: c.glowAlpha2),
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
              child: _buildFloatingNavBar(c),
            ),
          ),

          // FAB — only visible on Home tab
          if (_selectedIndex == 0)
            Positioned(
              bottom: 105,
              right: 15,
              child: SafeArea(
                top: false,
                child: _buildFloatingActionButton(c),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(AppThemeColors c) {
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
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [c.fabPrimary, c.fabSecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: c.fabPrimary.withValues(alpha: c.fabGlowAlpha),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: c.fabPrimary.withValues(alpha: c.fabGlowAlpha * 0.5),
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

  Widget _buildFloatingNavBar(AppThemeColors c) {
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
              color: c.navBarBackground,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: c.navBarBorder,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: c.cardShadow,
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, -2),
                ),
                BoxShadow(
                  color: c.accent.withValues(alpha: c.isDark ? 0.06 : 0.03),
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
                    c,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, int index, AppThemeColors c) {
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 24, color: isActive ? c.accent : c.navInactive),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? c.accent : c.navInactive,
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
