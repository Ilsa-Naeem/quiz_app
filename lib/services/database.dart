import 'package:cloud_firestore/cloud_firestore.dart';
// Firestore=FirebaseFirestore
// Document=doc
// setData=set
class DatabaseService {
  late final String uid;

  // DatabaseService({this.uid});
  //
  // Future<void> addData(userData) async {
  //   FirebaseFirestore.instance.collection("users").add(userData).catchError((e) {
  //     print(e);
  //   });
  // }
  //
  // getData() async {
  //   return await FirebaseFirestore.instance.collection("users").snapshots();
  // }

  Future<void> addQuizData(Map<String, String> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e);
    });
  }


  Future<void> addQuestionData(Map<String,String> quesData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(quesData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuestionData(String quizId) async{
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}