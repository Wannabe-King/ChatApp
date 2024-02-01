import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF553370),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0Xffc199cd),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset("images/1.jpg",
                            height: 50, width: 50, fit: BoxFit.cover)),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "Shahid Kappor",
                      style: TextStyle(
                          color: Color(0Xffc199cd),
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.15,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.only(
                          top: 20.0,
                          left: MediaQuery.of(context).size.width / 3),
                      alignment: Alignment.topRight,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 211, 214, 214),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Text(
                        "Hi, how are you doing?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 85, 83, 83),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      margin: EdgeInsets.only(
                          top: 20.0,
                          right: MediaQuery.of(context).size.width / 3),
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 139, 181, 245),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Text(
                        "Hi, how are you doing?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 85, 83, 83),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Spacer(),
                    Material(
                      borderRadius: BorderRadius.circular(40),
                      elevation: 5.0,
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 10, left: 30),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 219, 216, 216),
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Enter Your Message Here",
                                    hintStyle:
                                        TextStyle(color: Colors.black38),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black12),
                              child: const Icon(
                                Icons.send,
                                color: Colors.black38,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}