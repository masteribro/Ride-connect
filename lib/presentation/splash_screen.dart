import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_connect/presentation/home/home_page.dart';

import 'auth/login_page.dart';
import 'auth/signup_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final user = this.user;
    if (user != null) {
      print("Logged in as: ${user.email}");
      return HomePage();
    } else {
      return SignupPage();
    }

  }
}
