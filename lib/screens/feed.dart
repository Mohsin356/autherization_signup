import 'package:autherization/models/userModel.dart';
import 'package:autherization/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autherization/widgets/CommonButtons.dart';
import 'package:autherization/models/userModel.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  User? user= FirebaseAuth.instance.currentUser;
  UserModel loggedInUser= UserModel();
  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.
    collection("users")
    .doc(user!.uid).
    get()
    .then((value){
    loggedInUser= UserModel.fromMap(value.data());
    setState((){});
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(30)),
              Title(color: Colors.green, child: const Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold),)),
              const SizedBox(height: 20,),
              Text("${loggedInUser.userName}"),
              Text("${loggedInUser.userPhone}"),
              const SizedBox(height: 20,),
              CommonButton(buttonText: "Log out",btnAlign: Alignment.center, func: (){
                logOut(context);
              }),
            ],
          ),
        ),
        ),
      ),
    );
  }
  Future<void> logOut(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=> Welcome())
    );
  }

}
