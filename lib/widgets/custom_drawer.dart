import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/data/firebase_auth_service.dart';
import 'package:mr_samy_elmalah/data/firebase_retrieve.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  Future<List<String>?> _getuser() async =>
      await FirebaseRetrieve().getUserEmailAndName();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(15))),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder(
                future: _getuser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: LottieLoader(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const Text('No data available');
                    // print(snapshot.data![1]);
                  } else {
                    return UserAccountsDrawerHeader(
                      accountName: Text(snapshot.data![1],
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                      accountEmail: Text(
                        snapshot.data![0],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      // currentAccountPicture: CircleAvatar(
                      //     // backgroundImage: NetworkImage(_imageurl == null
                      //     //     ? 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSVqJm3fXSX67mLXUTYYaUqC_vGQsZtL3G8ickhGeuCVkWNWpbq'
                      //     //     : _imageurl!), // Replace with your image link
                      //     ),
                      decoration: const BoxDecoration(
                          // image: DecorationImage(
                          //   image: NetworkImage(
                          //       'https://media.istockphoto.com/id/525242101/vector/math-background.jpg?s=612x612&w=0&k=20&c=pxDSP3dYr2VfWWdcNfCmQ_jwhTGQb4FUTZzU54c1Djk='), // Replace with your background image link
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                    );
                  }
                  return SizedBox();
                }),

            //! profile
            ListTile(
              trailing: Icon(
                Iconsax.profile_circle,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              title: Text("الملف الشخصي",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
              // leading: ,
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.profilePage);
              },
            ),

            //! 2st
            ListTile(
              trailing: Icon(
                Iconsax.book_1_copy,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              title: Text("الصف الثاني الثانوي",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
              // leading: ,
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.secondary,
                    arguments: "الصف الثاني الثانوي");
              },
            ),
            //! 3st
            ListTile(
              trailing: Icon(
                Iconsax.book_1_copy,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              title: Text("الصف الثالث الثانوي",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
              // leading: ,
              onTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.secondary,
                    arguments: "الصف الثالث الثانوي");
              },
            ),
            //! Home
            ListTile(
              trailing: Icon(
                Iconsax.home_1_copy,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              title: Text("الرئيسية",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
              // leading: ,
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.mainPage,
                    arguments: 0);
              },
            ),
            //! AI
            ListTile(
              trailing: Icon(
                Iconsax.command_copy,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              title: Text("AI",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
              // leading: ,
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.mainPage,
                    arguments: 1);
              },
            ),
            //! my videos
            ListTile(
              trailing: Icon(
                Iconsax.video_play_copy,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              title: Text("محاضراتي",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
              // leading: ,
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.mainPage,
                    arguments: 2);
              },
            ),
            // ListTile(
            //   trailing: Icon(
            //     Icons.nightlight_round,
            //     color: Theme.of(context).primaryIconTheme.color,
            //   ),
            //   //leading:
            //   title: Text("الوضع الداكن",
            //       textAlign: TextAlign.right,
            //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //             fontSize: 14,
            //             fontWeight: FontWeight.bold,
            //           )),
            //   onTap: () {},
            // ),
            Divider(
              color: Theme.of(context).primaryIconTheme.color,
            ),
            ListTile(
              trailing: Icon(
                Iconsax.logout,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              //leading: ,
              title: Text(
                "تسجيل الخروج",
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onTap: () {
                FirebaseAuthService().signOut().then((value) {
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, AppRoutes.logIn);
                  }
                });
              },
            ),

            // const Expanded(
            //   // Takes all remaining space
            //   child: SizedBox.shrink(), // Empty space to push content down
            // ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Version",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
