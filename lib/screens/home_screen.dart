import 'package:flutter/material.dart';
import '../models/insight.dart';
import '../services/api_services.dart';
import 'detail_screen.dart';

/// Home Screen for SaveInsight app
/// Fetches and displays insights from API
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Insight>> _insightsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch insights when screen loads
    _insightsFuture = _apiService.fetchInsights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9), // Soft Off-White

      // AppBar
      appBar: AppBar(
        title: const Text(
          'Save Insight',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E1F3B), // Midnight Indigo
        elevation: 0,
      ),

      // Body with FutureBuilder
      body: FutureBuilder<List<Insight>>(
        future: _insightsFuture,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6D6AF0), // Muted Violet
              ),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load insights.\nPlease try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            );
          }

          // Empty state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No insights available.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            );
          }

          // Success state - display list
          final insights = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: insights.length,
            itemBuilder: (context, index) {
              final insight = insights[index];
              return _buildInsightCard(insight);
            },
          );
        },
      ),
    );
  }

  /// Build individual insight card
  Widget _buildInsightCard(Insight insight) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Navigate to detail screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(insight: insight),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                insight.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1F3B), // Midnight Indigo
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Body preview
              Text(
                insight.body,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}