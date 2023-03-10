import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/signin_page.dart';

class SplashPage extends StatefulWidget {
  static final String id = "splash_page";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _initTime();
  }

  _initTime(){
    Timer(Duration(seconds: 2), (){
      _callSignInPage();
    });
  }

  _callSignInPage(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  _callHomePage(){
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1),
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    "Instagram",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontFamily: "Billabong"),
                  ),
                ),
              ),
            ),

            Text(
              "All rights reserved",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),

            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
