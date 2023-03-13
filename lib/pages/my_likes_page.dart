import 'package:flutter/material.dart';
import 'package:instagram_clone/model/member_model.dart';

class MyLikesPage extends StatefulWidget {
  static final String id = "mylikes_page";

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            color: Colors.green
        )
    );
  }
}
