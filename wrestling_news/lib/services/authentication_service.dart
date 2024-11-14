import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication _auth = LocalAuthentication();
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

  Future<bool> authenticateUser() async {
    try {
      bool isBiometricSupported = await _auth.isDeviceSupported();
      bool canCheckBiometrics = await _auth.canCheckBiometrics;

      if (isBiometricSupported && canCheckBiometrics) {
        bool authenticated = await _auth.authenticate(
          localizedReason: 'Please authenticate to access your account',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        return authenticated;
      } else {
        return false;
      }
    } catch (e) {
      print("Error during biometric authentication: $e");
      return false;
    }
  }
}
