import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/signup_page.dart';

import '../service/utils_service.dart';

class SignInPage extends StatefulWidget {
  static final String id = "signin_page";

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignIn(){
    String email = emailController.text.toString();
    String password = passwordController.text.toString();

    if(email.isEmpty && password.isEmpty){
      Utils.showToast("Please enter your email and password", context);
      return ;
    }else if(email.isEmpty){
      Utils.showToast("Please enter your email", context);
      return ;
    }else if(password.isEmpty){
      Utils.showToast("Please enter your password", context);
      return ;
    }

    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  _callSignUpPage(){
    Navigator.pushReplacementNamed(context, SignUpPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Instagram",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontFamily: "Billabong"),
                    ),

                    // #email
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: TextField(
                        controller: emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 17, color: Colors.white)
                        ),
                      ),
                    ),

                    // #password
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 50,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 17, color: Colors.white)
                        ),
                      ),
                    ),

                    // #password
                    GestureDetector(
                      onTap: (){
                        _doSignIn();
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Center(
                            child:  Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have a account?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    GestureDetector(
                      onTap: (){
                        _callSignUpPage();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
