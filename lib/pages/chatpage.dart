import 'package:chatapp/pages/home.dart';
import 'package:chatapp/service/database.dart';
import 'package:chatapp/service/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class ChatPage extends StatefulWidget {
  String name, profilePic, username;

  ChatPage(
      {required this.name,
      required this.profilePic,
      required this.username,
      super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    onLoad();
    super.initState();
  }

  TextEditingController messageController = TextEditingController();
  String? myName, myProfilePic, myUsername, myEmail, messageId, chatRoomId;
  Stream? messageStream;

  gettheSharedPreference() async {
    myName = await SharedPreferencesHelper().getUserDisplayName();
    myProfilePic = await SharedPreferencesHelper().getUserPic();
    myUsername = await SharedPreferencesHelper().getUserName();
    myEmail = await SharedPreferencesHelper().getUserMail();
    chatRoomId = getChatRoomIdbyUsername(widget.username, myUsername!);
    setState(() {});
  }

  onLoad() async {
    await gettheSharedPreference();
    await getAndSetMessage();
    setState(() {});
  }

  getChatRoomIdbyUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(24),
                topRight: const Radius.circular(24),
                bottomRight: sendByMe
                    ? const Radius.circular(0)
                    : const Radius.circular(24),
                bottomLeft: sendByMe
                    ? const Radius.circular(24)
                    : const Radius.circular(0)),
            color: sendByMe
                ? const Color.fromARGB(255, 139, 181, 245)
                : const Color.fromARGB(255, 211, 214, 214),
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: Color.fromARGB(255, 85, 83, 83),
              fontSize: 16.0,
            ),
          ),
        ))
      ],
    );
  }

  Widget chatMessage() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 90.0, top: 130.0),
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return chatMessageTile(
                        ds['message'], myUsername == ds['sentBy']);
                  })
              : const Center(child: CircularProgressIndicator());
        });
  }

  getAndSetMessage() async {
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId!);
    setState(() {});
  }

  sendMessage(bool sendClicked) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('h:mma').format(now);
    if (messageController.text != "") {
      String message = messageController.text;
      messageController.text = "";
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sentBy": myUsername,
        "ts": formattedDate,
        "time": FieldValue.serverTimestamp(),
        "imgUrl": myProfilePic,
      };
      messageId ??= randomAlphaNumeric(10);

      DatabaseMethods()
          .addMessage(chatRoomId!, messageId!, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSentTs": formattedDate,
          "time": FieldValue.serverTimestamp(),
          "lastMessageSendBy": myUsername,
        };
        DatabaseMethods()
            .updateLastMessageSent(chatRoomId!, lastMessageInfoMap);
        if (sendClicked) {
          messageId = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF553370),
        body: SafeArea(
          child: Stack(children: [
            Container(
                margin: EdgeInsets.only(top: 60),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.12,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: chatMessage()),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0Xffc199cd),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        myProfilePic!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                        color: Color(0Xffc199cd),
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(40),
                elevation: 5.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  // decoration: const BoxDecoration(color: Colors.white),
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 10, left: 30),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 216, 216),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: "Enter Your Message Here",
                        hintStyle: const TextStyle(color: Colors.black38),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              sendMessage(true);
                            },
                            child: const Icon(Icons.send_rounded)),
                        border: InputBorder.none),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}

