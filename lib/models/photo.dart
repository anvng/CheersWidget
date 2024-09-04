class Photo {
  final int? id;
  final String path;
  final String timestamp;
  final String? caption;

  Photo({this.id, required this.path, required this.timestamp, this.caption});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
      'timestamp': timestamp,
      'caption': caption,
    };
  }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      path: map['path'],
      timestamp: map['timestamp'],
      caption: map['caption'],
    );
  }
}
