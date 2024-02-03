import 'package:chatapp/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/service/database.dart';
import 'package:chatapp/service/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "", confirmPassword = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration(String email1, String password1) async {
    if (password != "" && email != "" && password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email1, password: password1);

        String id = randomAlphaNumeric(10);

        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text.toString(),
          "Email": emailController.text.toString(),
          "username": emailController.text.replaceAll("@gmail.com", ""),
          "Photo":
              "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75b34a",
          "Id": id
        };
        await DatabaseMethods().addUserDetails(userInfoMap, id);
        await SharedPreferencesHelper().saveUserId(id);
        await SharedPreferencesHelper().saveUserDisplayName(
            emailController.text.replaceAll("@gmail.com", ""));
        await SharedPreferencesHelper().saveUserName(nameController.text);
        await SharedPreferencesHelper().saveUserMail(emailController.text);
        await SharedPreferencesHelper().saveUserPic(
            "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75b34a");

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registered Successfully')));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Provided Password is too Weak')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Email Already Registered Please Login')));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF7f30fe), Color(0xFF6380fb)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 105.0))),
          ),
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(
                      child: Text(
                    "SignUp",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                const Center(
                    child: Text(
                  "Create a new account",
                  style: TextStyle(
                      color: Color.fromARGB(255, 37, 30, 30),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 20.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Your Name";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "eg. Suraj Gupta",
                                    prefixIcon: Icon(Icons.person_2_outlined)),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Your Email";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "eg. abc@tmail.com",
                                    prefixIcon: Icon(Icons.email)),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Your Password";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "strong_password",
                                    prefixIcon: Icon(Icons.password)),
                                obscureText: true,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Confirm Password",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                controller: confirmController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Confirm Password";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "strong_password",
                                    prefixIcon: Icon(Icons.password)),
                                obscureText: true,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFF7f30fe),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print(_formkey.currentState!.validate());
                    if (_formkey.currentState != null &&
                        _formkey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text.toString();
                        name = nameController.text.toString();
                        password = passwordController.text.toString();
                        confirmPassword = confirmController.text.toString();
                      });
                    }
                    registration(email, password);
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5.0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF6380fb),
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
