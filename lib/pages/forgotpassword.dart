import 'package:chatapp/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {


  String email="";

  TextEditingController emailController=TextEditingController();

  final _formkey=GlobalKey<FormState>();

  resetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password reset email has been sent',style: TextStyle(fontSize: 18.0),)));
    }
    on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No User Found for the given email',style: TextStyle(fontSize: 18.0),)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(
                      child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  )),
                ),
                const Center(
                    child: Text(
                  "Enter Your Email",
                  style: TextStyle(
                      color: Color.fromARGB(255, 37, 30, 30),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height / 2,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  return "Please enter email";
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
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap:(){
                              if(_formkey.currentState!.validate()){
                                setState(() {
                                  email=emailController.text;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                              }
                              resetPassword();
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 5.0,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF6380fb),
                                ),
                                child: const Text(
                                  "Recover Password",
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
                    ),
                  ),
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      child: const Text(
                        "Sign Up Now! ",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFF7f30fe),
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}