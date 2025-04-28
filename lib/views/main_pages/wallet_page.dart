import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/widgets/custom_pay_method.dart';
import '../../core/app_assets.dart';
import '../../data/firebase_retrieve.dart';
import '../../data/purchased_service.dart';
import '../../data/wallet_service.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/qr_scanner.dart';
import '../../widgets/small_widgets.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;

  Future<Map<dynamic, dynamic>?> getUserData() async =>
      await FirebaseRetrieve().getUserData();

  Future<void> addMoney(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      String uid = FirebaseAuth.instance.currentUser!.uid;
      bool isValidCode = await PurchasedService.isValidCode(_controller.text);

      if (!isValidCode) {
        if (context.mounted) {
          CustomDialog(
                  desc: 'هذا الكود غير صالح',
                  title: 'error',
                  dialogType: DialogType.error)
              .showdialog(context);
        }
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        await PurchasedService.assignCodeUser(_controller.text, uid);
        //TODO: change the amount to be added to the wallet
        await WalletService.addMoney(uid, 60);
        if (context.mounted) {
          CustomDialog(
                  desc: "تم اضافة 60 جنيه بنجاح",
                  title: 'success',
                  dialogType: DialogType.success)
              .showdialog(context);
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (context.mounted) {
        setState(() {
          isLoading = false;
        });
      }

      if (context.mounted) {
        CustomDialog(
                desc: e.toString(),
                title: 'Error',
                dialogType: DialogType.error)
            .showdialog(context);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double dHight = MediaQuery.of(context).size.height;
    double dWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              height: dHight * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
            ),
            //! Card
            Container(
              height: dWidth * (184 / 315),
              width: dWidth - 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1C71C2),
                    Color(0xFF5BAFFF),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: const Offset(5, 10),
                  ),
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: FutureBuilder(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: LottieLoader());
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error loading data'),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20.0),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Text("YOUR BALANCE",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'card')),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: SizedBox(
                                width: 75,
                                height: 75,
                                child: Image.asset(
                                  ImageAppAssets.mastercard,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topRight,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text('${snapshot.data!['balance']} EGP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontFamily: 'card')),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 20.0),
                              child: Text(
                                "${snapshot.data!['fname']} ${snapshot.data!['lname']}"
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'card'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          ]),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                'Pay Methods',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black54, fontSize: 20, fontFamily: 'cairo'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 20),
                CustomPayMethod(
                  icon: Image.asset(
                    ImageAppAssets.fawry,
                    height: 30,
                    width: 30,
                  ),
                  title: 'Fawry',
                  onPressed: () => CustomDialog(
                    desc: 'This feature is not available yet',
                    title: 'Info',
                    dialogType: DialogType.info,
                  ).showdialog(context),
                ),
                CustomPayMethod(
                  icon: const Icon(
                    Iconsax.code,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: 'Code',
                  onPressed: () => displayTextInputDialog(
                    context: context,
                    controller: _controller,
                    isLoading: isLoading,
                    btnOkOnPress: () => addMoney(context),
                  ),
                ),
                CustomPayMethod(
                  icon: const Icon(
                    Iconsax.scan,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: 'QR Code',
                  onPressed: () => displayTextInputDialogForScanner(
                    context: context,
                    controller: _controller,
                    isLoading: isLoading,
                    btnOkOnPress: () => addMoney(context),
                  ),
                ),
                CustomPayMethod(
                  icon: const Icon(
                    Iconsax.card,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: 'Card',
                  onPressed: () => CustomDialog(
                    desc: 'This feature is not available yet',
                    title: 'Info',
                    dialogType: DialogType.info,
                  ).showdialog(context),
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
