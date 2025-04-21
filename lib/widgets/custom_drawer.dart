import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_assets.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/data/firebase_auth_service.dart';
import 'package:mr_samy_elmalah/data/firebase_retrieve.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<List<String>?> _getuser() async =>
      await FirebaseRetrieve().getUserEmailAndName();

  String appVersion = 'Loading...';

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

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
                      child: SizedBox(
                          width: 80,
                          height: 80,
                          child: Center(child: LottieLoader())),
                    );
                  }
                  if (snapshot.hasError) {
                    return SizedBox(
                        width: 80, height: 80, child: const LottieError());
                  }
                  if (!snapshot.hasData) {
                    return SizedBox(
                        width: 80, height: 80, child: const LottieNoData());
                  } else {
                    return UserAccountsDrawerHeader(
                      accountName: Text(
                        snapshot.data![1],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'roboto',
                            ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          LogoAppAssets.logoNoPg,
                        ),
                      ),
                      accountEmail: Text(
                        snapshot.data![0],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'roboto',
                            ),
                      ),
                      decoration: const BoxDecoration(),
                    );
                  }
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
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.mainPage, arguments: 0);
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
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.mainPage, arguments: 1);
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
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.mainPage, arguments: 2);
              },
            ),
            //! my Wallet
            ListTile(
              trailing: Icon(
                Iconsax.wallet_1_copy,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              title: Text("محفظتي",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.mainPage, arguments: 3);
              },
            ),

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

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Version $appVersion",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo',
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
