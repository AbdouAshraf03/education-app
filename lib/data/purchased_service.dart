import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/data/firebase_import.dart';

import '../widgets/small_widgets.dart';

class PurchasedService {
  Future<bool> isValidCode(String code, BuildContext context) async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('codes').doc(code).get();
      return snapshot.data()!['user_id'] == "";
    } on FirebaseException catch (e) {
      if (context.mounted) {
        CustomDialog(title: 'error', desc: e.code, dialogType: DialogType.error)
            .showdialog(context);
      }
      return false;
    }
  }

  Future<bool> purchasedCode(String code, String videoCode, String section,
      BuildContext context) async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      var snapshot =
          await FirebaseFirestore.instance.collection('codes').doc(code).get();
      await snapshot.reference.update({'user_id': uid});
      await FirebaseImport().importVideoData(videoCode, section);
      return true;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        CustomDialog(title: 'error', desc: e.code, dialogType: DialogType.error)
            .showdialog(context);
      }
      return false;
    }
  }
}
