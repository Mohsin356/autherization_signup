import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key, required this.docId, required this.name, required this.letter})
      : super(key: key);
  final String docId;
  final String name;
  final String letter;

  @override
  State<ChatScreen> createState() => _ChatScreenState(docId, name, letter);
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = TextEditingController();
  CollectionReference chats = FirebaseFirestore.instance.collection('chat');
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  final String docId;
  final String name;
  final String letter;

  _ChatScreenState(this.docId, this.name, this.letter);

  void sendMessage(String msg) {
    print('clicked...............$docId');
    chats.doc(docId).collection('messages').add({
      'text': msg,
    }).then((value) => msg='');
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .doc(docId)
              .collection('messages')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Loading"),
              );
            } else if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.green,
                  automaticallyImplyLeading: false,
                  flexibleSpace: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Text(
                              widget.letter,
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  "Online",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.video_call,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.call,
                                color: Colors.white,
                              )),
                          PopupMenuButton(
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            color: Colors.green,
                            itemBuilder: (BuildContext context) {
                              return [
                                const PopupMenuItem(
                                  child: Text(
                                    "View Contacts",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const PopupMenuItem(
                                  child: Text(
                                    "Search",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                const PopupMenuItem(
                                  child: Text(
                                    "Mute notifications",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                body: Stack(children: [
                ListView.builder(itemCount:snapshot.data!.docs.length,itemBuilder: (context,index){
                  return Text(snapshot.data!.docs[index]["text"]);
                }),
                Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, bottom: 10,top: 10),
                          height: 60,
                          width: double.infinity,
                          color: Colors.white,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration:  BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(Icons.add,color: Colors.white,size: 20,),
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Expanded(
                                  child:TextField(
                                    controller: message,
                                    cursorColor: Colors.green,
                                    decoration: const InputDecoration(
                                      hintText: "Write message here....",
                                      border: InputBorder.none,
                                    ),

                                  )),
                              const SizedBox(width: 15,),
                              FloatingActionButton(onPressed: (){
                                sendMessage(message.text.trim());
                              },
                                child: const Icon(Icons.send,color: Colors.white,size: 18,),
                                backgroundColor: Colors.green,
                                elevation: 0,),
                            ],
                          ),
                        ),
                      ),

                ]),
                // body: Stack(
                //   children:  [
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 60),
                //       child: ListView(
                //         children: abc
                //         .map((DocumentSnapshot document){
                //           data =document.data()!;
                //           return Container(
                //               padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                //               child: Align(
                //                 alignment: getAlignment(data['uid'].toString()),
                //                 // backgroundColor:isSender(data['uid'].toString())
                //                 child: Container(
                //                   constraints: const BoxConstraints(
                //                     minWidth: 50,
                //                   ),
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(20),
                //                     // color:(messagesList[index].messageType=="receiver"?Colors.lightBlue[400]:Colors.green),
                //                   ),
                //                   padding: const EdgeInsets.all(10),
                //                   child:const  Text("hi",style: const TextStyle(fontSize: 15,color: Colors.white,)),
                //
                //                 ),
                //               )
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //     Align(
                //       alignment: Alignment.bottomLeft,
                //       child: Container(
                //         padding: const EdgeInsets.only(left: 10, bottom: 10,top: 10),
                //         height: 60,
                //         width: double.infinity,
                //         color: Colors.white,
                //         child: Row(
                //           children: [
                //             GestureDetector(
                //               onTap: (){},
                //               child: Container(
                //                 height: 30,
                //                 width: 30,
                //                 decoration:  BoxDecoration(
                //                   color: Colors.green,
                //                   borderRadius: BorderRadius.circular(30),
                //                 ),
                //                 child: const Icon(Icons.add,color: Colors.white,size: 20,),
                //               ),
                //             ),
                //             const SizedBox(width: 15,),
                //             Expanded(
                //                 child:TextField(
                //                   controller: message,
                //                   cursorColor: Colors.green,
                //                   decoration: const InputDecoration(
                //                     hintText: "Write message here....",
                //                     border: InputBorder.none,
                //                   ),
                //
                //                 )),
                //             const SizedBox(width: 15,),
                //             FloatingActionButton(onPressed: (){
                //               sendMessage(message.text.trim());
                //             },
                //               child: const Icon(Icons.send,color: Colors.white,size: 18,),
                //               backgroundColor: Colors.green,
                //               elevation: 0,),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              );
            }
            return const Text("Error");
          }),
    );
  }
}
