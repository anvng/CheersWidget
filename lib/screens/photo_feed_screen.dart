import 'package:cheers_widget/models/photo.dart';
import 'package:cheers_widget/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PhotoFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Feed')),
      body: FutureBuilder<List<Photo>>(
        future: DatabaseHelper.instance.getPhotos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final photo = snapshot.data![index];
              return GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(photo.caption ?? 'No Caption'),
                ),
                child: Image.file(File(photo.path)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/capture_photo'),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
