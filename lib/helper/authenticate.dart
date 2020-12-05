import 'package:WeChat/views/signin.dart';
import 'package:WeChat/views/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignin = true;
  
  void toggleview(){
    setState(() {
      showSignin = !showSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return Signin(toggleview);
    }
    else{
      return SignUp(toggleview);
    }
  }
}