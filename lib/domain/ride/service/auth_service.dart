import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../presentation/auth/login_page.dart';

class AuthService{
// Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();
  UserCredential? userCredential;
  String? get currentUid => userCredential?.user?.uid;
  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> signUp(
      String email, String password, String role, BuildContext context) async {
    try {
       userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String? uid = userCredential?.user!.uid;
      debugPrint("User ID: $uid");

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("User registered: $uid as $role");

      // ✅ Navigate only if context is still valid
      if (context.mounted) {
        debugPrint("Navigating to LoginPage");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Registration failed')),
        );
      }
    }
  }
}