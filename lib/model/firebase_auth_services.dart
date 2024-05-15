import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// FirebaseAuthService is a class that provides methods for user authentication using Firebase services.
class FirebaseAuthService {
  // Instance of FirebaseAuth for authentication operations.
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to register a new user with email, password, and username.
  Future<User?> signUpWithEmailAndPassword(String email, String password,
      String username, BuildContext context) async {
    try {
      // 1. Create a user in Firebase Authentication
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      // 2. Create a Firestore document for the new user
      if (user != null) {
        await FirebaseFirestore.instance.collection('User').doc(user.uid).set({
          'email': email,
          'password': password,
          'username': username,
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      // Handling authentication exceptions and displaying appropriate error messages.
      // Snackbars are used to notify the user about the issues.
      if (username.isEmpty && email.isNotEmpty && password.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('username field is empty'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (username.isNotEmpty && email.isEmpty && password.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('email field is empty'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (username.isNotEmpty && email.isNotEmpty && password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('password field is empty'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (username.isEmpty && email.isEmpty && password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('username, email, and password fields are empty'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${e.code}'),
            backgroundColor: Colors.red,
          ),
        );
      }

      return null;
    }
  }

  // Method to sign in an existing user with email and password.
  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Handling authentication exceptions and displaying appropriate error messages.
      // Snackbars are used to notify the user about the issues.
      if (email.isNotEmpty && password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('password field is empty'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (email.isEmpty && password.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('email field is empty'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (email.isEmpty && password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('email and password fields are empty'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${e.code}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    return null;
  }
}
