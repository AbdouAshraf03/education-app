import 'package:flutter/material.dart';

class AppTheme {
  /// light mode
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.black,
    )),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  /// dark mode
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Color.fromARGB(136, 61, 61, 61),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(137, 30, 30, 30),
    ),
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.white,
    )),
    iconTheme: const IconThemeData(color: Colors.black),
  );
}

class CTheme extends ValueNotifier<ThemeMode> {
  CTheme() : super(ThemeMode.light);
  //ThemeMode currentThemeMode = ThemeMode.light;

  void themeModeChanger() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final CTheme themeNotifier = CTheme();
