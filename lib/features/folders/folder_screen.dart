import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    // =========================
    // 🔹 Folders List
    // =========================
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: ClampingScrollPhysics(),
      ),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // 🔹 Title
                // =========================
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
                
                // =========================
                // 🔹 Folder Items
                // =========================
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

  // =========================
  // 🔹 Folder Tile Helper
  // =========================
  Widget _buildFolderTile(String name, IconData icon, int count, AppThemeColors c) {
    const double padding = 20.0; // Card padding
    const double iconContainerSize = 10.0;
    const double iconSize = 22.0;
    const double borderRadius = 20.0;
    const double shadowBlur = 8.0;

    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: c.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: c.cardShadow,
            blurRadius: shadowBlur,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container with accent background
          Container(
            padding: const EdgeInsets.all(iconContainerSize),
            decoration: BoxDecoration(
              color: c.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: c.accent, size: iconSize),
          ),
          const SizedBox(width: 16),
          // Folder name
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
          // Item count
          Text(
            '$count items',
            style: TextStyle(color: c.textSecondary, fontSize: 13),
          ),
          const SizedBox(width: 8),
          // Chevron indicator
          Icon(Icons.chevron_right, color: c.textSecondary, size: 20),
        ],
      ),
    );
  }
}
