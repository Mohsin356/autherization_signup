import 'package:autherization/models/userModel.dart';
import 'package:autherization/pages/chatHome.dart';
import 'package:autherization/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autherization/widgets/CommonButtons.dart';
import 'package:autherization/utils/assets.dart';

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
    return  DefaultTabController(length: 4, initialIndex: 1,
      child: Scaffold(
        backgroundColor: UiColors.appBgWhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("ChatStore",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
          backgroundColor: UiColors.appBg,
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            PopupMenuButton<String>(
              color: UiColors.appBg,
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text("New group",style: TextStyle(color: UiColors.textColor),),
                  ),
                  const PopupMenuItem(
                    child: Text("Settings",style: TextStyle(color: UiColors.textColor),),
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: ()=>logOut(context),
                      child: const Text("Logout",style: TextStyle(color: UiColors.textColor,),),
                    ),
                  ),
                ];
              },
            )
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.camera_alt),),
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "STATUS",
              ),
              Tab(
                text: "CALLS",
              )
            ],
          ),
        ),
        body: const SafeArea(
          child:TabBarView(
            children: [
              Text("Camera"),
              HomeChat(),
              Text("Status"),
              Text("Calls"),
            ],
          ),
        ),

      ),

    );
  }
  Future<void> logOut(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=> const Welcome())
    );
  }

}
