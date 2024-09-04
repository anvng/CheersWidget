import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class StorageService {
  Future<String> savePhoto(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path =
        join(directory.path, '${DateTime.now().toIso8601String()}.png');
    final savedImage = await image.copy(path);
    return savedImage.path;
  }

  Future<void> deletePhoto(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
