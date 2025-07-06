import 'dart:convert';

class Post {
  final int id;
  final String title;
  final String content;
  final String image;
  final int userId; // ✅ Renamed to camelCase
  final List<Comment> comments;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.userId,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final commentsJson = json['comments'];
    final commentsList = commentsJson is List
        ? commentsJson.map((c) => Comment.fromJson(c)).toList()
        : <Comment>[];

    return Post(
      id: _parseInt(json['id']),
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      userId: _parseInt(json['user_id']),
      comments: commentsList,
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'user_id': userId,
      'comments': comments.map((c) => c.toJson()).toList(),
    };
  }
}

class Comment {
  final int id;
  final String content;
  final List<String> images;

  Comment({
    required this.id,
    required this.content,
    required this.images,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: Post._parseInt(json['id']),
      content: json['content']?.toString() ?? '',
      images: _parseImages(json['image']),
    );
  }

  static List<String> _parseImages(dynamic imageData) {
    if (imageData == null) return [];

    if (imageData is List) {
      return imageData.whereType<String>().toList();
    }

    if (imageData is String) {
      try {
        final decoded = jsonDecode(imageData);
        if (decoded is List) {
          return decoded.whereType<String>().toList();
        }
      } catch (_) {
        // If not a JSON list, treat as single image string
        return [imageData];
      }
    }

    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'image': images,
    };
  }
}
