import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// WorkoutHistoryService is a class responsible for retrieving workout data from Firebase Firestore.
class WorkoutHistoryService {
  // Instance of FirebaseFirestore for Firestore database operations.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Instance of FirebaseAuth for authentication-related operations.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to retrieve workout data from Firebase Firestore.
  Future<List<Map<String, dynamic>>> getWorkoutData() async {
    // List to store workout data.
    List<Map<String, dynamic>> workoutDataList = [];

    // Retrieve the current user from FirebaseAuth.
    User? user = _auth.currentUser;

    // Return an empty list if the user is not signed in.
    if (user == null) {
      return workoutDataList;
    }

    // Retrieve workout data from the 'workout' collection in Firestore.
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('workout')
        .doc(user.uid)
        .collection(user.uid)
        .get();

    // Map the retrieved documents to a list of workout data.
    workoutDataList = querySnapshot.docs.map((doc) => doc.data()).toList();
    return workoutDataList;
  }
}
