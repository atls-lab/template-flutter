import 'package:flutter/material.dart';

import 'button_props.dart';

class ButtonStyles {
  final ThemeData theme;
  final VoidCallback? onPressed;
  final bool fill;
  final ButtonVariant variant;
  final bool small;

  ButtonStyles({
    required this.small,
    required this.theme,
    required this.onPressed,
    required this.fill,
    required this.variant,
  });

  Color get contentColor {
    if (onPressed == null) {
      return theme.colorScheme.surface;
    } else {
      if (variant == ButtonVariant.primary) {
        return theme.colorScheme.onPrimary;
      } else {
        return theme.colorScheme.inversePrimary;
      }
    }
  }

  BorderSide get sideStyle {
    if (variant == ButtonVariant.primary || onPressed == null) {
      return const BorderSide();
    }

    return BorderSide(width: 1, color: theme.colorScheme.outlineVariant);
  }

  TextStyle get baseStyle {
    if (!small) {
      return theme.textTheme.labelLarge!
          .copyWith(color: contentColor, fontWeight: FontWeight.w500);
    }
    return theme.textTheme.titleLarge!
        .copyWith(color: contentColor, fontWeight: FontWeight.w400);
  }

  TextStyle get contentStyle => const TextStyle(fontWeight: FontWeight.bold);

  ButtonStyle get shapeStyle => ButtonStyle(
        alignment: Alignment.center,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: small ? 16 : 24,
            vertical: small ? 0 : 15,
          ),
        ),
      );

  ButtonStyle get variantStyle => ButtonStyle(
      side: MaterialStatePropertyAll(sideStyle),
      backgroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return theme.colorScheme.tertiaryContainer;
        }
        if (variant == ButtonVariant.primary) {
          return theme.colorScheme.primary;
        }
        if (variant == ButtonVariant.secondary) {
          return theme.colorScheme.tertiaryContainer;
        }
        return theme.colorScheme.onPrimary;
      }),
      overlayColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (variant == ButtonVariant.primary) {
          return theme.colorScheme.surface;
        } else {
          return theme.colorScheme.primary;
        }
      }),
      foregroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return theme.colorScheme.surface;
        }

        if (variant == ButtonVariant.primary) {
          return theme.colorScheme.onPrimary;
        }
        if (variant == ButtonVariant.secondary) {
          return theme.colorScheme.primary;
        }

        return theme.colorScheme.primary;
      }));
}
