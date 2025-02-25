import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

class FirebaseAuthService {
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> normalSignIn(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        CustomDialog(title: 'error', desc: e.code, dialogType: DialogType.error)
            .showdialog(context);
      }
    }
  }

  Future<void> normalSignUp(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        CustomDialog(title: 'error', desc: e.code, dialogType: DialogType.error)
            .showdialog(context);
        return;
      }
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    signInOption: SignInOption.standard,
    scopes: ['email', 'profile'],
  );

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.mainPage);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        CustomDialog(title: 'error', desc: e.code, dialogType: DialogType.error)
            .showdialog(context);
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
}
