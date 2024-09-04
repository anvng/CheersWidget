import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/user_database.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<void> fetchUser(int id) async {
    _currentUser = await UserDatabase.instance.getUser(id);
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    await UserDatabase.instance.updateUser(user);
    _currentUser = user;
    notifyListeners();
  }

  Future<void> deleteUser(int id) async {
    await UserDatabase.instance.deleteUser(id);
    _currentUser = null;
    notifyListeners();
  }

  Future<void> createUser(User user) async {
    await UserDatabase.instance.insertUser(user);
    _currentUser = user;
    notifyListeners();
  }
}
