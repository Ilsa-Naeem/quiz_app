// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/signup.dart';

import '../helper/constants.dart';
import '../widget/widget.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  // final Function toogleView;
  //
  // SignIn({required this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  // final AuthService _authService = AuthService();

  String email = '', password = '';

  // TextEditingController emailEditingController = new TextEditingController();
  // TextEditingController passwordEditingController = new TextEditingController();

  AuthService authService=new AuthService();

  bool _isLoading=false;

  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });


      await authService
          .signInEmailAndPass(email.toString().trim(),
          password.toString()).then((val){
            if(val!=null){
              setState(() {
                _isLoading = false;
              });
              Constants.saveUserLoggedInSharedPreference(true);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
            }
            else if(val==null){

              AlertDialog(
                title: Text('Invalid User'),           // To display the title it is optional
                content: Text('Enter correct data'),   // Message which will be pop up on the screen
                // Action widget which will provide the user to acknowledge the choice
                actions: [
                  FlatButton(                     // FlatButton widget is used to make a text to work like a button
                    textColor: Colors.black,
                    onPressed: () {},             // function used to perform after pressing the button
                    child: Text('CLose'),
                  ),

                ],
              );
            }
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    final iskeyboard=MediaQuery.of(context).viewInsets.bottom !=0;
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: Colors.white));
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
      body:  Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),

                    // child: SingleChildScrollView(
                    //   reverse: true,
                      child:Column(
                        // mainAxisSize: MainAxisSize.max,
                      children: [
                        if(!iskeyboard)Spacer(),
                       ClipRRect(
                          child: Image.network("https://img.freepik.com/free-vector/thoughtful-woman-with-laptop-looking-big-question-mark_1150-39362.jpg?w=360&t=st=1668036238~exp=1668036838~hmac=0ac9ad200f9acef2da7d77a9798c15785e894077d6c039ac21734993a7e4d623",
                          // Image.network( "https://cdn-icons-png.flaticon.com/128/5677/5677910.png",
                              // height: maxHeight * 1,
                              fit: BoxFit.cover),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        TextFormField(

                          validator:(val){
                            return val!.isEmpty ? "Enter Email ID" : null;
                          },
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
                          validator:(val){
                            return val!.isEmpty ? "Enter Password" : null;
                          },
                          decoration: InputDecoration(hintText: "Password"),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: (){
                            signIn();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account? ',
                                style:
                                TextStyle(color: Colors.black87, fontSize: 17)),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUp()));
                                // widget.toogleView();
                              },
                              child: Container(
                                child: Text('Sign Up',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        decoration: TextDecoration.underline,
                                        fontSize: 17)),
                              ),
                            ),
                          ],
                        ),
              SizedBox(
                height: 80,
              )
                      ],


              ),
                    ),



          // ),

      ),

    )
    ;
  }
}

