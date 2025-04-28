import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/data/firebase_retrieve.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
import 'package:mr_samy_elmalah/widgets/videos_card.dart';

class DepartmentVideos extends StatelessWidget {
  const DepartmentVideos({
    super.key,
    required this.title,
    required this.graduate,
  });
  final String title;
  final String graduate;
  Future<List<Map<String, dynamic>>?> _getVideos() async {
    return await FirebaseRetrieve().getVideos(graduate, title);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getVideos(),
      builder: (context, snapshot) {
        // Debugging statement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const Center(
              child: LottieLoader(),
            ),
          );
        }
        if (snapshot.hasData) {
          return _buildmain(
            context,
            ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => MyVideosCard(
                myVideos: snapshot.data![index],
                isPurchased: false,
                section: title,
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return _buildmain(context, LottieError());
        }
        return _buildmain(context, LottieNoData());
      },
    );
  }

  Widget _buildmain(BuildContext context, Widget mainWidget) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        centerTitle: false,
        shadowColor: Colors.transparent,
        actions: [
          Center(
            child: Text(
              title,
              // textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20),
          Icon(Iconsax.book_1_copy, color: Theme.of(context).primaryColor),
          SizedBox(width: 20),
          AnimatedMenuButton()
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(
            top: 1.0,
          ),
          child: mainWidget),
    );
  }
}
