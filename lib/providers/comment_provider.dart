import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../data/comment_database.dart';

class CommentProvider with ChangeNotifier {
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  Future<void> fetchComments(int photoId) async {
    _comments = await CommentDatabase.instance.getCommentsForPhoto(photoId);
    notifyListeners();
  }

  Future<void> addComment(Comment comment) async {
    await CommentDatabase.instance.insertComment(comment);
    _comments.add(comment);
    notifyListeners();
  }

  Future<void> deleteComment(int id) async {
    await CommentDatabase.instance.deleteComment(id);
    _comments.removeWhere((comment) => comment.id == id);
    notifyListeners();
  }
}
