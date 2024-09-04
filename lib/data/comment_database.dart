import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/comment.dart';

class CommentDatabase {
  static final CommentDatabase instance = CommentDatabase._init();
  static Database? _database;

  CommentDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('comments.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  photoId INTEGER NOT NULL,
  content TEXT NOT NULL,
  timestamp TEXT NOT NULL
)
''');
  }

  Future<int> insertComment(Comment comment) async {
    final db = await instance.database;
    return await db.insert('comments', comment.toMap());
  }

  Future<List<Comment>> getCommentsForPhoto(int photoId) async {
    final db = await instance.database;
    final maps = await db.query(
      'comments',
      where: 'photoId = ?',
      whereArgs: [photoId],
    );

    return maps.map((map) => Comment.fromMap(map)).toList();
  }

  Future<int> updateComment(Comment comment) async {
    final db = await instance.database;
    return await db.update(
      'comments',
      comment.toMap(),
      where: 'id = ?',
      whereArgs: [comment.id],
    );
  }

  Future<int> deleteComment(int id) async {
    final db = await instance.database;
    return await db.delete(
      'comments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
