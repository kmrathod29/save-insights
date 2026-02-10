import 'package:flutter/material.dart';
import '../models/insight.dart';

/// Detail Screen for SaveInsight app
/// Displays full content of a selected insight
class DetailScreen extends StatelessWidget {
  final Insight insight;

  const DetailScreen({
    super.key,
    required this.insight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9), // Soft Off-White

      // AppBar
      appBar: AppBar(
        title: const Text(
          'Insight',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF1E1F3B), // Midnight Indigo
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              insight.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1F3B), // Midnight Indigo
                height: 1.3,
              ),
            ),

            const SizedBox(height: 24),

            // Body content
            Text(
              insight.body,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                height: 1.6,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}