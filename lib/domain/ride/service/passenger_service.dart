
import 'package:cloud_firestore/cloud_firestore.dart';

class PassengerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> requestRide({
    required String passengerId,
    required String pickup,
    required String destination,
  }) async {
    DocumentReference rideRef = await _firestore.collection('rideRequests').add({
      'passengerId': passengerId,
      'pickup': pickup,
      'destination': destination,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    });

    return rideRef.id; // Return the ride ID for real-time tracking
  }

  Stream<DocumentSnapshot> trackRide(String rideId) {
    return _firestore.collection('rideRequests').doc(rideId).snapshots();
  }
}
