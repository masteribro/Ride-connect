import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_connect/presentation/home/home_page.dart';
import 'package:ride_connect/presentation/rider/rider_home_page.dart';

import 'auth/login_page.dart';
import 'auth/signup_page.dart';
import 'driver/driver_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

@override
  void initState() {
  checkUserAndNavigate();
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> checkUserAndNavigate() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          String role = snapshot.get('role');
          print("Logged in as $role");

          if (role == 'driver') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DriverHomePage()),
            );
          } else if (role == 'passenger') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RiderHomePage()),
            );
          } else {
            // If role is unknown
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SignupPage()),
            );
          }
        }
      } catch (e) {
        print("Error fetching role: $e");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignupPage()),
        );
      }
    } else {
      // User is not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignupPage()),
      );
    }
  }
}
