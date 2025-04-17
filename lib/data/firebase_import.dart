import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseImport {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  Future<void> importUserData(Map<String, dynamic> mainUserData) async {
    await FirebaseFirestore.instance
        .collection('students')
        .doc(uid)
        .set({'userMainData': mainUserData});
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
          'graduate': graduate,
        }
      });
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> importVideoData(
      String videoId, String section, String grade, String videoTitle) async {
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
          'grade': grade,
          'title': videoTitle,
          'purchased_date': Timestamp.fromDate(DateTime.now())
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> addToLogs(
      {required String status,
      required String lecture,
      required String userID,
      required String name,
      required String email}) {
    var snapshot = FirebaseFirestore.instance.collection('students').doc().set({
      "Status": status,
      "Lecture": lecture,
      "User_ID": userID,
      "Name": name,
      "Email": email,
      "Time": DateTime.now(),
    });
    return snapshot.then((value) {
      print("Data added to logs successfully");
    }).catchError((error) {
      print("Failed to add data to logs: $error");
    });
  }
}
