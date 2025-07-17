import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_connect/presentation/driver/driver_home_page.dart';
import 'package:ride_connect/presentation/rider/rider_home_page.dart';

import '../../user/utils.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),

          ElevatedButton(
            onPressed: () {
              login(emailController.text, passwordController.text, context);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  void login(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userData = await getUserData();

      if (userData != null) {
        String role = userData['role'];
        print("User role: $role");

        if (role == 'driver') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DriverHomePage()));
        } else if (role == 'passenger') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RiderHomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid user role")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User role not found")),
        );
      }
    } catch (e) {
      print("Login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }


}
