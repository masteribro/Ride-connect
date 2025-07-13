import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailRegController = TextEditingController();
  TextEditingController passwordRegController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          TextField(
            controller: emailRegController,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          TextField(
            controller: passwordRegController,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),

          ElevatedButton(
            onPressed: () {
              signUp(emailRegController.text, passwordRegController.text);
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
      print("User registered: ${userCredential.user!.uid}");
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }
}
