// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
// import 'package:firebase_core/firebase_core.dart';

class FirebaseImport {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  Future<void> importUserData(Map<String, String> mainUserData) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(uid)
        .set({'id': uid, 'userMainData': mainUserData, 'userCodes': []});
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
        snapshot.reference.set({'id': videoId, 'section': section});
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
