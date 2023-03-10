import 'package:flutter/material.dart';

class MySearchPage extends StatefulWidget {
  static final String id = "mysearch_page";

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          color: Colors.green
        )
    );
  }
}
