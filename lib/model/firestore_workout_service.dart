import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_fitness_application/model/done_exercise.dart';
import 'package:smart_fitness_application/model/selected_exercise.dart';

// FirestoreWorkoutService is a class responsible for interacting with Firebase Firestore to manage workout data.
class FirestoreWorkoutService {
  // Instance of FirebaseFirestore for Firestore database operations.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Instance of FirebaseAuth for authentication-related operations.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to add a completed workout, including exercise details, to Firestore.
  Future<void> addExerciseToWorkout({
    required String duration,
    required String workoutDate,
  }) async {
    try {
      // Retrieve the current user from FirebaseAuth.
      User? user = _auth.currentUser;
      if (user == null) {
        return; // Exit the method if the user is not signed in.
      }

      // Reference to the 'workout' collection in Firestore.
      CollectionReference workoutCollection = _firestore.collection('workout');

      // Retrieve the list of completed exercises from DoneExercises.
      List<Map<String, dynamic>> exerciseList = DoneExercises().doneExercises;

      // Add the workout document with exercises directly nested.
      await workoutCollection.doc(user.uid).collection(user.uid).add({
        'userId': user.uid,
        'duration': duration,
        'workoutDate': workoutDate,
        'exerciseList': exerciseList,
      });

      // Clear the lists of completed and selected exercises after successfully adding to Firestore.
      DoneExercises().clearDoneExercises();
      SelectedExercises().clearSelectedExercises();
    } catch (e) {
      // Print an error message if an exception occurs during the Firestore operation.
      print('Error adding exercise to workout: $e');
    }
  }
}
