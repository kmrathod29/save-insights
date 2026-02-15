import 'package:flutter/material.dart';
import '../core/theme/theme_provider.dart';
import '../core/theme/app_theme_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    color: c.textPrimary,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 24),
                _buildSettingsTile(Icons.person, 'Account', c),
                _buildSettingsTile(Icons.notifications, 'Notifications', c),
                const SizedBox(height: 4),
                // ── Appearance section ──
                _AppearanceSection(colors: c),
                const SizedBox(height: 4),
                _buildSettingsTile(Icons.cloud, 'Backup & Sync', c),
                _buildSettingsTile(Icons.lock, 'Privacy', c),
                _buildSettingsTile(Icons.info, 'About', c),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, AppThemeColors c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderSubtle),
      ),
      child: Row(
        children: [
          Icon(icon, color: c.textSecondary, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: c.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: c.textSecondary, size: 20),
        ],
      ),
    );
  }
}

/// The Appearance tile that expands to show System / Light / Dark options.
class _AppearanceSection extends StatelessWidget {
  final AppThemeColors colors;
  const _AppearanceSection({required this.colors});

  @override
  Widget build(BuildContext context) {
    final provider = ThemeScope.of(context);
    final c = colors;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.borderSubtle),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
            child: Row(
              children: [
                Icon(Icons.palette, color: c.textSecondary, size: 22),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Appearance',
                    style: TextStyle(
                      color: c.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  _modeLabel(provider.themeMode),
                  style: TextStyle(
                    color: c.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Segmented selector
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: c.surfaceSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _buildOption(context, 'System', Icons.brightness_auto,
                      ThemeMode.system, provider, c),
                  const SizedBox(width: 4),
                  _buildOption(context, 'Light', Icons.light_mode,
                      ThemeMode.light, provider, c),
                  const SizedBox(width: 4),
                  _buildOption(context, 'Dark', Icons.dark_mode,
                      ThemeMode.dark, provider, c),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    String label,
    IconData icon,
    ThemeMode mode,
    ThemeProvider provider,
    AppThemeColors c,
  ) {
    final isActive = provider.themeMode == mode;

    return Expanded(
      child: GestureDetector(
        onTap: () => provider.setThemeMode(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? c.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive ? Colors.white : c.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : c.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _modeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}
