import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/views/home_page_content/widget/departments_card.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class Secondary extends StatelessWidget {
  Secondary({super.key, this.secondaryTitle});

  final secondaryTitle;

  String getSecondaryTitle() => switch (secondaryTitle) {
        'الصف الاول الثانوي' => "1st_secondary",
        'الصف الثاني الثانوي' => "2nd_secondary",
        'الصف الثالث الثانوي' => "3rd_secondary",
        _ => "null"
      };
  List<String> sectionsTitles = [];
  List<String> sectionsImagesUrls = [];
  Future<void> _getSections() async {
    await Future.delayed(const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> images = List.generate(
      sectionsTitles.length,
      (index) => DepartmentsCard(
        title: sectionsTitles[index],
        imageUrl: sectionsImagesUrls[index],
      ),
    );
    return FutureBuilder(
        future: _getSections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                  Icon(Iconsax.book_copy,
                      color: Theme.of(context).primaryColor),
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
              body: const Center(
                child: LottieLoader(),
              ),
            );
          }
          if (snapshot.hasData) {
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
                  Icon(Iconsax.book_copy,
                      color: Theme.of(context).primaryColor),
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
                          titles: sectionsTitles, // required
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
                                arguments: sectionsTitles[index]);

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
            body: const Center(
              child: Text('Error'),
            ),
          );
        });
  }
}
