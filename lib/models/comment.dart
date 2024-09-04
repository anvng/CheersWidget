class Comment {
  final int? id;
  final int photoId;
  final String content;
  final String timestamp;

  static var instance;

  Comment(
      {this.id,
      required this.photoId,
      required this.content,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoId': photoId,
      'content': content,
      'timestamp': timestamp,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      photoId: map['photoId'],
      content: map['content'],
      timestamp: map['timestamp'],
    );
  }
}
