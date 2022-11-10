import 'package:flutter/material.dart';
import 'package:quiz_app/helper/constants.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:flutter/services.dart';

import '../widget/widget.dart';

class SignUp extends StatefulWidget {
  // final Function toogleView;
  //
  // SignUp({required this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // AuthService authService = new AuthService();
  // DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  // text feild
  bool _loading = false;
  String email = '', password = '', name = "";
  AuthService authService=new AuthService();

  getInfoAndSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      await authService
          .signUpWithEmailAndPassword(email.toString().trim(), password)
          .then((value) {
        if (value != null) {
          setState(() {
            _loading = false;
          });
          Constants.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
        // Map<String, String> userInfo = {
        //   "userName": name,
        //   "email": email,
        //
        //
        // databaseService.addData(userInfo);
        //
        // Constants.saveUserLoggedInSharedPreference(true);
        //
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Home()));

    }
  }

  @override
  Widget build(BuildContext context) {
    final iskeyboard=MediaQuery.of(context).viewInsets.bottom !=0;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: _loading
            ? Container(
          child: Center(child: CircularProgressIndicator()),
        )
            : Column(
          children: [
            if(!iskeyboard)Spacer(),
            Form(
              key: _formKey,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(!iskeyboard)ClipRRect(
                        child: Image.network("https://img.freepik.com/free-vector/thoughtful-woman-with-laptop-looking-big-question-mark_1150-39362.jpg?w=360&t=st=1668036238~exp=1668036838~hmac=0ac9ad200f9acef2da7d77a9798c15785e894077d6c039ac21734993a7e4d623",
                        // Image.network( "https://cdn-icons-png.flaticon.com/128/5677/5677910.png",
                            // height: maxHeight * 1,
                            fit: BoxFit.cover),
                      ),
                      // SizedBox(
                      //   height: 60,
                      // ),
                      TextFormField(
                        validator: (val) =>
                        val!.isEmpty ? "Enter an Name" : null,
                        decoration: InputDecoration(hintText: "Name"),
                        onChanged: (val) {
                          name = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) => validateEmail(email)
                            ? null
                            : "Enter correct email",
                        decoration: InputDecoration(hintText: "Email"),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? "Password must be 6+ characters"
                            : null,
                        decoration: InputDecoration(hintText: "Password"),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          getInfoAndSignUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have and account? ',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 17)),
                          GestureDetector(
                            onTap: () {
                              // widget.toogleView();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                            },
                            child: Container(
                              child: Text('Sign In',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      decoration: TextDecoration.underline,
                                      fontSize: 17)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern.toString());
  return (!regex.hasMatch(value)) ? false : true;
}