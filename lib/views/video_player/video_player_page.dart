// import 'package:flutter/material.dart';
// import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
// import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';

// class VideoPlayerPage extends StatelessWidget {
//   const VideoPlayerPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       endDrawer: const MyDrawer(),
//       appBar: AppBar(
//         shadowColor: Colors.transparent,
//         centerTitle: false,

//         // title: Text(
//         //   "شراء المحاضرة",
//         //   //textAlign: TextAlign.right,
//         //   style: Theme.of(context)
//         //       .textTheme
//         //       .bodyMedium!
//         //       .copyWith(fontWeight: FontWeight.bold),
//         // ),
//         actions: [
//           Center(
//             child: Text(
//               "شراء المحاضرة",
//               // textAlign: TextAlign.center,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium!
//                   .copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(width: 20),
//           Icon(Icons.play_lesson_rounded,
//               color: Theme.of(context).primaryColor),
//           SizedBox(width: 20),
//           AnimatedMenuButton()
//         ],
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: Theme.of(context).primaryIconTheme.color,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:lottie/lottie.dart';

class VideoPlayerPage extends StatefulWidget {
  final Uri videoUrl;

  const VideoPlayerPage({
    super.key,
    required this.videoUrl,
  });

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(widget.videoUrl);
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.portraitDown
        ],
        allowedScreenSleep: false,
        showControls: true,
        customControls: const MaterialControls(),
        fullScreenByDefault: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );

      setState(() {});
    } catch (e) {
      print('Error initializing player: $e');
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  // void _toggleFullScreen() {
  //   setState(() {
  //     _isFullScreen = !_isFullScreen;
  //   });
  //   if (_isFullScreen) {
  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  //   } else {
  //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _isFullScreen ? null : const MyDrawer(),
      appBar: _isFullScreen
          ? null
          : AppBar(
              shadowColor: Colors.transparent,
              centerTitle: false,
              actions: [
                Center(
                  child: Text(
                    "المحاضرة",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20),
                Icon(Iconsax.play_circle_copy,
                    color: Theme.of(context).primaryColor),
                const SizedBox(width: 20),
                const AnimatedMenuButton(),
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 0,
                maxHeight: constraints.maxHeight,
              ),
              child: _buildVideoContent(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVideoContent() {
    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 0),
          child: AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio > 0
                ? _videoPlayerController.value.aspectRatio
                : 16 / 9, // Fallback ratio
            child: Chewie(controller: _chewieController!),
          ),
        ),
      );
    }
    return Center(
      child: Lottie.asset(
        'assets/lottie/Animation - 1740337284424.json',
        height: 130.0,
        width: 130.0,
      ), // Replace with your loading animation(),
    );
  }
}
