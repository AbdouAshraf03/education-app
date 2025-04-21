import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mr_samy_elmalah/data/firebase_import.dart';
import 'package:mr_samy_elmalah/data/wallet_service.dart';

abstract class PurchasedService {
  static Future<bool> isValidCode(String code) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('codes').doc(code).get();
    if (snapshot.exists) {
      return snapshot.data()!['user_id'] == "" ||
          snapshot.data()!['user_id'] == null;
    } else {
      return false;
    }
  }

  static Future<bool> isValidVideoCode(
      String code, String grade, String section, String videoId) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(grade)
        .doc('section')
        .collection(section)
        .doc(videoId)
        .collection('codes')
        .doc(code)
        .get();
    if (snapshot.exists) {
      return snapshot.data()!['user_id'] == "" ||
          snapshot.data()!['user_id'] == null;
    } else {
      return false;
    }
  }

  static Future<bool> isUsedCode(String codeId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var snapshot = await FirebaseFirestore.instance
        .collection('students')
        .doc(uid)
        .collection('user_vid')
        .doc(codeId)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> purchasedCode(
      {required String code,
      required String videoCode,
      required String section,
      required String grade,
      required String videoTitle}) async {
    // try {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var snapshot =
        await FirebaseFirestore.instance.collection('codes').doc(code).get();
    if (snapshot.exists) {
      await snapshot.reference.update({'user_id': uid});
    } else {
      snapshot = await FirebaseFirestore.instance
          .collection(grade)
          .doc('section')
          .collection(section)
          .doc(videoCode)
          .collection('codes')
          .doc(code)
          .get();
    }

    if (snapshot.exists) {
      await snapshot.reference.update({'user_id': uid});
    } else {
      return false;
    }

    bool exists = await FirebaseImport()
        .importVideoData(videoCode, section, grade, videoTitle);
    String userCode;
    String userName;
    String userEmail;

    var userCodeSnapshot =
        await FirebaseFirestore.instance.collection('students').doc(uid).get();
    if (userCodeSnapshot.exists) {
      userCode = userCodeSnapshot.data()!['userMainData']['user_code'];
      userName =
          '${userCodeSnapshot.data()!['userMainData']['fname']} ${userCodeSnapshot.data()!['userMainData']['lname']}';
      userEmail = userCodeSnapshot.data()!['userMainData']['email'].toString();
    } else {
      return false;
    }

    if (exists) {
      FirebaseImport().addToLogs(
          status: 'success',
          lecture: videoTitle,
          userID: userCode,
          name: userName,
          email: userEmail);
      return true;
    } else {
      FirebaseImport().addToLogs(
          status: 'failed',
          lecture: videoTitle,
          userID: userCode,
          name: userName,
          email: userEmail);
      return false;
    }
  }

  static Future<void> assignCodeUser(String code, String uid) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('codes').doc(code).get();
    await snapshot.reference.update({'user_id': uid});
  }

  static Future<String> purchasedCodeFromWallet(
      {required String videoCode,
      required String section,
      required String grade,
      required String videoTitle,
      required int amount}) async {
    // try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    bool value = await WalletService.checkBalance(uid, amount);
    if (value) {
      await WalletService.subtractMoney(uid, amount);
    } else {
      return 'Not enough balance';
    }

    bool exists = await FirebaseImport()
        .importVideoData(videoCode, section, grade, videoTitle);
    String userCode;
    String userName;
    String userEmail;

    var userCodeSnapshot =
        await FirebaseFirestore.instance.collection('students').doc(uid).get();
    if (userCodeSnapshot.exists) {
      userCode = userCodeSnapshot.data()!['userMainData']['user_code'];
      userName =
          '${userCodeSnapshot.data()!['userMainData']['fname']} ${userCodeSnapshot.data()!['userMainData']['lname']}';
      userEmail = userCodeSnapshot.data()!['userMainData']['email'].toString();
    } else {
      return 'error assigning code';
    }

    if (exists) {
      FirebaseImport().addToLogs(
          status: 'success',
          lecture: videoTitle,
          userID: userCode,
          name: userName,
          email: userEmail);
      return 'success';
    } else {
      FirebaseImport().addToLogs(
          status: 'failed',
          lecture: videoTitle,
          userID: userCode,
          name: userName,
          email: userEmail);
      return 'error log';
    }
  }
}
