// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/data/purchased_service.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
// import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

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
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'ادخل كود الشراء',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'roboto',
                ),
          ),
          content: TextField(
            controller: PurchasePage._textFieldController,
            keyboardType: TextInputType.multiline,
            //obscureText: passwordVisible,
            enableSuggestions: false,

            // textDirection: TextDirection.rtl,
            cursorColor: const Color.fromARGB(255, 28, 113, 194),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontFamily: 'roboto'),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 28, 113, 194),
                  )),
              // prefixIcon: Icon(, color: Colors.grey),
              floatingLabelAlignment: FloatingLabelAlignment.start,

              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              labelText: 'الكود',
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                    textBaseline: TextBaseline.alphabetic,
                  ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                // Navigator.pop(context);
                PurchasedService()
                    .isValidCode(
                        PurchasePage._textFieldController.text, context)
                    .then((value) {
                  if (value) {
                    if (context.mounted) {
                      PurchasedService()
                          .purchasedCode(
                              PurchasePage._textFieldController.text,
                              widget.routeArg['vid_code'],
                              widget.routeArg['section'],
                              context)
                          .then((value) {
                        if (value) {
                          if (context.mounted) {
                            CustomDialog(
                                    title: 'Success',
                                    desc: "تم شراء المحاضرة بنجاح",
                                    dialogType: DialogType.success)
                                .showdialog(context);
                          }
                        }
                      });
                    }
                  } else {
                    if (context.mounted) {
                      CustomDialog(
                              title: 'error',
                              desc: "او الكود غير صحيح تم استخدام الكود مسبقًا",
                              dialogType: DialogType.error)
                          .showdialog(context);
                    }
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    PurchasePage._textFieldController.dispose();
    super.dispose();
  }

  int _getTimeRemaining(DateTime purchasedDate) {
    DateTime now = DateTime.now();
    int timeRemaining = purchasedDate.difference(now).inDays;
    return timeRemaining;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,

        // title: Text(
        //   "شراء المحاضرة",
        //   //textAlign: TextAlign.right,
        //   style: Theme.of(context)
        //       .textTheme
        //       .bodyMedium!
        //       .copyWith(fontWeight: FontWeight.bold),
        // ),
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
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      !widget.isPurchased
                          ? widget.routeArg['price']
                          : _getTimeRemaining(widget.routeArg['purchased_date'])
                              .toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(width: 5),
                    Text(
                      !widget.isPurchased
                          ? ': سعر المحاضرة '
                          : 'متبقي من الوقت',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //! purchase bottom
              MaterialButton(
                onPressed: () {
                  if (!widget.isPurchased) {
                    _displayTextInputDialog(context);
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 45),
              //! video section name
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  'المحاضرات',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 127, 127, 127)),
                ),
              ),
              SizedBox(height: 20),
              //! videos
              SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: widget.routeArg['video_url']!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              widget.isPurchased
                                  ? Navigator.pushNamed(
                                      context, AppRoutes.videoPlayerPage,
                                      arguments:
                                          widget.routeArg['video_url']![index])
                                  : null;
                            },
                            title: Text(
                              'part ${index + 1}',
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontFamily: 'roboto',
                                  ),
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
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
                          Divider(
                            height: 5,
                            color: Colors.black,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
