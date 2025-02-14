import 'package:flutter/material.dart';

class AppTheme {
  /// light mode
  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.lightBlue,
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.lightBlue,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
        fontFamily: 'ge_ss',
        fontSize: 18,
        color: Colors.black,
      )),
      iconTheme: const IconThemeData(color: Colors.white),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color.fromARGB(255, 28, 113, 194),
      ));

  /// dark mode
  static ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.lightBlue,
      scaffoldBackgroundColor: Color.fromARGB(136, 61, 61, 61),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.lightBlue,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(137, 30, 30, 30),
      ),
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
        fontFamily: 'ge_ss',
        fontSize: 18,
        color: Colors.white,
      )),
      iconTheme: const IconThemeData(color: Colors.black),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color.fromARGB(255, 28, 113, 194),
      ));
}

class CTheme extends ValueNotifier<ThemeMode> {
  CTheme() : super(ThemeMode.light);
  //ThemeMode currentThemeMode = ThemeMode.light;

  void themeModeChanger() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final CTheme themeNotifier = CTheme();
