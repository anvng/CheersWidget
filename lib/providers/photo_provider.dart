import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../data/photo_database.dart';

class PhotoProvider with ChangeNotifier {
  List<Photo> _photos = [];

  List<Photo> get photos => _photos;

  Future<void> fetchPhotos() async {
    _photos = await PhotoDatabase.instance.getPhotos();
    notifyListeners();
  }

  Future<void> addPhoto(Photo photo) async {
    await PhotoDatabase.instance.insertPhoto(photo);
    _photos.add(photo);
    notifyListeners();
  }

  Future<void> deletePhoto(int id) async {
    await PhotoDatabase.instance.deletePhoto(id);
    _photos.removeWhere((photo) => photo.id == id);
    notifyListeners();
  }

  Future<void> updatePhoto(Photo photo) async {
    await PhotoDatabase.instance.updatePhoto(photo);
    int index = _photos.indexWhere((p) => p.id == photo.id);
    if (index != -1) {
      _photos[index] = photo;
      notifyListeners();
    }
  }
}
