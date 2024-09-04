import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final Function onDelete;

  const CommentWidget(
      {super.key, required this.comment, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.content),
      subtitle: Text(comment.timestamp.toString()),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(comment.id),
      ),
    );
  }
}
