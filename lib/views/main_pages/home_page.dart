import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/core/app_assets.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/views/home_page_content/widget/secondray_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            //

            SecondaryCard(
                title: 'الصف الاول الثانوي',
                routeName: AppRoutes.secondary,
                imageUrl: ImageAppAssets.firstYear),
            SecondaryCard(
                title: 'الصف الثاني الثانوي',
                routeName: AppRoutes.secondary,
                imageUrl: ImageAppAssets.secondYear),
            SecondaryCard(
              title: 'الصف الثالث الثانوي',
              routeName: AppRoutes.secondary,
              imageUrl: ImageAppAssets.thirdYear,
            ),

            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
