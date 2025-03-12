import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseImport {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  Future<void> importUserData(Map<String, String> mainUserData) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(uid)
        .set({'id': uid, 'userMainData': mainUserData});
  }

  Future<bool> editProfile(String email, String fname, String lname,
      String phoneNumber, int graduate) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('students').doc(uid).set({
        'userMainData': {
          'email': email,
          'fname': fname,
          'lname': lname,
          'phoneNumber': phoneNumber,
          'graduate': graduate
        }
      });
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> importVideoData(String videoId, String section) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      var snapshot = await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .collection('user_vid')
          .doc(videoId)
          .get();
      if (!snapshot.exists) {
        snapshot.reference.set({
          'id': videoId,
          'section': section,
          'purchased_data': Timestamp.fromDate(DateTime.now())
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
