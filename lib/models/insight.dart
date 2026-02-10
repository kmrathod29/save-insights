class Insight {
  final int id;
  final String title;
  final String body;

  Insight({
    required this.id,
    required this.title,
    required this.body,
  });

  // Create Insight from JSON
  factory Insight.fromJson(Map<String, dynamic> json) {
    return Insight(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  // Convert Insight to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}