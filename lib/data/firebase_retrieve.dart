import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRetrieve {
  //final String? uid = FirebaseAuth.instance.currentUser?.uid;

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

  Future<List<String>?> getSectionsNames(String collectionName) async {
    //try {
    //TODO: change this
    var sections = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(collectionName == '1st_secondary' ||
                collectionName == '2nd_secondary'
            ? 'sections'
            : 'section')
        .get();
    // print(sections.data()!['section_names']);
    return sections.data()!['section_names'].cast<String>();
    // } catch (e) {
    //   print(e);
    // }
    // return ['Null'];
  }

  Future<List<String>?> getUserEmailAndName() async {
    try {
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      var userData = await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .get();
      return [
        userData.data()!['userMainData']['email'],
        userData.data()!['userMainData']['fname'] +
            ' ' +
            userData.data()!['userMainData']['lname']
      ];
    } catch (e) {
      print(e);
    }
    return ['Null', 'Null'];
  }
}
