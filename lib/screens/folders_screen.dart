import 'package:flutter/material.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  static const Color _cardBg = Color(0xFF1E1B36);
  static const Color _softGrey = Color(0xFF9FA3C8);
  static const Color _accentColor = Color(0xFF6C63FF);

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
                  'Folders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 24),
                _buildFolderTile('Work', Icons.work, 12),
                const SizedBox(height: 12),
                _buildFolderTile('Personal', Icons.person, 8),
                const SizedBox(height: 12),
                _buildFolderTile('Ideas', Icons.lightbulb, 15),
                const SizedBox(height: 12),
                _buildFolderTile('Research', Icons.science, 5),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFolderTile(String name, IconData icon, int count) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _accentColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$count items',
            style: const TextStyle(color: _softGrey, fontSize: 13),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: _softGrey, size: 20),
        ],
      ),
    );
  }
}
