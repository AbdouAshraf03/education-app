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

  Future getMyVideos() async {
    try {
      List<Map<String, dynamic>> videosList = [];
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      var userData = await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .get();
      String graduate = userData.data()!['userMainData']['graduate'];
      // print(graduate);
      if (graduate == '3') {
        graduate = '3rd_secondary';
      } else if (graduate == '2') {
        graduate = '2nd_secondary';
      } else {
        graduate = '1st_secondary';
      }
      videosList.add({'graduate': graduate});
      var videosData = await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .collection('user_vid')
          .get();

      var videos = videosData.docs;
      for (var video in videos) {
        videosList.add(video.data());
      }

      //  print(videosList);
    } catch (e) {
      print(e.toString() + ' =======================');
    }
    return ['Null', 'Null'];
  }

  Future getMyVideoData(String videoId, String graduate, String section) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(graduate)
          //TODO : change this
          .doc('section')
          .collection(section)
          .doc(videoId)
          .get();
      return snapshot.data();
    } catch (e) {
      print(e.toString() + ' =======================');
    }
  }
}
