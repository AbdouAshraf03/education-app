import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/views/home_page_content/widget/secondray_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          //
          SecondaryCard(
            title: 'الصف الثاني الثانوي',
            routeName: AppRoutes.secondSecondary,
          ),
          SecondaryCard(
            title: 'الصف الثالث الثانوي',
            routeName: AppRoutes.thirdSecondary,
            imageUrl:
                'https://www.edutrapedia.com/resources/thumbs/article_photos/Noj7cPv62g-571.jpg_729x410.jpg',
          ),
          SizedBox(height: 70),
          // SizedBox(height: 20),
        ],
      ),
    );
  }
}
