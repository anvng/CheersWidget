import 'package:flutter/material.dart';
import '../models/user.dart';

class FriendListItem extends StatelessWidget {
  final User user;
  final Function onTap;

  const FriendListItem({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(user.profileImage ?? 'assets/images/'),
      ),
      title: Text(user.name),
      subtitle: Text(user.phoneNumber),
      onTap: () => onTap(user),
    );
  }
}
