import 'dart:io';

import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;
  final Function onDelete;
  final Function onEdit;

  const PhotoWidget(
      {super.key,
      required this.photo,
      required this.onDelete,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            File(photo.path),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              photo.caption ?? 'No Caption',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onEdit(photo),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(photo.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
