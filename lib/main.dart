import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/core/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
