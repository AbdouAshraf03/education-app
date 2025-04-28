import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/core/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mr_samy_elmalah/data/security.dart';
import 'package:mr_samy_elmalah/views/auth_pages/log_in_page.dart';
import 'package:mr_samy_elmalah/views/main_pages/main_page.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: AppRoutes.mainPage,
      onGenerateRoute: AppRoutes.generateRoute,
      home: AuthWrapper(),
      themeMode: themeNotifier.value, // Use the current theme mode
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: themeNotifier,
          builder: (context, child) {
            return Theme(
              data: themeNotifier.value == ThemeMode.dark
                  ? AppTheme.darkTheme
                  : AppTheme.lightTheme,
              child: child!,
            );
          },
          child: child,
        );
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  void _showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: message,
      btnOkOnPress: () => exit(0),
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
    ).show();
  }

  void _securtyCheck() async {
    bool isRooted = await Security.rootedDevice();
    bool isDeveloperMode = await Security.developerModeDevice();
    if (isRooted && mounted) {
      _showErrorDialog(context, 'You are rooted, please unroot your phone.');
    }
    if (isDeveloperMode) {
      if (context.mounted) {
        if (isDeveloperMode && mounted) {
          _showErrorDialog(
              context, 'You are in developer mode, please disable it.');
        }
      }
    }
  }

  @override
  void initState() {
    _securtyCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LottieLoader());
        }
        if (snapshot.hasData && snapshot.data!.emailVerified) {
          return const MainPage(index: 0);
        }
        return LogInPage();
      },
    );
  }
}
