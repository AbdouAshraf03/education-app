import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

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
              "شراء المحاضرة",
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
      body: Center(child: Text("شراء المحاضرة")),
    );
  }
}
