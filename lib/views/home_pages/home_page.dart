import 'package:flutter/material.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:mr_samy_elmalah/widgets/light_dark_switch.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: MyDrawer(),
      appBar: AppBar(
        toolbarHeight: 65,
        leadingWidth: 80,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 18,
              ),
              SizedBox(child: LightDarkSwitchApp()),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Iconsax.search_normal_1_copy)),
          AnimatedMenuButton()
        ],
        centerTitle: true,
        //backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        shadowColor: Theme.of(context).appBarTheme.shadowColor,
        //shape: Theme.of(context).appBarTheme.shape,
        title: Text('الصفحه الرئيسية',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
