import 'dart:io';
import 'package:chatapp/pages/chatpage.dart';
import 'package:chatapp/pages/forgotpassword.dart';
import 'package:chatapp/pages/home.dart';
import 'package:chatapp/pages/signin.dart';
import 'package:chatapp/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyA1lOiARKUW3K1fcmLJ5Fr2OQPHAAaKpfs',
          appId: '1:12716894522:android:91782c683ec584593f4803',
          messagingSenderId: '12716894522',
          projectId: 'chatapp-7dedc',
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignUp(),
    );
  }
}
