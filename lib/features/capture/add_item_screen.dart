import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

/// Add/Capture Insight Screen
/// Form for creating new insights with title, content, folder, and attachments
class AddInsightScreen extends StatefulWidget {
  const AddInsightScreen({super.key});

  @override
  State<AddInsightScreen> createState() => _AddInsightScreenState();
}

class _AddInsightScreenState extends State<AddInsightScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedFolder = 'Work';

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = AppThemeColors.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // =========================
          // 🔹 Gradient Background
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

          SafeArea(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              slivers: [
                // =========================
                // 🔹 Header
                // =========================
                SliverToBoxAdapter(child: _buildHeader(c)),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),

                // =========================
                // 🔹 Title Field
                // =========================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            color: c.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _titleController,
                          hint: 'Give your insight a title...',
                          maxLines: 1,
                          c: c,
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // =========================
                // 🔹 Content Field
                // =========================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Content',
                          style: TextStyle(
                            color: c.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _contentController,
                          hint: 'Write your insight here...',
                          maxLines: 8,
                          c: c,
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // =========================
                // 🔹 Folder Selector
                // =========================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Folder',
                          style: TextStyle(
                            color: c.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildFolderChips(c),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // =========================
                // 🔹 Attachments Section
                // =========================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attachments',
                          style: TextStyle(
                            color: c.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _buildAttachButton(
                                Icons.image_outlined, 'Image', c),
                            const SizedBox(width: 12),
                            _buildAttachButton(Icons.link, 'Link', c),
                            const SizedBox(width: 12),
                            _buildAttachButton(
                              Icons.document_scanner_outlined,
                              'Scan',
                              c,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // =========================
                // 🔹 Save Button
                // =========================
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildSaveButton(c),
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

  // =========================
  // 🔹 Header with Back Button
  // =========================
  Widget _buildHeader(AppThemeColors c) {
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
                'New Insight',
                style: TextStyle(
                  color: c.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Capture something worth remembering',
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

  // =========================
  // 🔹 Text Field Helper
  // =========================
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required 
    int maxLines,
    required AppThemeColors c,
  }) {
    const double padding = 16.0;
    const double borderRadius = 16.0;

    return Container(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: c.border, width: 1),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: c.textPrimary, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: c.textSecondary.withValues(alpha: 0.5),
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(padding),
        ),
      ),
    );
  }

  // =========================
  // 🔹 Folder Selection Chips
  // =========================
  Widget _buildFolderChips(AppThemeColors c) {
    const folders = ['Work', 'Personal', 'Ideas', 'Research'];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: folders.map((folder) {
        final isActive = _selectedFolder == folder;
        return GestureDetector(
          onTap: () => setState(() => _selectedFolder = folder),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? c.folderActiveBg : c.folderInactiveBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isActive ? c.folderActiveBg : c.folderInactiveBorder,
                width: 1.5,
              ),
            ),
            child: Text(
              folder,
              style: TextStyle(
                color: isActive ? Colors.white : c.folderInactiveText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // =========================
  // 🔹 Attachment Button Helper
  // =========================
  Widget _buildAttachButton(IconData icon, String label, AppThemeColors c) {
    const double padding = 14.0;
    const double iconSize = 22.0;
    const double borderRadius = 14.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: padding),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: c.border, width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: c.accent, size: iconSize),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: c.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // 🔹 Save Button
  // =========================
  Widget _buildSaveButton(AppThemeColors c) {
    const double padding = 16.0; // Button vertical padding
    const double borderRadius = 16.0; // Button border radius
    const double shadowBlur = 12.0; // Shadow blur radius
    const double shadowOpacity = 0.30; // Shadow opacity

    return GestureDetector(
      onTap: () {
        // Save logic here
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: padding),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [c.fabPrimary, c.fabSecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: c.fabPrimary.withValues(alpha: shadowOpacity),
              blurRadius: shadowBlur,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Save Insight',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
