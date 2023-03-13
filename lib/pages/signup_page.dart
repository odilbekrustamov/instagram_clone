import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/signin_page.dart';
import 'package:instagram_clone/service/auth_service.dart';

import '../service/utils_service.dart';

class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  _doSignUp(){
    String fullName = fullNameController.text.toString();
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    String cpassword = cpasswordController.text.toString();

    if(fullName.isEmpty){
      Utils.showToast("Please enter your fullname", context);
      return ;
    }else if(email.isEmpty){
      Utils.showToast("Please enter your email", context);
      return ;
    }else if(password.isEmpty){
      Utils.showToast("Please enter your password", context);
      return ;
    }else if(cpassword.isEmpty){
      Utils.showToast("Please enter your confirim password", context);
      return ;
    }else if(password != cpassword){
      Utils.showToast("Password and confirm password does not match", context);
      return ;
    }

    setState(() {
      isLoading = true;
    });
    AuthService.signUpUser(email, password).then((value) => {
       Utils.showToast("okkey", context),
      responseSignUp(value!),
    });
  }

  responseSignUp(User firebaseUser){
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, HomePage.id);

  }

  _callSignInPage(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
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
            child: Stack(
              children: [
                Column(
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

                          // #fullname
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7)
                            ),
                            child: TextField(
                              controller: fullNameController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "FullName",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 17, color: Colors.white)
                              ),
                            ),
                          ),

                          // #email
                          Container(
                            margin: EdgeInsets.only(top: 10),
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

                          // #cpassword
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 50,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7)
                            ),
                            child: TextField(
                              controller: cpasswordController,
                              obscureText: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Confirim Password",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 17, color: Colors.white)
                              ),
                            ),
                          ),

                          // #password
                          GestureDetector(
                            onTap: (){
                              _doSignUp();
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
                                    "Sign Up",
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
                            "Already have an account?",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),

                          SizedBox(
                            width: 10,
                          ),

                          GestureDetector(
                            onTap: (){
                              _callSignInPage();
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                isLoading
                   ? Center(
                       child: CircularProgressIndicator(),
                    )
                    : SizedBox.shrink()
              ],
            )
          ),
        )
    );
  }
}
