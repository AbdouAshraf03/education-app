import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/data/firebase_retrieve.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
import 'package:mr_samy_elmalah/widgets/videos_card.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});
  Future<List> _getVideos() async {
    List videosData;
    await FirebaseRetrieve().getMyVideos().then((value) async {
      videosData = await FirebaseRetrieve().getMyVideosFromList(value);
      //  print("Videos: $videosData");
      return videosData;
    });
    return ['Null'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getVideos(),
      builder: (context, snapshot) {
        print(
            "FutureBuilder called with snapshot: ${snapshot.connectionState}"); // Debugging statement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const Center(
              child: LottieLoader(),
            ),
          );
        }
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 1.0,
            ),
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => MyVideosCard()),
          );
        }
        print(
            "Snapshot has no data or error: ${snapshot.error}"); // Debugging statement
        return const Center(
          child: Text('Error', style: TextStyle(color: Colors.red)),
        );
      },
    );
  }
}
