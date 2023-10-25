import 'package:flutter/material.dart';

import 'src/app_bar_theme.dart';
import 'src/bottom_navigation_bar_theme.dart';
import 'src/color_scheme.dart';
import 'src/elevated_button_theme.dart';
import 'src/icon_theme.dart';
import 'src/progressbar_theme.dart';
import 'src/slider_theme.dart';
import 'src/switch_theme.dart';
import 'src/text_theme.dart';

class AppTheme {
  AppTheme();

  static ThemeData themeData = ThemeData(
    textTheme: appTextTheme,
    colorScheme: appColorScheme,
    useMaterial3: true,
    elevatedButtonTheme: elevatedButtonThemeData,
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: navbarThemeData,
    sliderTheme: sliderThemeData,
    progressIndicatorTheme: progressIndicatorThemeData,
    switchTheme: switchThemeData,
    iconTheme: iconThemeData,
  );
}
