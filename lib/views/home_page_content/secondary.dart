import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/data/firebase_retrieve.dart';
import 'package:mr_samy_elmalah/views/home_page_content/widget/departments_card.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class Secondary extends StatelessWidget {
  Secondary({super.key, required this.secondaryTitle});

  final String secondaryTitle;

  String getSecondaryTitle() {
    String title = switch (secondaryTitle) {
      'الصف الاول الثانوي' => "1st_secondary",
      'الصف الثاني الثانوي' => "2nd_secondary",
      'الصف الثالث الثانوي' => "3rd_secondary",
      _ => "Null",
    };
    //  print("Secondary Title: $title"); // Debugging statement
    return title;
  }

  // List<String> sectionsTitles = [];
  final List<String> sectionsImagesUrls = List.generate(
    5,
    (index) =>
        'https://img.freepik.com/free-photo/cosmic-background-white-black-laser-lights_181624-27720.jpg?t=st=1740695009~exp=1740698609~hmac=daa65ecf700e0e9d34e4122bf32d2179db285bb2bf40cabb640935fb2feda4de&w=1380',
  );

  Future<List<String>?> _getSections() async {
    // print(
    //     "Calling getSectionsNames with title: ${getSecondaryTitle()}"); // Debugging statement
    List? sections =
        await FirebaseRetrieve().getSectionsNames(getSecondaryTitle());
    //print("Sections: $sections"); // Debugging statement
    return sections?.cast<String>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getSections(),
      builder: (context, snapshot) {
        // print(
        //     "FutureBuilder called with snapshot: ${snapshot.connectionState}"); // Debugging statement
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
              child: LottieLoader(),
            ),
          );
        }

        if (snapshot.hasData) {
          print("Snapshot has data: ${snapshot.data}"); // Debugging statement
          final List<Widget> images = List.generate(
            snapshot.data!.length,
            (index) => DepartmentsCard(
              title: snapshot.data![index],
              imageUrl: sectionsImagesUrls[index],
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
                      titles: snapshot.data as List<String>, // required
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
                          context,
                          AppRoutes.departmentsVideosPage,
                          arguments: {
                            'title': snapshot.data![index],
                            'graduate': getSecondaryTitle()
                          },
                        );

                        // optional
                      },
                      initialPage: 2, // optional
                      align: ALIGN.CENTER, // optional
                      physics: ClampingScrollPhysics(), // optional
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          Scaffold(
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
            body: LottieError(),
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
          body: LottieNoData(),
        );
      },
    );
  }
}
