import 'package:flutter/material.dart';

import 'package:mr_samy_elmalah/views/home_pages/ai_page.dart';
import 'package:mr_samy_elmalah/views/home_pages/home_page.dart';
import 'package:mr_samy_elmalah/views/home_pages/video_page.dart';
import 'package:mr_samy_elmalah/widgets/bottom_navigation_bar.dart';

class HomeViewModel {
  final ValueNotifier<int> currentIndex = ValueNotifier(0);
  final List<Widget> pages = const [
    HomePage(),
    AiPage(),
    VideoPage(),
  ];

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void dispose() {
    currentIndex.dispose();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, //<------like this
      body: ValueListenableBuilder<int>(
        valueListenable: _viewModel.currentIndex,
        builder: (context, index, _) => _viewModel.pages[index],
      ),
      bottomNavigationBar: MyBottomNavigationBar(viewModel: _viewModel),
    );
  }
}
