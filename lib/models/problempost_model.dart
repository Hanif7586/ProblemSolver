class ProblemPost {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProblemPost({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProblemPost.fromJson(Map<String, dynamic> json) {
    return ProblemPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}