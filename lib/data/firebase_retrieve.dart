import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRetrieve {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  Map? getUserDataFromGoogle() {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = GoogleSignIn().currentUser;

      return {'name': googleUser?.displayName, 'email': googleUser?.email};
    } catch (e) {
      print(e);
    }
    return null;
  }
}
