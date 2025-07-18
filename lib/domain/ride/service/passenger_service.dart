
import 'package:cloud_firestore/cloud_firestore.dart';

class PassengerService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> requestRide({
    required String passengerId,
    required String pickup,
    required String destination,
  }) async {
    DocumentReference rideRef = await _fireStore.collection('rideRequests').add({
      'passengerId': passengerId,
      'pickup': pickup,
      'destination': destination,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    });

    return rideRef.id;
  }

  Stream<DocumentSnapshot> trackRide(String rideId) {
    return _fireStore.collection('rideRequests').doc(rideId).snapshots();
  }
}
