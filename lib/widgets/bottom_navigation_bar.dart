import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:mr_samy_elmalah/views/main_pages/main_page.dart';

// ignore: must_be_immutable
class MyBottomNavigationBar extends StatelessWidget {
  final HomeViewModel viewModel;

  const MyBottomNavigationBar({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: viewModel.currentIndex,
      builder: (context, index, _) => CrystalNavigationBar(
        borderRadius: 20,
        currentIndex: viewModel.currentIndex.value,
        onTap: (index) => viewModel.updateIndex(index),
        indicatorColor: Theme.of(context).primaryIconTheme.color,
        // enableFloatingNavBar: false
        outlineBorderColor: Theme.of(context).primaryIconTheme.color!,
        paddingR: EdgeInsets.symmetric(horizontal: 20),
        marginR: EdgeInsets.all(18),
        items: [
          CrystalNavigationBarItem(
            icon: Iconsax.home_1_copy,
            unselectedColor: Theme.of(context).primaryIconTheme.color,
          ),
          CrystalNavigationBarItem(
            icon: Iconsax.command_copy,
            unselectedColor: Theme.of(context).primaryIconTheme.color,
          ),
          CrystalNavigationBarItem(
            icon: Iconsax.video_play_copy,
            unselectedColor: Theme.of(context).primaryIconTheme.color,
          ),
          CrystalNavigationBarItem(
            icon: Iconsax.wallet_1_copy,
            unselectedColor: Theme.of(context).primaryIconTheme.color,
          ),
        ],
      ),
    );
  }
}

//   Widget _buildNavButton(BuildContext context, IconData icon, int index) {
//     return IconButton(
//       icon: Icon(icon),
//       color: widget.viewModel.currentIndex.value == index
//           ? Theme.of(context).colorScheme.primary
//           : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
//       onPressed: () => widget.viewModel.updateIndex(index),
//     );
//   }
// }
