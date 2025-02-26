import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/views/home_page_content/widget/departments_card.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class Secondary extends StatelessWidget {
  Secondary({super.key});
  final List<String> titles = [
    "ستاتيكا",
    "ديناميكا",
    "تفاضل و تكامل",
    "جبر",
    "هندسه فراغيه",
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> images = List.generate(
      5,
      (index) => DepartmentsCard(
        title: titles[index],
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoJl_vyLvjj1TkeCFiEgme8swZ98reFlhPIQ&s',
      ),
    );
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        centerTitle: false,
        actions: [
          Center(
            child: Text(
              "الاقسام",
              // textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20),
          Icon(Iconsax.book_copy, color: Theme.of(context).primaryColor),
          SizedBox(width: 20),
          AnimatedMenuButton()
        ],
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            AppRoutes.mainPage,
            arguments: 0,
          ),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: VerticalCardPager(
                  width: MediaQuery.of(context).size.width - 40,
                  titles: titles, // required
                  images: images, // required
                  textStyle: TextStyle(
                    // decorationStyle: TextDecorationStyle.wavy,
                    // decorationThickness: 20,
                    fontFamily: 'vip_hala',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(-1.0, -1.0),
                      ),
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(1.0, -1.0),
                      ),
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(-1.0, 1.0),
                      ),
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                    //fontWeight: FontWeight.bold,
                  ), // optional
                  onPageChanged: (page) {
                    // optional
                  },
                  onSelectedItem: (index) {
                    Navigator.pushNamed(
                        context, AppRoutes.departmentsVideosPage,
                        arguments: titles[index]);

                    // optional
                  },
                  initialPage: 2, // optional
                  align: ALIGN.CENTER, // optional
                  physics: ClampingScrollPhysics() // optional
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
