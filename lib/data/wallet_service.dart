import 'package:cloud_firestore/cloud_firestore.dart';

abstract class WalletService {
  static Future<void> addMoney(
    String uid,
    int amount,
  ) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('students').doc(uid).get();
    final int currBalance = snapshot.data()!['userMainData']['balance'];

    if (!snapshot.exists) {
      return;
    }

    await snapshot.reference
        .update({'userMainData.balance': currBalance + amount});
  }

  static Future<void> subtractMoney(
    String uid,
    int amount,
  ) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('students').doc(uid).get();
    final int currBalance = snapshot.data()!['userMainData']['balance'];

    if (!snapshot.exists) {
      return;
    }

    await snapshot.reference
        .update({'userMainData.balance': currBalance - amount});
  }

  static Future<bool> checkBalance(String uid, int amount) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('students').doc(uid).get();
    final int currBalance = snapshot.data()!['userMainData']['balance'];
    if (currBalance >= amount) {
      return true;
    } else if (currBalance < amount) {
      return false;
    } else {
      return false;
    }
  }
}
