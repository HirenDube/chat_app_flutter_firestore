import 'package:chat_app_flutter_firestore/ChatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChatSelectorScreen extends StatefulWidget {
  const ChatSelectorScreen({Key? key}) : super(key: key);

  @override
  State<ChatSelectorScreen> createState() => _ChatSelectorScreenState();
}

class _ChatSelectorScreenState extends State<ChatSelectorScreen> {
  String myUserName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myUserName = Hive.box("LoginDetails").get("User Name");
  }

  fetchData() async {
    List registerdUsersData = [];
    await FirebaseFirestore.instance.collection("USERS").get().then((value) {
      registerdUsersData = value.docs;
    });
    return registerdUsersData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Chats"),
        ),
        body: FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot no = snapshot.data[index];
                  String userName = no.get("Name");
                  String phoneNo = no.get("Phone No");
                  if (userName != myUserName) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      userName: userName,
                                    )));
                      },
                      title: Text("$userName"),
                      subtitle: Text("$phoneNo"),
                    );
                  }
                  else {
                    return Text("",style: TextStyle(fontSize: 0),);
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
