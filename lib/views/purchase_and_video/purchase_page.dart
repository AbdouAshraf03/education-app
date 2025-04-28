import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/data/purchased_service.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

import '../../widgets/custom_dialog.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage(
      {super.key, required this.routeArg, required this.isPurchased});
  final Map<String, dynamic> routeArg;
  static final TextEditingController _textFieldController =
      TextEditingController();
  final dynamic isPurchased;

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  bool isLoading = false;
  void _showErrorDialog(BuildContext context, String message) {
    CustomDialog(
      title: 'Error',
      desc: message,
      dialogType: DialogType.error,
    ).showdialog(context);
  }

  void _showSuccessDialog(BuildContext context, String message) {
    CustomDialog(
      title: 'Success',
      desc: message,
      dialogType: DialogType.success,
    ).showdialog(context);
  }

  void addPurchased(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    if (!context.mounted) return;

    final String code = PurchasePage._textFieldController.text;

    try {
      final bool isValid = await PurchasedService.isValidCode(
        code,
      );
      final bool isValidVideoCode = await PurchasedService.isValidVideoCode(
        code,
        widget.routeArg['grade'],
        widget.routeArg['section'],
        widget.routeArg['vid_code'],
      );
      if (!isValid && !isValidVideoCode) {
        if (context.mounted) {
          _showErrorDialog(context, "الكود غير صحيح");
        }

        setState(() {
          isLoading = false;
        });
        return;
      }
      final bool isUsedCode =
          await PurchasedService.isUsedCode(widget.routeArg['vid_code']);
      if (isUsedCode) {
        if (context.mounted) {
          _showErrorDialog(context, "تم استخدامه مسبقًا");
        }
        setState(() {
          isLoading = false;
        });
        return;
      }
      // Step 2: Purchase the code
      final bool isPurchased = await PurchasedService.purchasedCode(
        code: code,
        videoCode: widget.routeArg['vid_code'],
        section: widget.routeArg['section'],
        grade: widget.routeArg['grade'],
        videoTitle: widget.routeArg['title'],
      );

      // Step 3: Show success dialog if purchase is successful
      if (isPurchased && context.mounted) {
        _showSuccessDialog(context, "تم شراء المحاضرة بنجاح");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle any unexpected errors
      if (context.mounted) {
        _showErrorDialog(context, "حدث خطأ غير متوقع: $e");
        setState(() {
          isLoading = true;
        });
      }
    }
  }

  void addPurchasedForWallet(BuildContext context) async {
    if (!context.mounted) return;

    try {
      final String isPurchased = await PurchasedService.purchasedCodeFromWallet(
        amount: widget.routeArg['price'],
        videoCode: widget.routeArg['vid_code'],
        section: widget.routeArg['section'],
        grade: widget.routeArg['grade'],
        videoTitle: widget.routeArg['title'],
      );

      // Step 3: Show success dialog if purchase is successful
      if (isPurchased == 'success' && context.mounted) {
        _showSuccessDialog(context, "تم شراء المحاضرة بنجاح");
      } else if (isPurchased == 'Not enough balance' && context.mounted) {
        _showErrorDialog(context, 'رصيدك غير كافي');
      } else if (isPurchased == 'error assigning code' && context.mounted) {
        _showErrorDialog(context, 'خطأ في تعيين الكود');
      } else if (isPurchased == 'error log' && context.mounted) {
        _showErrorDialog(context, 'خطأ في تسجيل عملية الشراء');
      } else {
        if (context.mounted) {
          _showErrorDialog(
              context, 'حدث حطأ غير متوقع برجاء التأكد من امتلاكك المحاضره');
        }
      }
    } catch (e) {
      // Handle any unexpected errors
      if (context.mounted) {
        _showErrorDialog(context, "حدث خطأ غير متوقع: $e");
      }
    }
  }

  int _getTimeRemaining(DateTime purchasedDate) {
    DateTime now = DateTime.now();
    int maxCooldownDays = 3;
    Duration difference = now.difference(purchasedDate);
    int remainingDays = maxCooldownDays - difference.inDays;
    return remainingDays > 0 ? remainingDays : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,
        actions: [
          Center(
            child: Text(
              !widget.isPurchased ? "شراء المحاضرة" : "المحاضرة",
              // textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20),
          Icon(Icons.play_lesson_rounded,
              color: Theme.of(context).primaryColor),
          SizedBox(width: 20),
          AnimatedMenuButton()
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //! image
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.routeArg['image_url'],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              //! title
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  widget.routeArg['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              SizedBox(height: 20),
              //! mony
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade200,
                ),
                height: 45,
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      !widget.isPurchased
                          ? widget.routeArg['price'].toString()
                          : '(ايام ${_getTimeRemaining((widget.routeArg['purchased_date'] as Timestamp).toDate()).toString()} )',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(width: 5),
                    Text(
                      !widget.isPurchased
                          ? ': سعر المحاضرة '
                          : 'متبقي من الوقت',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //! purchase botton
              MaterialButton(
                onPressed: () {
                  if (!widget.isPurchased) {
                    displayTextInputDialog(
                        context: context,
                        isLoading: isLoading,
                        controller: PurchasePage._textFieldController,
                        btnOkOnPress: () => addPurchased(context));
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 45,
                minWidth: MediaQuery.of(context).size.width - 40,
                color: widget.isPurchased
                    ? Colors.green
                    : Theme.of(context).primaryColor,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        !widget.isPurchased
                            ? 'شراء المحاضره'
                            : 'تم شراء المحاضرة',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      widget.isPurchased
                          ? Icon(
                              Icons.check,
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            )
                          : Icon(
                              Iconsax.money,
                              color: Colors.white,
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              //! purchase botton for wallet
              !widget.isPurchased
                  ? MaterialButton(
                      onPressed: () => addPurchasedForWallet(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 45,
                      minWidth: MediaQuery.of(context).size.width - 40,
                      color: widget.isPurchased
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'شراء المحاضره من المحفظه',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Iconsax.wallet_1,
                                color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 45),
              //! video section name
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  'المحتوايات',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 127, 127, 127)),
                ),
              ),
              SizedBox(height: 20),
              //! videos

              Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 40,
                // height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.shade200,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 10.0,
                      spreadRadius: 1,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20), // Padding instead of subtracting 40
                  child: Column(
                    children: [
                      // Heading
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ': المحاضرات',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 85, 89, 107),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // Add some spacing
                      //! Videos
                      Column(
                        children: List.generate(
                          widget.routeArg['video_url'].length ?? 0,
                          (index) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    if (widget.isPurchased) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.videoPlayerPage,
                                        arguments: widget.routeArg['video_url']
                                                [index] ??
                                            '',
                                      );
                                    }
                                  },
                                  title: Text(
                                    'الجزء ${index + 1}',
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontFamily: 'ge_ss',
                                        ),
                                  ),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: Center(
                                      child: Icon(
                                        Icons.video_collection_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      // // Content List
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ': الشيتات',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 85, 89, 107),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // Add some spacing

                      Column(
                        children: List.generate(
                          widget.routeArg['pdfs'].length ?? 0,
                          (index) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    if (widget.isPurchased) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.videoPlayerPage,
                                        arguments: widget.routeArg['pdfs']
                                                [index] ??
                                            '',
                                      );
                                    }
                                  },
                                  title: Text(
                                    'الشيت ${index + 1}',
                                    textAlign: TextAlign.end,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontFamily: 'ge_ss',
                                        ),
                                  ),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: Center(
                                      child: Icon(
                                        Iconsax.paperclip_copy,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
