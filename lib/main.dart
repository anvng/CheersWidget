import 'package:cheers_widget/screens/capture_photo_screen.dart';
import 'package:cheers_widget/screens/edit_profile_screen.dart';
import 'package:cheers_widget/screens/friends_list_screen.dart';
import 'package:cheers_widget/screens/personal_page_screen.dart';
import 'package:cheers_widget/screens/photo_feed_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CheersWidget());
}

class CheersWidget extends StatelessWidget {
  const CheersWidget({super.key});

  get appTheme => ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cheers Widget',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const PhotoFeedScreen(),
        '/capture_photo': (context) => const CapturePhotoScreen(),
        '/friends_list': (context) => const FriendsListScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/personal_page': (context) => PersonalPageScreen(),
      },
    );
  }
}
