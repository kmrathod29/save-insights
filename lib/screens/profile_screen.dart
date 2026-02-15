import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _accentColor = Color(0xFF6C63FF);
  static const Color _cardBg = Color(0xFF1E1B36);
  static const Color _softGrey = Color(0xFF9FA3C8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dark gradient background
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

          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                // Back button + title
                SliverToBoxAdapter(child: _buildHeader(context)),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // Avatar
                const SliverToBoxAdapter(child: _ProfileAvatar()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Name & email
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Text(
                        'Krunal Rathod',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'krunal@saveinsight.app',
                        style: TextStyle(
                          color: _softGrey,
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
                        ),
                        const SizedBox(height: 12),
                        _buildProfileTile(
                          Icons.shield_outlined,
                          'Privacy',
                          'Manage your data and permissions',
                        ),
                        const SizedBox(height: 12),
                        _buildProfileTile(
                          Icons.cloud_upload_outlined,
                          'Backup & Sync',
                          'Keep your insights safe',
                        ),
                        const SizedBox(height: 12),
                        _buildProfileTile(
                          Icons.help_outline,
                          'Help & Support',
                          'Get help from our team',
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 24, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 4),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Your account details',
                style: TextStyle(
                  color: _softGrey,
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

  Widget _buildProfileTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _accentColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _softGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: _softGrey, size: 20),
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
  const _ProfileAvatar();

  static const Color _accentColor = Color(0xFF6C63FF);
  static const Color _cardBg = Color(0xFF1E1B36);
  static const Color _softGrey = Color(0xFF9FA3C8);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _accentColor.withValues(alpha: 0.3),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.15),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const CircleAvatar(
          radius: 48,
          backgroundColor: _cardBg,
          child: Icon(Icons.person, color: _softGrey, size: 44),
        ),
      ),
    );
  }
}
