import 'package:flutter/material.dart';

class AppIconProps {
  final double height;
  final double width;
  Color color;
  final String fileName;
  final BoxFit fit;

  AppIconProps({
    required this.fileName,
    this.height = 24,
    this.width = 24,
    this.fit = BoxFit.contain,
    this.color = Colors.white,
  });
}
