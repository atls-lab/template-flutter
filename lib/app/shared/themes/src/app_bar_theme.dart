import 'package:flutter/material.dart';

import 'color_scheme.dart';
import 'text_theme.dart';

AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: appColorScheme.onPrimary,
    iconTheme: IconThemeData(color: appColorScheme.surface),
    foregroundColor: appColorScheme.primary,
    centerTitle: true,
    titleTextStyle: appTextTheme.headlineSmall?.copyWith(
      color: appColorScheme.primary,
      fontWeight: FontWeight.w500,
    ));
