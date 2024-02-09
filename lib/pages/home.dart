import 'package:chatapp/pages/chatpage.dart';
import 'package:chatapp/service/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(String value) {
    if (value.isEmpty) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      search = true;
    });
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; i++) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['username'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF553370),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    search
                        ? Expanded(
                            child: TextField(
                            onChanged: (value) {
                              initiateSearch(value.toUpperCase());
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search User ",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0)),
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500),
                          ))
                        : const Text(
                            "ChatUp",
                            style: TextStyle(
                                color: Color(0Xffc199cd),
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                    GestureDetector(
                      onTap: () {
                        search = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color(0xFF3a2144),
                            borderRadius: BorderRadius.circular(20)),
                        child: search
                            ? GestureDetector(
                                onTap: () {
                                  search = false;
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0Xffc199cd),
                                ),
                              )
                            : const Icon(
                                Icons.search,
                                color: Color(0Xffc199cd),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                height: search
                    ? MediaQuery.of(context).size.height / 1.19
                    : MediaQuery.of(context).size.height / 1.15,
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  search
                      ? ListView(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          primary: false,
                          shrinkWrap: true,
                          children: tempSearchStore.map((e) {
                            return buildResultCard(e);
                          }).toList(),
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset("images/1.jpg",
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover)),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.0),
                                      Text(
                                        'Sahid Kapoor',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Hello, What are you doing?',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    "04:45 PM",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset("images/1.jpg",
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover)),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.0),
                                      Text(
                                        'Shiv dutta',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Hello, What are you doing?',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    "04:45 PM",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatPage()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset("images/1.jpg",
                                          height: 70,
                                          width: 70,
                                          fit: BoxFit.cover)),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.0),
                                      Text(
                                        'Kapil Kapoor',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Hello, What are you doing?',
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    "04:00 PM",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset("images/1.jpg",
                              height: 70, width: 70, fit: BoxFit.cover)),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.0),
                          Text(
                            'Sahid Kapoor',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Hello, What are you doing?',
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "04:45 PM",
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["username"],style: TextStyle(),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
