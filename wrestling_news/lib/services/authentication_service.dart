import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<bool> checkIfSignedIn() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserCredential> signInAnonymously() async {
    try {
      UserCredential user = await FirebaseAuth.instance.signInAnonymously();
      return user;
    } catch (e) {
      throw Exception();
    }
  }
}
