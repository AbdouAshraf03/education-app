import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/widgets/videos_card.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 1.0,
      ),
      child: ListView.builder(
          itemCount: 3, itemBuilder: (context, index) => MyVideosCard()),
    );
  }
}
