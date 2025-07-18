import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/ride/service/auth_service.dart';
import '../../domain/ride/service/passenger_service.dart';
import '../auth/login_page.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({super.key});

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {

  final service = PassengerService();
  String? rideId;
  String status = 'No request';
  TextEditingController pickupController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  void createRide(String passengerId, String pickup, String destination ) async {
    final id = await service.requestRide(
      passengerId: passengerId,
      pickup: pickup,
      destination: destination,
    );

    setState(() {
      rideId = id;
    });

    service.trackRide(id).listen((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        status = data['status'];
      });
    });
  }
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
              Text("Passenger Home Page"),
              SizedBox(
                height: 20,
              ),
              Text(status),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: pickupController,
                decoration: InputDecoration(
                  hintText: 'Pickup Location',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                  hintText: 'Destination Location',
                ),
              ),

              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: (){
                  createRide( uid ?? '', pickupController.text, destinationController.text );
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Book a ride"
                    ),
                  ),
                ),
              )
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
