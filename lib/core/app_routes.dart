import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/views/auth_pages/log_in_page.dart';
import 'package:mr_samy_elmalah/views/auth_pages/sign_up_page.dart';
import 'package:mr_samy_elmalah/views/home_page_content/department_videos_page.dart';
import 'package:mr_samy_elmalah/views/home_page_content/second_secondary.dart';

import 'package:mr_samy_elmalah/views/home_page_content/third_secondary.dart';
import 'package:mr_samy_elmalah/views/home_pages/ai_page.dart';
import 'package:mr_samy_elmalah/views/home_pages/home_page.dart';
import 'package:mr_samy_elmalah/views/home_pages/main_page.dart';
import 'package:mr_samy_elmalah/views/home_pages/video_page.dart';

class AppRoutes {
  static const String home = '/homePage';
  static const String logIn = '/logIn';
  static const String signUp = '/signUp';
  static const String videoPage = '/videoPage';
  static const String aiPage = '/aiPage';
  static const String secondSecondary = '/secondSecondary';
  static const String thirdSecondary = '/thirdSecondary';
  static const String departmentsVideosPage = '/departmentsVideosPage';
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
        return MaterialPageRoute(builder: (context) => MainPage());
      // videoPage page
      case videoPage:
        return MaterialPageRoute(builder: (context) => VideoPage());
      // aiPage page
      case aiPage:
        return MaterialPageRoute(builder: (context) => AiPage());
      // firstSecondary page
      case secondSecondary:
        return MaterialPageRoute(builder: (context) => SecondSecondary());
      // thirdSecondary page
      case thirdSecondary:
        return MaterialPageRoute(builder: (context) => ThirdSecondary());
      // departments page
      case departmentsVideosPage:
        return MaterialPageRoute(builder: (context) => DepartmentVideos());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
