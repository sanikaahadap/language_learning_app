import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_learning_app/signup.dart';

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email == "" || password == "") {
      log("Please fill all the fields!");
    }
    else {
      try {
        // Check if the user is already authenticated
        if (FirebaseAuth.instance.currentUser != null) {
          // If authenticated, sign out before proceeding with login
          await FirebaseAuth.instance.signOut();
        }

        // Proceed with login process
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, CupertinoPageRoute(
              builder: (context) => const LanguageLearningAppHomePage()
          ));
        }
      } on FirebaseAuthException catch(ex) {
        log(ex.code.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: "Email Address"
                    ),
                  ),

                  const SizedBox(height: 10,),

                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        labelText: "Password"
                    ),
                    obscureText: true,
                  ),

                  const SizedBox(height: 20,),

                  CupertinoButton(
                    onPressed: () {
                      login();
                    },
                    color: Colors.blue,
                    child: const Text("Log In"),
                  ),

                  const SizedBox(height: 10,),

                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(context, CupertinoPageRoute(
                          builder: (context) => const SignUpScreen()
                      ));
                    },
                    child: const Text("Create an Account"),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}