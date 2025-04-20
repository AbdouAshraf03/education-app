import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../core/app_assets.dart';

class LottieLoader extends StatelessWidget {
  const LottieLoader({super.key});
  @override
  Widget build(BuildContext context) => Center(
        child: Lottie.asset(
          LottieAppAssets.loader2,
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
          LottieAppAssets.noData,
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
          LottieAppAssets.error,
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
