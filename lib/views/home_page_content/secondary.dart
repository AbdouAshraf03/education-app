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
  const Secondary({super.key, required this.secondaryTitle});

  final String secondaryTitle;

  String getSecondaryTitle() {
    String title = switch (secondaryTitle) {
      'الصف الاول الثانوي' => "1st_secondary",
      'الصف الثاني الثانوي' => "2nd_secondary",
      'الصف الثالث الثانوي' => "3rd_secondary",
      _ => "Null",
    };
    return title;
  }

  Future<Map<String, dynamic>?> _getSections() async {
    // print(
    //     "Calling getSectionsNames with title: ${getSecondaryTitle()}"); // Debugging statement
    Map<String, dynamic>? sections =
        await FirebaseRetrieve().getSectionsNames(getSecondaryTitle());
    //print("Sections: $sections"); // Debugging statement
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getSections(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildScafold(context, LottieLoader());
        }
        if (snapshot.hasData) {
          final List<Widget> images = List.generate(
            snapshot.data!.length,
            (index) => DepartmentsCard(
              title: snapshot.data!.keys.toList()[index],
              imageUrl: snapshot.data![snapshot.data!.keys.toList()[index]]
                  ['image_url'],
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
                      titles: snapshot.data!.keys.toList(), // required
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
                            'title':
                                snapshot.data!.keys.toList()[index].toString(),
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
          return _buildScafold(context, LottieError());
        }
        return _buildScafold(context, LottieNoData());
      },
    );
  }

  Widget _buildScafold(BuildContext context, lotti) {
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
      body: lotti,
    );
  }
}
