import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ButtonVariant { primary, secondary, tertiary }

enum IconPlacement { left, right }

class ButtonProps {
  final String text;
  final VoidCallback? onPressed;
  final bool fill;
  final ButtonVariant variant;
  final SvgPicture? icon;
  final IconPlacement? iconPlacement;
  final bool small;

  ButtonProps({
    this.text = '',
    this.onPressed,
    this.fill = false,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.iconPlacement,
    this.small = false,
  });
}
