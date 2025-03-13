import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';

import 'package:mr_samy_elmalah/views/main_pages/ai_page.dart';
import 'package:mr_samy_elmalah/views/main_pages/home_page.dart';
import 'package:mr_samy_elmalah/views/main_pages/video_page.dart';
import 'package:mr_samy_elmalah/widgets/bottom_navigation_bar.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:mr_samy_elmalah/widgets/light_dark_switch.dart';

class AppBarConfig {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final BuildContext context;

  AppBarConfig(
      {required this.title, this.actions, this.leading, required this.context});
}

class HomeViewModel {
  final BuildContext context;
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  final List<Widget> pages = [
    const HomePage(),
    AiPage(),
    const VideoPage(),
  ];
  HomeViewModel(this.context);
  List<AppBarConfig> get appBarConfigs => [
        AppBarConfig(
          context: context,
          leading: _buildHomeLeading(),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.searchPage);
                },
                icon: Icon(
                  Iconsax.search_normal_1_copy,
                  color: Theme.of(context).primaryIconTheme.color,
                )),
            AnimatedMenuButton(),
          ],
          title: 'الصفحه الرئيسية',
        ),
        AppBarConfig(
          context: context,
          title: 'AI',
          actions: [AnimatedMenuButton()],
        ),
        AppBarConfig(
          context: context,
          title: 'محاضراتي',
          actions: [AnimatedMenuButton()],
        ),
      ];

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void dispose() {
    currentIndex.dispose();
  }

  static Widget _buildHomeLeading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 18),
          LightDarkSwitchApp(),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final HomeViewModel _viewModel;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _viewModel = HomeViewModel(context);

    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel.updateIndex(widget.index);
    return ValueListenableBuilder<int>(
        valueListenable: _viewModel.currentIndex,
        builder: (context, index, _) {
          final config = _viewModel.appBarConfigs[index];
          return Scaffold(
            key: _scaffoldKey,
            endDrawer: const MyDrawer(),
            extendBody: true,
            appBar: AppBar(
              toolbarHeight: 65,
              leadingWidth: 80,
              automaticallyImplyLeading: false,
              leading: config.leading,
              actions: config.actions,
              centerTitle: true,
              title: Text(config.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
            ),
            body: _viewModel.pages[index],
            bottomNavigationBar: MyBottomNavigationBar(viewModel: _viewModel),
          );
        });
  }
}
