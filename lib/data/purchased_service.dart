import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/data/firebase_import.dart';

class PurchasedService {
  Future<bool> isValidCode(String code, BuildContext context) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('codes').doc(code).get();
    if (snapshot.exists) {
      return snapshot.data()!['user_id'] == "" ||
          snapshot.data()!['user_id'] == null;
    } else {
      return false;
    }
  }

  Future<bool> isUsedCode(String codeId) async {
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

  Future<bool> purchasedCode(
      {required String code,
      required String videoCode,
      required String section,
      required String grade,
      required String videoTitle}) async {
    // try {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var snapshot =
        await FirebaseFirestore.instance.collection('codes').doc(code).get();
    await snapshot.reference.update({'user_id': uid});
    bool exists = await FirebaseImport()
        .importVideoData(videoCode, section, grade, videoTitle);
    if (!exists) return false;
    return true;
  }
}
