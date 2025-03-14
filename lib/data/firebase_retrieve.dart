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
        '${userData.data()!['userMainData']['fname']} ${userData.data()!['userMainData']['lname']}'
      ];
    } catch (e) {
      print(e);
      return null;
    }
    // return ['Null', 'Null'];
  }

  Future<Map?> getUserData() async {
    try {
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('students')
          .doc(uid)
          .get();
      Map<String, dynamic> mainData = userData.data()!['userMainData'];
      mainData.addAll({'id': uid});
      return mainData;
    } catch (e) {
      print(e);
      return null;
    }
  }

// <<<<<<< HEAD
//   Future<List<Map<String, dynamic>>> getMyVideos() async {
//     try {
//       final String uid = FirebaseAuth.instance.currentUser!.uid;
//       var snapshot = await FirebaseFirestore.instance
//           .collection('students')
//           .doc(uid)
//           .collection('user_videos')
//           .get();

//       return snapshot.docs.map((doc) => doc.data()).toList();
//     } catch (e) {
//       print(e);
//     }
//     return [];
// =======
  Future<List<Map<String, dynamic>>> getMyVideos() async {
    try {
      List<Map<String, dynamic>> videosList = [];
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      var userData = await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .get();
      String graduate = userData.data()!['userMainData']['graduate'].toString();
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
      //print(videosList);
      return videosList;
    } catch (e) {
      print(e.toString() + ' =======================');
    }
    return [{}, {}];
  }

  Future<List<Map<String, dynamic>>> getMyVideosFromList(
      List<Map<String, dynamic>> videosMapList) async {
    try {
      List<Map<String, dynamic>> videosData = [];
      String graduate = videosMapList[0]['graduate'];
      videosMapList.removeAt(0);
      print(videosMapList);
      for (var video in videosMapList) {
        var data = await _getVideoData(video['id'], graduate, video['section']);
        videosData.add(data);
      }

      return videosData;
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future _getVideoData(String videoId, String graduate, String section) async {
    var snapshot = await FirebaseFirestore.instance
        .collection(graduate)
        //TODO : change this
        .doc('section')
        .collection(section)
        .doc(videoId)
        .get();
    //print(snapshot.data());
    return snapshot.data();
    // } catch (e) {
    //   print(e.toString() + ' =======================');
    // }
  }

  Future<List<Map<String, dynamic>>?> getVideos(
      String graduate, String section) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(graduate)
          .doc('section')
          .collection(section)
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> isThereUser() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    var snapshot =
        await FirebaseFirestore.instance.collection('students').doc(uid).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isTheEmailUsed(String email) async {
    try {
      // Query the Firestore collection to check if the email exists in the `userMainData` map
      var snapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('userMainData.email', isEqualTo: email)
          .get();

      // If the snapshot has any documents, it means the email is already used
      if (snapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error checking email: $e');
      return false;
    }
  }

//!#######
}
