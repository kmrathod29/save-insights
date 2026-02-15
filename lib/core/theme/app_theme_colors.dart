import 'package:flutter/material.dart';

/// Centralized adaptive color tokens for both dark and light modes.
/// Usage: `final c = AppThemeColors.of(context);`
class AppThemeColors {
  final bool isDark;

  const AppThemeColors._({required this.isDark});

  factory AppThemeColors.of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return AppThemeColors._(isDark: brightness == Brightness.dark);
  }

  // ── Accent ──
  Color get accent => const Color(0xFF6C63FF);

  // ── Gradient background ──
  List<Color> get backgroundGradient => isDark
      ? const [Color(0xFF151326), Color(0xFF1C1930), Color(0xFF272240)]
      : const [Color(0xFFF6F5FC), Color(0xFFF0EEFA), Color(0xFFEDEBFA)];

  // ── Surfaces ──
  Color get surface => isDark ? const Color(0xFF1E1B36) : const Color(0xFFFFFFFF);
  Color get surfaceSoft => isDark ? const Color(0xFF2A2750) : const Color(0xFFF0EEFA);

  // ── Text ──
  Color get textPrimary => isDark ? Colors.white : const Color(0xFF1A1825);
  Color get textSecondary => isDark ? const Color(0xFF9FA3C8) : const Color(0xFF6F6C8F);

  // ── Borders ──
  Color get border => isDark
      ? Colors.white.withValues(alpha: 0.06)
      : const Color(0xFFE6E4F2);
  Color get borderSubtle => isDark
      ? Colors.white.withValues(alpha: 0.05)
      : const Color(0xFFE6E4F2).withValues(alpha: 0.7);

  // ── Bottom nav ──
  Color get navBarBackground => isDark
      ? const Color(0xFF1E1B36).withValues(alpha: 0.92)
      : Colors.white.withValues(alpha: 0.95);
  Color get navBarBorder => isDark
      ? Colors.white.withValues(alpha: 0.12)
      : const Color(0xFFE6E4F2);
  Color get navInactive => isDark ? const Color(0xFF9FA3C8) : const Color(0xFF9896AE);

  // ── FAB ──
  Color get fabPrimary => isDark ? accent : const Color(0xFF272240);
  Color get fabSecondary => isDark ? const Color(0xFF5A4FE8) : const Color(0xFF1A1825);
  double get fabGlowAlpha => isDark ? 0.40 : 0.15;

  // ── Folder pill ──
  Color get folderActiveBg => isDark ? accent : const Color(0xFF272240);
  Color get folderInactiveBg => isDark ? const Color(0xFF2A2750) : const Color(0xFFF0EEFA);
  Color get folderInactiveText => isDark ? Colors.white70 : const Color(0xFF6F6C8F);
  Color get folderInactiveBorder => isDark
      ? Colors.white.withValues(alpha: 0.1)
      : const Color(0xFFE6E4F2);

  // ── Logo tint ──
  Color get logoTint => isDark ? Colors.white70 : const Color(0xFF272240).withValues(alpha: 0.75);

  // ── Avatar ──
  Color get avatarBorder => isDark
      ? Colors.white.withValues(alpha: 0.09)
      : const Color(0xFFE6E4F2);
  Color get avatarBg => surface;
  Color get avatarIcon => textSecondary;

  // ── Shadow ──
  Color get cardShadow => isDark
      ? Colors.black.withValues(alpha: 0.25)
      : Colors.black.withValues(alpha: 0.06);

  // ── Ambient glow ──
  double get glowAlpha1 => isDark ? 0.10 : 0.05;
  double get glowAlpha2 => isDark ? 0.04 : 0.02;

  // ── System overlay ──
  Color get systemNavBarColor => isDark
      ? const Color(0xFF1C1930)
      : const Color(0xFFEDEBFA);
  Brightness get statusBarIconBrightness => isDark ? Brightness.light : Brightness.dark;
  Brightness get navBarIconBrightness => isDark ? Brightness.light : Brightness.dark;
}
