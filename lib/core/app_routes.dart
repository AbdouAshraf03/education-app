import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/views/home_page.dart';

class AppRoutes {
  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // (/) => home page
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      //
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        );
    }
  }
}
