import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'helper/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  // This widget is the root of your application.

  bool isUserLoggedIn=false;

  void initState(){
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
  Constants.getUerLoggedInSharedPreference().then((value){
    setState(() {
      isUserLoggedIn= value!;
    });
  });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home:
      // (isUserLoggedIn ?? false) ? Home() :
      SignIn(),
    );
  }
}
