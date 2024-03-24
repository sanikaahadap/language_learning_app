import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_learning_app/user.dart';

import 'home_page.dart'; // Import Firestore

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // Method to create account and store email in Firestore
  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      log("Please fill all the details!");
    } else if (password != cPassword) {
      log("Passwords do not match!");
    } else {


      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          log("User created successfully");
          saveUser(); // Add this log
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LanguageLearningAppHomePage()));
        }
      } on FirebaseAuthException catch (ex) {
        log("FirebaseAuthException: ${ex.code}"); // Add this log
      } catch (e) {
        log("Error: $e"); // Add this log
      }
    }
  }

  Future<void> saveUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();


    if (name != "" && email != "" ) {
      ModelUser user = ModelUser(
          name: name,
          email: email
      );
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(user.toJson());
        log("User created!");
      } catch (err) {
        log(err.toString());
      }
    } else {
      log("Please fill all the fields!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create an account"),
      ),
      body: SafeArea(
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [

                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: "Name"
                    ),
                  ),

                  const SizedBox(height: 10,),

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
                  ),

                  const SizedBox(height: 10,),

                  TextField(
                    controller: cPasswordController,
                    decoration: const InputDecoration(
                        labelText: "Confirm Password"
                    ),
                  ),

                  const SizedBox(height: 20,),

                  CupertinoButton(
                    onPressed: () {
                      createAccount();
                    },
                    color: Colors.blue,
                    child: const Text("Create Account"),
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}