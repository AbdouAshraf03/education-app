import 'package:flutter/material.dart';

class AppTheme {
  /// light mode
  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.lightBlue,
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        toolbarHeight: 65,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        backgroundColor: Colors.white,
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
      ),
      primaryIconTheme: IconThemeData(
        color: Colors.black,
      ));

  /// dark mode
  static ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.lightBlue,
      scaffoldBackgroundColor: Color.fromARGB(255, 37, 37, 37),
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        toolbarHeight: 65,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        backgroundColor: Color.fromARGB(255, 37, 37, 37),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 37, 37, 37),
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
      ),
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ));
/////////
}

class CTheme extends ValueNotifier<ThemeMode> {
  CTheme() : super(ThemeMode.light);
  //ThemeMode currentThemeMode = ThemeMode.light;

  void themeModeChanger() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    //print(value);
  }
}

final CTheme themeNotifier = CTheme();
