import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  static final String id = "myprofile_page";

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          color: Colors.blue
        )
    );
  }
}
