import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<UserCredential?> googleSignin() async {
    try {
      final auth = FirebaseAuth.instance;
      final GoogleAuthProvider authProvider = GoogleAuthProvider();

      UserCredential user = await auth.signInWithPopup(authProvider);
      // final String? authToken = await user.user?.getIdToken();

      // // if authToken is null, will not set authToken to shared preferences and will return a null value for this function
      // if (authToken == null) return null;

      // // sets authToken to the shared preferences and returns user creds
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("authToken", authToken);
      return user;
    } catch (e) {
      // error handling; return null if failed to sign in
      return null;
    }
  }

  // static Future<String?> getAuthToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("authToken");
  // }

  static Future<void> googleSignout() async {}
}
