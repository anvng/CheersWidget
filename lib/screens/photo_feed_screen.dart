import 'package:cheers_widget/models/photo.dart';
import 'package:cheers_widget/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PhotoFeedScreen extends StatefulWidget {
  const PhotoFeedScreen({super.key});

  @override
  _PhotoFeedScreenState createState() => _PhotoFeedScreenState();
}

class _PhotoFeedScreenState extends State<PhotoFeedScreen> {
  // Track the currently highlighted button
  int _selectedIndex = -1;

  // Method to handle button presses
  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/personal_page');
        break;
      case 1:
        Navigator.pushNamed(context, '/capture_photo');
        break;
      case 2:
        Navigator.pushNamed(context, '/friends_list');
        break;
      case 3:
        Navigator.pushNamed(context, '/login');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Feed'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: DatabaseHelper.instance.getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text('No photos available.'));
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            final isSelected = index == _selectedIndex;
            return IconButton(
              icon: Icon(
                index == 0
                    ? Icons.manage_accounts
                    : index == 1
                        ? Icons.camera
                        : index == 2
                            ? Icons.person_add
                            : Icons.login,
                color: isSelected ? Colors.blue : Colors.grey,
                size: isSelected ? 30.0 : 24.0,
              ),
              onPressed: () => _onButtonPressed(index),
            );
          }),
        ),
      ),
    );
  }
}
