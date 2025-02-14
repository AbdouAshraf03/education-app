import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/views/auth_pages/log_in_page.dart';
import 'package:mr_samy_elmalah/views/auth_pages/sign_up_page.dart';
import 'package:mr_samy_elmalah/views/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String logIn = '/logIn';
  static const String signUp = '/signUp';
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

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
