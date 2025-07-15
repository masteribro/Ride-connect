import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DriverService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Listen to new ride requests
  Stream<QuerySnapshot> getPendingRides() {
    return _firestore
        .collection('rideRequests')
        .where('status', isEqualTo: 'pending')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Accept a ride
  Future<void> acceptRide(String rideId, String driverId) async {
    await _firestore.collection('rideRequests').doc(rideId).update({
      'driverId': driverId,
      'status': 'accepted',
      'acceptedAt': FieldValue.serverTimestamp(),
    });
  }
}
