import 'package:flutter/material.dart';

import 'notification_props.dart';

class NotificationStyles {
  final ThemeData theme;
  final NotificationType type;

  NotificationStyles({
    required this.theme,
    required this.type,
  });

  Color get typeColor {
    if (type == NotificationType.error) {
      return theme.colorScheme.error;
    }
    if (type == NotificationType.warning) {
      return theme.colorScheme.errorContainer;
    }
    return theme.colorScheme.primary;
  }

  BoxDecoration get shapeStyle => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        color: theme.colorScheme.tertiaryContainer,
      );

  TextStyle get headlineStyle =>
      theme.textTheme.bodyMedium!.copyWith(color: typeColor);

  TextStyle get contentStyle => theme.textTheme.bodySmall!
      .copyWith(color: theme.colorScheme.onInverseSurface);
}
