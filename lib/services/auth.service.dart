import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends ChangeNotifier {
  // TODO: Fix not getting a prompt to select an account after logging out.
  static User? user = FirebaseAuth.instance.currentUser;
  final GoogleAuthProvider _authProvider = GoogleAuthProvider();
  // final GoogleSignIn _googleAuthProvider = GoogleSignIn();

  Future<void> googleSignIn() async {
    try {
      final response =
          await FirebaseAuth.instance.signInWithPopup(_authProvider);
      user = response.user;

      print("logged in");
      notifyListeners();
    } catch (e) {
      // log error
      print("Error: $e");
    }
  }

  Future<void> googleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // await _googleAuthProvider.signOut();
      print("logged out");

      user = null;
      notifyListeners();
    } catch (e) {
      // log error
      print("Error: $e");
    }
  }
}
