import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/core/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          initialRoute: AppRoutes.logIn,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
