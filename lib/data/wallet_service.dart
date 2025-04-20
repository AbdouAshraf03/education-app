import 'package:cloud_firestore/cloud_firestore.dart';

abstract class WalletService {
  static Future<void> addMoney(
    String uid,
    int anount,
    String code,
  ) async {
    var snapshot =
        await FirebaseFirestore.instance.collection('students').doc(uid).get();
    final int currBalance = snapshot.data()!['userMainData']['balance'];

    if (!snapshot.exists) {
      return;
    }

    await snapshot.reference
        .update({'userMainData.balance': currBalance + anount});
  }
}
