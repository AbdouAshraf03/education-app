import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mr_samy_elmalah/data/assistant_methods.dart';

class FirebaseImport {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  Future<void> importUserData(Map<String, dynamic> mainUserData) async {
    await FirebaseFirestore.instance.collection('students').doc(uid).set({
      'userMainData': mainUserData,
      'device_id': await AssistantMethods.getDeviceId()
    });
  }

  Future<bool> editProfile(String email, String fname, String lname,
      String phoneNumber, int graduate) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('students').doc(uid).update({
        'userMainData.email': email,
        'userMainData.fname': fname,
        'userMainData.lname': lname,
        'userMainData.phoneNumber': phoneNumber,
        'userMainData.graduate': graduate,
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
    var snapshot = FirebaseFirestore.instance.collection('logs').doc().set({
      "Status": status,
      "Lecture": lecture,
      "User_ID": userID,
      "Name": name,
      "Email": email,
      "Type": 'Normal',
      "Date": Timestamp.fromDate(DateTime.now())
    });
    return snapshot.then((value) {
      print("Data added to logs successfully");
    }).catchError((error) {
      print("Failed to add data to logs: $error");
    });
  }
}
