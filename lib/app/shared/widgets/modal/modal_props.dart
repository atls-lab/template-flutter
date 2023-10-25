import 'package:flutter/material.dart';

enum TitleDirection { horizontal, vertical }

class ModalProps {
  final String title;
  final String? subTitle;
  final TitleDirection titleDirection;
  final Widget? titleIcon;
  final Widget child;

  const ModalProps(
      {required this.title,
      required this.child,
      this.titleIcon,
      this.subTitle,
      this.titleDirection = TitleDirection.horizontal});
}
