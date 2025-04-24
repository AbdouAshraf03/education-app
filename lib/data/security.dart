import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mr_samy_elmalah/data/assistant_methods.dart';

import 'package:flutter/services.dart';

abstract class Security {
  static final String user = FirebaseAuth.instance.currentUser!.uid;

  static Future<bool> handleLogin(String uid) async {
    final deviceId = await AssistantMethods.getDeviceId();
    final doc = FirebaseFirestore.instance.collection('Students').doc(uid);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      final savedDeviceId = data?['device_id'];

      if (savedDeviceId != null && savedDeviceId != deviceId) {
        return false;
      }
    }

    return true;
  }

  static Future<bool> rootedDevice() async {
    try {
      const platform = MethodChannel('security_channel');
      final bool result = await platform.invokeMethod('isRooted');

      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool> developerModeDevice() async {
    try {
      const platform = MethodChannel('security_channel');
      final bool result = await platform.invokeMethod('isDeveloperMode');

      return result;
    } on PlatformException {
      return false;
    }
  }
}
