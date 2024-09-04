import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/photo.dart';

class PhotoDatabase {
  static final PhotoDatabase instance = PhotoDatabase._init();
  static Database? _database;

  PhotoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('photos.db');
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

  Future<int> updatePhoto(Photo photo) async {
    final db = await instance.database;
    return await db.update(
      'photos',
      photo.toMap(),
      where: 'id = ?',
      whereArgs: [photo.id],
    );
  }

  Future<int> deletePhoto(int id) async {
    final db = await instance.database;
    return await db.delete(
      'photos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
