import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChatScreen extends StatefulWidget {
  String userName;

  ChatScreen({required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String mesej = "";
  List<Widget> chatList = [
    SizedBox(
      height: 80,
    ),
    chatMesej(mesej: "Hello"),
    chatMesej(mesej: 'Hi !!', sendedByMe: true),
    chatMesej(mesej: "How are you ?"),
    chatMesej(mesej: "I'm fine, thanks", sendedByMe: true),
    chatMesej(mesej: "Hello"),
    chatMesej(mesej: 'Hi !!', sendedByMe: true),
    chatMesej(mesej: "How are you ?"),
    chatMesej(mesej: "I'm fine, thanks", sendedByMe: true),
    chatMesej(mesej: "Hello"),
    chatMesej(mesej: 'Hi !!', sendedByMe: true),
    chatMesej(mesej: "How are you ?"),
    chatMesej(mesej: "I'm fine, thanks", sendedByMe: true),
    chatMesej(mesej: "Hello"),
    chatMesej(mesej: 'Hi !!', sendedByMe: true),
    chatMesej(mesej: "How are you ?"),
    chatMesej(mesej: "I'm fine, thanks", sendedByMe: true),
    chatMesej(mesej: "Hello"),
    chatMesej(mesej: 'Hi !!', sendedByMe: true),
    chatMesej(mesej: "How are you ?"),
    chatMesej(mesej: "I'm fine, thanks", sendedByMe: true),
    chatMesej(mesej: "Hello"),
    chatMesej(mesej: 'Hi !!', sendedByMe: true),
    chatMesej(mesej: "How are you ?"),
    chatMesej(mesej: "I'm fine, thanks", sendedByMe: true),
    chatMesej(mesej: "Hello"),
    chatMesej(mesej: 'Hi !!', sendedByMe: true),
    chatMesej(mesej: "How are you ?"),
    chatMesej(mesej: "I'm fine, thanks", sendedByMe: true),
  ];
  var a;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String myUserName = Hive.box("LoginDetails").get("User Name");
    a = FirebaseFirestore.instance.collectionGroup(
        "${widget.userName} ${myUserName} ");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text(
        widget.userName,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: chatList,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6),
                height: 45,
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 80,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        textAlignVertical: TextAlignVertical.center,
                        autofocus: true,
                        textInputAction: TextInputAction.send,
                        selectionControls: MaterialTextSelectionControls(),
                        cursorColor: Colors.deepOrange,
                        onChanged: (input) {
                          setState(() {
                            mesej = input;
                          });
                        },
                        onFieldSubmitted: (input) {
                          print("submitteed");
                        },
                        decoration: InputDecoration(
                          prefix: Text(
                            "Message : ",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(80),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(80),
                            borderSide:
                                BorderSide(color: Colors.amber, width: 0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        style: IconButton.styleFrom(
                            alignment: Alignment.center,
                            backgroundColor: Colors.orange),
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Row chatMesej({required String mesej, bool sendedByMe = false}) {
  return Row(
    mainAxisAlignment:
        sendedByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.all(10),
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: sendedByMe ? Colors.lightGreen : Colors.grey,
          borderRadius: sendedByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15))
              : BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
        ),
        child: Text("   $mesej   "),
      )
    ],
  );
}
