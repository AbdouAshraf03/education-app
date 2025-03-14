import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/data/firebase_import.dart';
import 'package:mr_samy_elmalah/data/firebase_retrieve.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

class FirebaseAuthService {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  String _getFriendlyErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is badly formatted'; // Match Firebase's message
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      default:
        return 'Login failed. Please try again';
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> normalSignIn(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // print(e.code);
      if (context.mounted) {
        // print(e.code);
        CustomDialog(
                title: 'error',
                desc: _getFriendlyErrorMessage(e.code),
                dialogType: DialogType.error)
            .showdialog(context);
      }
    }
  }

  Future<UserCredential?> normalSignUp(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        CustomDialog(title: 'error', desc: e.code, dialogType: DialogType.error)
            .showdialog(context);
      }
    }
    return null;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    signInOption: SignInOption.standard,
    scopes: ['email', 'profile'],
  );

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Step 1: Sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User canceled the sign-in process

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 2: Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Step 3: Check if the email is already used
      // bool emailUsed =
      //     await FirebaseRetrieve().isTheEmailUsed(googleUser.email);
      // if (emailUsed) {
      //   if (context.mounted) {
      //     CustomDialog(
      //       title: 'Error',
      //       desc: 'The email is already used.',
      //       dialogType: DialogType.error,
      //     ).showdialog(context);
      //   }
      //   return; // Exit if the email is already used
      // }

      // Step 4: Check if user data exists
      bool saveData = await FirebaseRetrieve().isThereUser();
      if (!saveData) {
        // Step 5: Save user data if it doesn't exist
        await FirebaseImport().importUserData({
          'email': googleUser.email,
          'fname': googleUser.displayName!.split(' ')[0],
          'lname': googleUser.displayName!.split(' ')[1],
          'phoneNumber': '',
          'graduate': 3,
        });
      }

      // Step 6: Navigate to the main page
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.mainPage,
            arguments: 0);
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      if (context.mounted) {
        CustomDialog(
          title: 'Error',
          desc: e.code,
          dialogType: DialogType.error,
        ).showdialog(context);
      }
    } catch (e) {
      // Handle other errors (e.g., network, Firestore)
      if (context.mounted) {
        CustomDialog(
          title: 'Error',
          desc: '${e.toString()} ===============',
          dialogType: DialogType.error,
        ).showdialog(context);
      }
    }
  }

  Future<void> sendVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  void resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        CustomDialog(title: 'error', desc: e.code, dialogType: DialogType.error)
            .showdialog(context);
      }
    }
  }
}
