import 'package:flutter/material.dart';
import 'package:quiz_app/views/signin.dart';
// import 'package:quiz_app//services/database.dart';
// import 'package:quiz_app/views/add_question.dart';
import 'package:quiz_app/widget/widget.dart';
import 'package:random_string/random_string.dart';
import '../services/database.dart';
import 'addquestion.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateQuiz extends StatefulWidget {


  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String  ?quizTitle, quizDesc;
// String ?quizImgUrl;
  bool _isLoading = false;
  String ?quizId;



  createQuiz() async{

    quizId = randomAlphaNumeric(16);
    if(_formKey.currentState!.validate()){

      setState(() {
        _isLoading = true;
      });
      quizId=randomAlphaNumeric((16));

      Map<String, String> quizData = {
        "quizID" : quizId!,

        "quizTitle" : quizTitle!,
        "quizDesc" : quizDesc!
      };

      await databaseService.addQuizData(quizData, quizId!).then((value){
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>  AddQuestion(quizId!),
        ));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: AppLogo(),
        leading: GestureDetector(
          onTap: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          },
          child: Icon(Icons.login_outlined,color: Colors.black45,),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ],
        centerTitle: true,
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body:_isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        )
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // TextFormField(
              //   validator: (val) => val!.isEmpty ? "Enter Quiz Image Url" : null,
              //   decoration: InputDecoration(
              //       hintText: "Quiz Image Url (Optional)"
              //   ),
              //   onChanged: (val){
              //     quizImgUrl = val;
              //   },
              // ),
              // SizedBox(height: 5,),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Title"
                ),
                onChanged: (val){
                  quizTitle = val;
                },
              ),
              SizedBox(height: 5,),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Description" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Description"
                ),
                onChanged: (val){
                  quizDesc = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz();
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
                    "Create Quiz",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],)
          ,),
      ),
    );
  }
}


