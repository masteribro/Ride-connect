import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/ride/service/auth_service.dart';
import '../../domain/ride/service/driver_service.dart';
import '../auth/login_page.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final service = DriverService();
  final uid = AuthService().currentUid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: (){
                        logout(context);
                      },
                      child: Icon(Icons.logout)),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Text("Driver Home Page"),
              SizedBox(
                height: 20,
              ),
              Container(
                child: StreamBuilder(
                  stream: service.getPendingRides(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text("No rides yet");
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final ride = docs[index].data() as Map<String, dynamic>;
                        final id = docs[index].id;
                        return ListTile(
                          title: Text("From ${ride['pickup']} to ${ride['destination']}"),
                          subtitle: Text("Passenger: ${ride['passengerId']}"),
                          trailing: ElevatedButton(
                            onPressed: () => service.acceptRide(id, uid ?? ""),
                            child: const Text("Accept"),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context,  MaterialPageRoute(builder: (context) => const LoginPage()));

  }
}
