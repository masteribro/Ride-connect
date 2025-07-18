import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../domain/ride/service/auth_service.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailRegController = TextEditingController();
  final TextEditingController passwordRegController = TextEditingController();

  String selectedRole = 'passenger';

  final _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailRegController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordRegController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 20),

            // 🔽 Dropdown to select role
            DropdownButton<String>(
              value: selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole = newValue!;
                });
              },
              items: <String>['driver', 'passenger']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Register as $value'),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _authService.signUp(
                  emailRegController.text.trim(),
                  passwordRegController.text.trim(),
                  selectedRole,
                  context,
                );
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );}, child: Text('Already have an account? Login'),
            )
          ],
        ),
      ),
    );
  }



}
