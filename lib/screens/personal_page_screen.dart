import 'package:cheers_widget/models/user.dart';
import 'package:cheers_widget/services/database_helper.dart';
import 'package:flutter/material.dart';

class PersonalPageScreen extends StatelessWidget {
  const PersonalPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Page')),
      body: FutureBuilder<User>(
        future: DatabaseHelper.instance.getUser(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data!;
          return Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/assets/images/add.png'),
              ),
              const SizedBox(height: 20),
              Text(user.name, style: const TextStyle(fontSize: 24)),
              Text(user.phoneNumber),
              Text(user.email),
              Text('Born on ${user.birthdate.toLocal()}'.split(' ')[0]),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit_profile');
                },
                child: const Text('Edit Profile'),
              ),
            ],
          );
        },
      ),
    );
  }
}
