import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const Color _cardBg = Color(0xFF1E1B36);
  static const Color _softGrey = Color(0xFF9FA3C8);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 24),
                _buildSettingsTile(Icons.person, 'Account'),
                _buildSettingsTile(Icons.notifications, 'Notifications'),
                _buildSettingsTile(Icons.palette, 'Appearance'),
                _buildSettingsTile(Icons.cloud, 'Backup & Sync'),
                _buildSettingsTile(Icons.lock, 'Privacy'),
                _buildSettingsTile(Icons.info, 'About'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: _softGrey, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: _softGrey, size: 20),
        ],
      ),
    );
  }
}
