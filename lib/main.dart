import 'package:WeChat/helper/authenticate.dart';
import 'package:WeChat/helper/helperfunction.dart';
import 'package:WeChat/views/chatroomscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async{
    await HelperFuntion.getUserLoggedInSharedPreference().then((value){
       setState(() {
         userIsLoggedIn = value;
       });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      home: userIsLoggedIn == true ? ChatRoom() : Authenticate(), 
    );
  }
}

