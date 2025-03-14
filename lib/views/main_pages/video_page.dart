import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/data/firebase_retrieve.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';
import 'package:mr_samy_elmalah/widgets/videos_card.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  Future<List<Map<String, dynamic>>> _getMyVideos() async =>
      await FirebaseRetrieve().getMyVideos();
  Future<List?> _getVideos() async {
    var data = await _getMyVideos();
    List videosData = await FirebaseRetrieve().getMyVideosFromList(data);
    for (int i = 0; i < videosData.length; i++) {
      videosData[i].addAll({'purchased_data': data[i]['purchased_data']});
    }
    return videosData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getVideos(),
      builder: (context, snapshot) {
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
              itemBuilder: (context, index) => MyVideosCard(
                section: '',
                isPurchased: true,
                myVideos: snapshot.data![index],
                // mainMyVideosData: s,
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return LottieError();
        }
        return LottieNoData();
      },
    );
  }
}
