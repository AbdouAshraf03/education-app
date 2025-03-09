import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/views/auth_pages/log_in_page.dart';
import 'package:mr_samy_elmalah/views/auth_pages/sign_up_page.dart';
import 'package:mr_samy_elmalah/views/home_page_content/department_videos_page.dart';
import 'package:mr_samy_elmalah/views/home_page_content/secondary.dart';
import 'package:mr_samy_elmalah/views/main_pages/ai_page.dart';
import 'package:mr_samy_elmalah/views/main_pages/home_page.dart';
import 'package:mr_samy_elmalah/views/main_pages/main_page.dart';
import 'package:mr_samy_elmalah/views/main_pages/video_page.dart';
import 'package:mr_samy_elmalah/views/profile_page/profile_page.dart';
import 'package:mr_samy_elmalah/views/purchase_and_video/purchase_page.dart';
import 'package:mr_samy_elmalah/views/video_player/video_player_page.dart';

class AppRoutes {
  static const String home = '/homePage';
  static const String logIn = '/logIn';
  static const String signUp = '/signUp';
  static const String videoPage = '/videoPage';
  static const String aiPage = '/aiPage';
  static const String secondary = '/Secondary';
  static const String departmentsVideosPage = '/departmentsVideosPage';
  static const String purchasePage = '/purchasePage';
  static const String videoPlayerPage = '/videoPlayerPage';
  static const String profilePage = '/profilePage';
  static const String mainPage = '/';
  // static const String departments = '/departments';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // (/) => home page
      case home:
        return MaterialPageRoute(builder: (context) => HomePage());
      // log in page
      case logIn:
        return MaterialPageRoute(builder: (context) => LogInPage());
      // sign up page
      case signUp:
        return MaterialPageRoute(builder: (context) => SignUpPage());
      // main page
      case mainPage:
        final index = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          builder: (context) => MainPage(
            index: index,
          ),
        );
      // videoPage page
      case videoPage:
        return MaterialPageRoute(builder: (context) => VideoPage());
      // aiPage page
      case aiPage:
        return MaterialPageRoute(builder: (context) => AiPage());
      // firstSecondary page

      case secondary:
        String secondaryTitle = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => Secondary(
                  secondaryTitle: secondaryTitle,
                ));
      // departments page
      case departmentsVideosPage:
        final routeArg = settings.arguments as Map<String, String>;
        final title = routeArg['title'];
        final graduate = routeArg['graduate'];
        return MaterialPageRoute(
          builder: (context) => DepartmentVideos(
            title: title!,
            graduate: graduate!,
          ),
        );
      // PurchasePage
      case purchasePage:
        final routeArg = settings.arguments as Map<String, dynamic>;
        final isPurchased = routeArg['isPurchased'];
        final section = routeArg['section'];
        return MaterialPageRoute(
            builder: (context) => PurchasePage(
                  routeArg: routeArg,
                  isPurchased: isPurchased,
                ));
      // PurchasePage
      case profilePage:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      // videoPlayerPage
      case videoPlayerPage:
        final Uri videoUrl = Uri.parse(settings.arguments as String);
        return MaterialPageRoute(
            builder: (context) => VideoPlayerPage(
                  videoUrl: videoUrl,
                ));
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
