import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/create_quiz.dart';
import 'package:quiz_app/views/playquiz.dart';
import 'package:quiz_app/views/signin.dart';
// import 'package:quiz_app/views/quiz_play.dart';
import 'package:quiz_app/widget/widget.dart';

import '../services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   late Stream<QuerySnapshot> quizStream;
  // late CollectionReference posts;
  DatabaseService databaseService = new DatabaseService();
   AuthService authService=new AuthService();
   getlogOut(){
     // await authService.signOut().then((value) {
     //   if (value != null) {
     //     setState(() {
     //
     //     });
         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => SignIn()));
     //   };
     // });

   }

   @override
   void initState() {
     databaseService.getQuizData().then((value) {
       quizStream = value;
       setState(() {});
     });
     super.initState();
   }

   Widget quizList() {
    return Container(
        child: Column(
            children: [
                       Expanded(child: StreamBuilder<QuerySnapshot>(
                           stream: quizStream,
                           builder: (BuildContext context,
                               AsyncSnapshot<QuerySnapshot> snapshot) {
                             if (snapshot.hasError) {
                               Scaffold.of(context).showSnackBar(new SnackBar(
                                 content: new Text("Error"),
                               ));
                             }
                             if (snapshot.connectionState == ConnectionState.waiting) {
                               return const Center(
                                 child: CircularProgressIndicator(),


                               );
                             }


                             final List storedocs = snapshot.data!.docs;
                             // snapshot.data!.docs.map((DocumentSnapshot document) {
                             //   Map<String,String> a = document.data() as Map<String, String>;
                             //   storedocs.add(a);
                             //   a['id'] = document.id;
                             // }).toList();



                             return ListView.builder(
                                 shrinkWrap: true,
                                 physics: ClampingScrollPhysics(),
                                 itemCount: storedocs.length,
                                 itemBuilder: (context, index) {
                                   return QuizTile(
                                     noOfQuestions: storedocs.length,
                                     description:
                                     storedocs[index]['quizDesc'],
                                     id: storedocs[index]["quizID"],

                                     title:
                                     storedocs[index]['quizTitle'],


                                   );
                                 });
                           })
                       )
              //       ]));
              // }










      //         StreamBuilder(
      //           stream: quizStream,
      //           builder: (context, AsyncSnapshot snapshot) {
      // if (snapshot.hasError) {
      //       Scaffold.of(context).showSnackBar(new SnackBar(
      //         content: new Text("Error"),
      //       ));
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator()
      //       );
      //         }
      //             return snapshot.data == null
      //                 ? Container(
      //               color: Colors.amber,
      //             )
      //                 : ListView.builder(
      //                 shrinkWrap: true,
      //                 physics: ClampingScrollPhysics(),
      //                 itemCount: snapshot.data?.documents.length,
      //                 itemBuilder: (context, index) {
      //                   return QuizTile(
      //                     noOfQuestions: snapshot.data?.documents.length,
      //                     imageUrl:
      //                     snapshot.data?[index]['quizImgUrl'],
      //                     title:
      //                     snapshot.data?[index]['quizTitle'],
      //                     description:
      //                     snapshot.data?.data[index]['quizDesc'],
      //                     id: snapshot.data?[index]["quizID"],
      //                   );
      //                 });
      //           },
      //         )
            ]));
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
        // const Icon(Icons.arrow_back,color:Colors.black45),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ],
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      resizeToAvoidBottomInset: false,
      body: quizList(),


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String title, id, description;
  //final String imageUrl;
  final int noOfQuestions;
  QuizTile(
      {required this.title,
        // required this.imageUrl,
        required this.description,
        required this.id,
        required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => QuizPlay(id),
          ));
        },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child:   SizedBox(height: 10),),


               Flexible(
                 flex:1,
                 fit: FlexFit.loose,
                 child:  Container(
                   padding: EdgeInsets.symmetric(horizontal: 24),
                   height: 150,
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(8),
                     child: Stack(
                       children: [
                         // CachedNetworkImage(
                         //   imageUrl: imageUrl,
                         //   placeholder: (context, url) => CircularProgressIndicator(),
                         //   errorWidget: (context, url, error) => Icon(Icons.error),
                         // ),
                         // Image(
                         //   image: imageUrl != null ? NetworkImage(imageUrl) : null,
                         //   width: 200,
                         // ),

                         // Ink.image(image: NetworkImage('"$imageUrl.trim()"'),
                         // fit: BoxFit.cover,
                         //   width: MediaQuery.of(context).size.width,
                         // ),
                         //     Image.network(
                         //       imageUrl
                         //       ,
                         //       fit: BoxFit.cover,
                         //       width: MediaQuery.of(context).size.width,
                         //     ),
                         Container(
                           // color: Colors.black87,

                           decoration: BoxDecoration(
                               gradient: LinearGradient(
                                 begin: Alignment.topRight,
                                 end: Alignment.bottomLeft,
                                 stops: [0.0,0.6,],
                                 colors: [
                                   Colors.orangeAccent,
                                   Colors.black87,
                                 ],
                               )
                           ),
                           child: Center(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   title,
                                   style: TextStyle(
                                       fontSize: 18,
                                       color: Colors.white,
                                       fontWeight: FontWeight.w500),
                                 ),
                                 SizedBox(height: 4,),
                                 Text(
                                   description,
                                   style: TextStyle(
                                       fontSize: 13,
                                       color: Colors.white,
                                       fontWeight: FontWeight.w500),
                                 )

                               ],
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
               // SizedBox(height: 10),
               //   // Text(imageUrl),

                 // SizedBox(height: 10),
               ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child:   SizedBox(height: 10),),
              ],
            ),

        

    );
  }

}
