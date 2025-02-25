import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

class FirebaseImport {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  Future<void> importUserData(Map<String, String> mainUserData) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(uid)
        .set({'id': uid, 'userMainData': mainUserData, 'userCodes': []});
  }
}
