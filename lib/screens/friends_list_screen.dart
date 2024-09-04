import 'package:cheers_widget/models/user.dart';
import 'package:cheers_widget/services/database_helper.dart';
import 'package:flutter/material.dart';

class FriendsListScreen extends StatelessWidget {
  const FriendsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: DatabaseHelper.instance.getFriends(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final friend = snapshot.data![index];
              return ListTile(
                title: Text(friend.name),
                subtitle: Text(friend.phoneNumber),
                onTap: () {
                  // Navigate to friend's profile or chat
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add friend functionality
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
