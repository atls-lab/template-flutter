import 'package:flutter/material.dart';

import '../../themes/src/colors.dart';

class StatRow extends StatelessWidget {
  final String text;
  final String value;
  final Widget? icon;

  const StatRow(
      {super.key, required this.text, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: theme.textTheme.bodyMedium!
              .copyWith(color: AppColors.slightlyGrey),
        ),
        const Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider())),
        Text(value, style: theme.textTheme.headlineSmall!),
        const SizedBox(width: 8),
        icon ?? const SizedBox.shrink(),
      ],
    );
  }
}
