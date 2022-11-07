
import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddQuestion extends StatefulWidget {


  final String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";

  uploadQuesData() async{

    if (_formKey.currentState!.validate()) {

      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };

      print("${widget.quizId}");

      await databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        question = "";
        option1 = "";
        option2 = "";
        option3 = "";
        option4 = "";

        setState(() {
          _isLoading = false;
        });

      }).catchError((e){
        print(e);
      });


    }else{
      print("error is happening ");
    }
  }
  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();

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
        body: _isLoading
            ? Container(
          child: Center(child: CircularProgressIndicator()),
        )
            : Form(
          key: _formKey,
          child: Container(

            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) => val!.isEmpty ? "Enter Question" : null,
                    decoration: InputDecoration(hintText: "Question"),
                    onChanged: (val) {
                      question = val;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? "Option1 " : null,
                    decoration:
                    InputDecoration(hintText: "Option1 (Correct Answer)"),
                    onChanged: (val) {
                      option1 = val;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? "Option2 " : null,
                    decoration: InputDecoration(hintText: "Option2"),
                    onChanged: (val){
                      option2 = val;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? "Option3 " : null,
                    decoration: InputDecoration(hintText: "Option3"),
                    onChanged: (val){
                      option3 = val;

                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? "Option4 " : null,
                    decoration: InputDecoration(hintText: "Option4"),
                    onChanged: (val){
                      option4 = val;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {

                          Navigator.pop(context);

                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 2 - 36,
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Submit",
                            style:
                            TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          uploadQuesData();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 2 - 36,
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 20),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Add Question",
                            style:
                            TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
