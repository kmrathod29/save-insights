import 'package:flutter/material.dart';
import '../core/theme/app_theme_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: c.backgroundGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                // Back button + title
                SliverToBoxAdapter(child: _buildHeader(context, c)),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // Avatar
                SliverToBoxAdapter(child: _ProfileAvatar(colors: c)),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Name & email
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Text(
                        'Krunal Rathod',
                        style: TextStyle(
                          color: c.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'krunal@saveinsight.app',
                        style: TextStyle(
                          color: c.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // Profile options
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildProfileTile(
                          Icons.person_outline,
                          'Edit Profile',
                          'Update your personal information',
                          c,
                        ),
                        const SizedBox(height: 12),
                        _buildProfileTile(
                          Icons.shield_outlined,
                          'Privacy',
                          'Manage your data and permissions',
                          c,
                        ),
                        const SizedBox(height: 12),
                        _buildProfileTile(
                          Icons.cloud_upload_outlined,
                          'Backup & Sync',
                          'Keep your insights safe',
                          c,
                        ),
                        const SizedBox(height: 12),
                        _buildProfileTile(
                          Icons.help_outline,
                          'Help & Support',
                          'Get help from our team',
                          c,
                        ),
                        const SizedBox(height: 24),
                        _buildLogoutButton(),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppThemeColors c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 24, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: c.textPrimary,
              size: 20,
            ),
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Your account details',
                style: TextStyle(
                  color: c.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile(
      IconData icon, String title, String subtitle, AppThemeColors c) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.border, width: 1),
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
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: c.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: c.accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: c.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: c.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: c.textSecondary, size: 20),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.redAccent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: const Center(
        child: Text(
          'Log Out',
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final AppThemeColors colors;
  const _ProfileAvatar({required this.colors});

  @override
  Widget build(BuildContext context) {
    final c = colors;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: c.accent.withValues(alpha: 0.3),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: c.accent.withValues(alpha: 0.15),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 48,
          backgroundColor: c.avatarBg,
          child: Icon(Icons.person, color: c.avatarIcon, size: 44),
        ),
      ),
    );
  }
}
