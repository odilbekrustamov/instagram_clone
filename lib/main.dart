import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/my_feed_page.dart';
import 'package:instagram_clone/pages/my_feed_page.dart';
import 'package:instagram_clone/pages/my_profile_page.dart';
import 'package:instagram_clone/pages/my_profile_page.dart';
import 'package:instagram_clone/pages/my_search_page.dart';
import 'package:instagram_clone/pages/my_upload_page.dart';
import 'package:instagram_clone/pages/my_upload_page.dart';
import 'package:instagram_clone/pages/signin_page.dart';
import 'package:instagram_clone/pages/signup_page.dart';
import 'package:instagram_clone/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.id: (context) => SplashPage(),
        SignInPage.id: (context) => SignInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        HomePage.id: (context) => HomePage(),
        MyFeedPage.id: (context) => MyFeedPage(),
        MySearchPage.id: (context) => MySearchPage(),
        MyUploadPage.id: (context) => MyUploadPage(),
        MySearchPage.id: (context) => MySearchPage(),
        MyProfilePage.id: (context) => MyProfilePage(),
      },
    );
  }
}
