import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:flutter/material.dart';
import 'package:mr_samy_elmalah/core/app_theme.dart';

class LightDarkSwitchApp extends StatefulWidget {
  const LightDarkSwitchApp({super.key});

  @override
  State<LightDarkSwitchApp> createState() => _LightDarkSwitchAppState();
}

class _LightDarkSwitchAppState extends State<LightDarkSwitchApp> {
  bool isDark = false;
  @override
  void initState() {
    if (themeNotifier.value == ThemeMode.dark) {
      setState(() {
        isDark = true;
      });
    } else {
      setState(() {
        isDark = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DayNightSwitch(
        // duration: Duration(milliseconds: 800),
        initiallyDark: isDark,
        size: 28,
        duration: Duration(milliseconds: 500),
        onChange: (value) {
          setState(() {
            if (value) {
              themeNotifier.value = ThemeMode.dark;
              isDark = true;
            } else {
              themeNotifier.value = ThemeMode.light;
              isDark = false;
            }
          });
        });
  }
}
