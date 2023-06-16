// ignore_for_file: must_be_immutable

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
  String mesej = "",
      myUserName = "";
  static int mesejId = 1;
  List<Widget> chatList = [
    SizedBox(
      height: 80,
    ),
    chatMesej(mesej: "Hello", sendedByMe: true)
  ];
  CollectionReference<Map<String, dynamic>>? messageList;

  TextEditingController message = TextEditingController();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> temp0 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myUserName = Hive.box("LoginDetails").get("User Name");
    // FirebaseFirestore.instance
    //     .collection("${widget.userName}-${myUserName}")
    //     .limit(1)
    //     .get()
    //     .then((snapshot) async {
    //   if (snapshot.size == 0) {
    //     messageList = await FirebaseFirestore.instance
    //         .collection("${widget.userName}-${myUserName}")
    //         .doc("Interaction")
    //         .collection("Messages");
    //     print("2 executed successfully");
    //     setState(() {});
    //   } else {
    //     messageList = await FirebaseFirestore.instance
    //         .collection("${myUserName}-${widget.userName}")
    //         .doc("Interaction")
    //         .collection("Messages");
    //     print("1 executed successfully");
    //
    //     setState(() {});
    //   }
    // });
    FirebaseFirestore.instance
        .collection("${widget.userName}-${myUserName}").doc("Interaction")
        .collection("Messages")
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty) {
        messageList = await FirebaseFirestore.instance
            .collection("${widget.userName}-${myUserName}")
            .doc("Interaction")
            .collection("Messages");
        print("2 executed successfully");
        setState(() {});
      } else if (snapshot.docs.isEmpty) {
        messageList = await FirebaseFirestore.instance
            .collection("${myUserName}-${widget.userName}")
            .doc("Interaction")
            .collection("Messages");
        print("1 executed successfully");
        setState(() {});
      }
    });
    setState(() {});
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    temp0 = await messageList!.get().then((value) {
      return value.docs;
    });
    QueryDocumentSnapshot<Map<String, dynamic>> temp1 = await temp0.last;
    int temp2 = await int.parse(temp1.id);
    if (temp2 >= mesejId) {
      mesejId = temp2 + 1;
      setState(() {});
    }
    // await FirebaseFirestore.instance
    //     .collection("${widget.userName}-${myUserName}")
    //     .limit(1)
    //     .get()
    //     .then((snapshot) async {
    //   if (snapshot.size == 0) {
    //     messageList = await FirebaseFirestore.instance
    //         .collection("${myUserName}-${widget.userName}")
    //         .doc("Interaction")
    //         .collection("Messages");
    //     print("1 executed successfully");
    //   } else {
    //     messageList = await FirebaseFirestore.instance
    //         .collection("${widget.userName}-${myUserName}")
    //         .doc("Interaction")
    //         .collection("Messages");
    //     print("2 executed successfully");
    //   }
    // });

    setState(() {});
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
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  // child: Column(
                  //   children: chatList,
                  // ),
                  child: StreamBuilder(
                    stream: messageList!.get().then((value) {
                      return value.docs;
                    }).asStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      List<QueryDocumentSnapshot<Map<String, dynamic>>>? data0 =
                          snapshot.data;
                      if (snapshot.hasData && snapshot.data != null) {
                        chatList.clear();
                        chatList.add(SizedBox(
                          height: 80,
                        ));
                        data0!.forEach(
                              (element) {
                            var m = element.data()["Message"];
                            var s = element.data()["Sender"];
                            if (s == myUserName) {
                              chatList
                                  .add(chatMesej(mesej: m, sendedByMe: true));
                            } else {
                              chatList
                                  .add(chatMesej(mesej: m, sendedByMe: false));
                            }
                          },
                        );
                        return Column(
                          children: chatList,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6),
                height: 45,
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 80,
                      child: TextFormField(
                        controller: message,
                        textCapitalization: TextCapitalization.words,
                        textAlignVertical: TextAlignVertical.center,
                        autofocus: true,
                        textInputAction: TextInputAction.send,
                        cursorColor: Colors.deepOrange,
                        onChanged: (input) {
                          setState(() {
                            mesej = input;
                          });
                        },
                        onFieldSubmitted: (input) async {
                          if (input.length != 0) {
                            var messageList0 =
                            await messageList!.doc(mesejId.toString());
                            await messageList0.set({
                              "Message": input,
                              "Sender": myUserName,
                              "Receiver": widget.userName
                            }).then((value) {
                              message.clear();
                              mesejId++;
                            });
                            // print("submitteed");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please enter your message in text field to send that to  this person.. ")));
                          }
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
                        onPressed: () async {
                          if (mesej.length != 0) {
                            var messageList1 =
                            await messageList!.doc(mesejId.toString());
                            await messageList1.set({
                              "Message": mesej,
                              "Sender": myUserName,
                              "Receiver": widget.userName
                            }).then((value) {
                              message.clear();
                              mesejId++;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please enter your message in text field to send that to  this person.. ")));
                          }
                        },
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
