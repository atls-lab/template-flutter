import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../switcher/switcher.dart';

class SettingsListElementProps {
  final String settingText;
  final SvgPicture icon;
  final Color? settingTextColor;
  final String? valueText;
  final VoidCallback? onPressed;
  final Switcher? switcher;

  SettingsListElementProps({
    required this.settingText,
    required this.icon,
    this.valueText,
    this.onPressed,
    this.settingTextColor,
    this.switcher,
  });
}
