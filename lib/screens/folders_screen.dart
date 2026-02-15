import 'package:flutter/material.dart';
import '../core/theme/app_theme_colors.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

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
                  'Folders',
                  style: TextStyle(
                    color: c.textPrimary,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 24),
                _buildFolderTile('Work', Icons.work, 12, c),
                const SizedBox(height: 12),
                _buildFolderTile('Personal', Icons.person, 8, c),
                const SizedBox(height: 12),
                _buildFolderTile('Ideas', Icons.lightbulb, 15, c),
                const SizedBox(height: 12),
                _buildFolderTile('Research', Icons.science, 5, c),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFolderTile(String name, IconData icon, int count, AppThemeColors c) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.borderSubtle),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: c.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: c.accent, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: c.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$count items',
            style: TextStyle(color: c.textSecondary, fontSize: 13),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: c.textSecondary, size: 20),
        ],
      ),
    );
  }
}
