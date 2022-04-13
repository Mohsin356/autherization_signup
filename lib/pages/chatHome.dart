import 'package:autherization/screens/chat_screen.dart';
import 'package:autherization/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:autherization/models/userlist.dart';
class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: UiColors.appBg,
        onPressed: () {},
        child: const Icon(
          Icons.chat,
          color: UiColors.iconClr,
        ),
      ),
      body: const ListConversations(),


    );
  }
}
class ListConversations extends StatefulWidget {
  const ListConversations({Key? key}) : super(key: key);

  @override
  State<ListConversations> createState() => _ListConversationsState();
}

class _ListConversationsState extends State<ListConversations> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: user.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            radius: 25.0,
            child:  Text(user[index].letter),
          ),
          title: Text(user[index].name),
          subtitle: Text(user[index].message),

          trailing: Text(user[index].time),
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> ChatScreen(docId:user[index].docId,
                name: user[index].name, letter:user[index].letter))
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),

    );
  }
}
