import 'dart:ui';
import 'package:flutter/material.dart';
import 'core/theme/app_theme_colors.dart';
import 'features/home/home_screen.dart';
import 'features/search/search_screen.dart';
import 'features/folders/folder_screen.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/capture/add_item_screen.dart';

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
          // =========================
          // 🔹 Shared Gradient Background
          // =========================
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: c.backgroundGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // =========================
          // 🔹 Tab Pages with State Preservation
          // =========================
          SafeArea(
            bottom: false,
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),

          // =========================
          // 🔹 Ambient Glow at Bottom
          // =========================
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 140, // Glow height
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

          // =========================
          // 🔹 Bottom Floating Navigation Bar
          // =========================
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: _buildFloatingNavBar(c),
            ),
          ),

          // =========================
          // 🔹 Floating Action Button (Home Tab Only)
          // =========================
          if (_selectedIndex == 0)
            Positioned(
              bottom: 105, // Position above nav bar
              right: 15, // Right margin
              child: SafeArea(
                top: false,
                child: _buildFloatingActionButton(c),
              ),
            ),
        ],
      ),
    );
  }

  // =========================
  // 🔹 Floating Action Button
  // =========================
  Widget _buildFloatingActionButton(AppThemeColors c) {
    const double fabSize = 50; // FAB width and height
    const double iconSize = 32; // Plus icon size
    const double fabGlowBlur = 10; // First shadow blur
    const double fabGlowSpread = 0; // First shadow spread
    const double fabGlowSecondaryBlur = 20; // Secondary shadow blur
    const double fabGlowSecondarySpread = 2; // Secondary shadow spread
    const double fabRadialBorderRadius = 32; // FAB border radius

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
        width: fabSize,
        height: fabSize,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [c.fabPrimary, c.fabSecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(fabRadialBorderRadius),
          boxShadow: [
            BoxShadow(
              color: c.fabPrimary.withValues(alpha: c.fabGlowAlpha),
              blurRadius: fabGlowBlur,
              spreadRadius: fabGlowSpread,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: c.fabPrimary.withValues(alpha: c.fabGlowAlpha * 0.5),
              blurRadius: fabGlowSecondaryBlur,
              spreadRadius: fabGlowSecondarySpread,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: iconSize),
      ),
    );
  }

  // =========================
  // 🔹 Bottom Navigation Bar
  // =========================
  Widget _buildFloatingNavBar(AppThemeColors c) {
    const navItems = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.search, 'label': 'Search'},
      {'icon': Icons.folder, 'label': 'Folders'},
      {'icon': Icons.favorite, 'label': 'Favorites'},
      {'icon': Icons.settings, 'label': 'Settings'},
    ];

    const double navPaddingHorizontal = 30; // Horizontal padding
    const double navPaddingVertical = 20; // Vertical padding
    const double navBorderRadius = 30; // Nav bar border radius
    const double navBlurSigma = 25; // Gaussian blur amount
    const double navBorderWidth = 1.5; // Border width
    const double navShadowBlur = 20; // Shadow blur radius
    const double navShadowSpread = 2; // Shadow spread radius

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: navPaddingHorizontal, vertical: navPaddingVertical),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(navBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: navBlurSigma, sigmaY: navBlurSigma),
          child: Container(
            decoration: BoxDecoration(
              color: c.navBarBackground,
              borderRadius: BorderRadius.circular(navBorderRadius),
              border: Border.all(
                color: c.navBarBorder,
                width: navBorderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: c.cardShadow,
                  blurRadius: navShadowBlur,
                  spreadRadius: navShadowSpread,
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

  // =========================
  // 🔹 Navigation Item Helper
  // =========================
  Widget _buildNavItem(
      IconData icon, String label, int index, AppThemeColors c) {
    const double navItemVerticalPadding = 12; // Vertical padding
    const double navItemHorizontalPadding = 8; // Horizontal padding
    const double navItemIconSize = 24; // Icon size
    const double navItemSpacing = 6; // Space between icon and label
    const double navItemLabelFontSize = 10; // Label font size

    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: navItemVerticalPadding, horizontal: navItemHorizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: navItemIconSize,
                color: isActive ? c.accent : c.navInactive),
            const SizedBox(height: navItemSpacing),
            Text(
              label,
              style: TextStyle(
                color: isActive ? c.accent : c.navInactive,
                fontSize: navItemLabelFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
