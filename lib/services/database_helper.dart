import 'package:cheers_widget/models/comment.dart';
import 'package:cheers_widget/models/photo.dart';
import 'package:cheers_widget/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('locket_widget.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE photos (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  path TEXT NOT NULL,
  timestamp TEXT NOT NULL,
  caption TEXT
)
''');

    await db.execute('''
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  phoneNumber TEXT NOT NULL,
  email TEXT NOT NULL,
  birthdate TEXT NOT NULL
)
''');

    await db.execute('''
CREATE TABLE comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  photoId INTEGER NOT NULL,
  content TEXT NOT NULL,
  timestamp TEXT NOT NULL,
  FOREIGN KEY (photoId) REFERENCES photos (id)
)
''');
  }

  Future<int> insertPhoto(Photo photo) async {
    final db = await instance.database;
    return await db.insert('photos', photo.toMap());
  }

  Future<List<Photo>> getPhotos() async {
    final db = await instance.database;
    final photos = await db.query('photos');
    return photos.map((p) => Photo.fromMap(p)).toList();
  }

  Future<int> insertUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<User> getUser() async {
    final db = await instance.database;
    final users = await db.query('users');
    return users.map((u) => User.fromMap(u)).first;
  }

  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return await db
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> insertComment(Comment comment) async {
    final db = await instance.database;
    return await db.insert('comments', comment.toMap());
  }

  Future<List<Comment>> getComments(int photoId) async {
    final db = await instance.database;
    final comments =
        await db.query('comments', where: 'photoId = ?', whereArgs: [photoId]);
    return comments.map((c) => Comment.fromMap(c)).toList();
  }

  Future<List<User>> getFriends() async {
    final db = await instance.database;
    final users = await db.query('users');
    return users.map((u) => User.fromMap(u)).toList();
  }
}
