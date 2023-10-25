import 'package:flutter/material.dart';

import '../../../../forks/input-border-decoration/input_border.dart';

class InputStyles {
  final ThemeData theme;

  InputStyles({required this.theme});

  TextStyle get baseStyle => theme.textTheme.bodySmall!;

  TextStyle get contentStyle => theme.textTheme.bodySmall!;

  TextStyle get labelStyle =>
      theme.textTheme.bodySmall!.copyWith(color:
      theme.colorScheme.inverseSurface);

  final CustomOutlineInputBorder defaultBorder = const CustomOutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)));

  InputDecoration get shapeStyle =>
      InputDecoration(
        hintStyle: baseStyle,
        errorStyle: theme.textTheme.labelMedium!
            .copyWith(color: theme.colorScheme.error),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        hintMaxLines: 1,
        labelStyle: theme.textTheme.labelMedium!
            .copyWith(color: theme.colorScheme.inverseSurface),
        border: defaultBorder.copyWith(
          borderSide: BorderSide(color: theme.colorScheme.surface),
        ),
        disabledBorder: defaultBorder.copyWith(
          borderSide: BorderSide(color: theme.colorScheme.surface),
        ),
        enabledBorder: defaultBorder.copyWith(
          borderSide: BorderSide(color: theme.colorScheme.surface),
        ),
        focusedBorder: defaultBorder.copyWith(
          borderSide: BorderSide(color: theme.colorScheme.inverseSurface),
        ),
        errorBorder: defaultBorder.copyWith(
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
      );
}
