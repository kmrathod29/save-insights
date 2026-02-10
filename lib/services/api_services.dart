import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/insight.dart';

/// API Service for SaveInsight app
/// Handles communication with the REST API
class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/posts';

  /// Fetch insights from API
  Future<List<Insight>> fetchInsights() async {
    try {
      // Make GET request
      final response = await http.get(Uri.parse(_baseUrl));

      // Check if request was successful
      if (response.statusCode == 200) {
        // Decode JSON response
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Extract posts array
        final List<dynamic> postsJson = jsonData['posts'] as List<dynamic>;

        // Convert each post to Insight object
        final List<Insight> insights = postsJson
            .map((json) => Insight.fromJson(json as Map<String, dynamic>))
            .toList();

        return insights;
      } else {
        throw Exception('Failed to load insights: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching insights: $e');
    }
  }
}