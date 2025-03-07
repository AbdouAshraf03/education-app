import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LottieLoader extends StatelessWidget {
  const LottieLoader({super.key});
  @override
  Widget build(BuildContext context) => Center(
        child: Lottie.asset(
          'assets/lottie/Animation - 1740337284424.json',
          height: 130.0,
          width: 130.0,
        ),
      );
}

class LottieNoData extends StatelessWidget {
  const LottieNoData({super.key});
  @override
  Widget build(BuildContext context) => Center(
        child: Lottie.asset(
          'assets/lottie/waqQPhxnbi.json',
          height: 200.0,
          width: 200.0,
        ),
      );
}

class LottieError extends StatelessWidget {
  const LottieError({super.key});
  @override
  Widget build(BuildContext context) => Center(
        child: Lottie.asset(
          'assets/lottie/AnimationError.json',
          height: 200.0,
          width: 200.0,
        ),
      );
}

class CustomDialog {
  CustomDialog({
    this.dialogType = DialogType.info,
    this.title,
    this.desc,
    this.btnOkOnPress,
  });
  DialogType dialogType;
  String? title;
  String? desc;
  void Function()? btnOkOnPress;
  Future<void> showdialog(BuildContext context) async {
    await AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnOkOnPress: btnOkOnPress,
    ).show();
  }
}
