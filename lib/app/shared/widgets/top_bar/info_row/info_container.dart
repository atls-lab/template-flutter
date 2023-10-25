import 'package:flutter/material.dart';

import '../../../themes/src/colors.dart';

class InfoContainer extends StatelessWidget {
  final Widget icon;
  final String value;
  final String label;

  const InfoContainer(
      {super.key,
      required this.icon,
      required this.value,
      required this.label});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size currentSize = MediaQuery.of(context).size;

    final double widthOfContainer = currentSize.width * 0.25;
    final double heightOfContainer = currentSize.width * 0.1;

    return Stack(children: [
      Positioned(
          left: widthOfContainer * 0.33,
          top: heightOfContainer * 0.8,
          child: Text(label,
              style: theme.textTheme.labelMedium
                  ?.copyWith(color: AppColors.grey))),
      Container(
          width: widthOfContainer,
          height: heightOfContainer,
          margin: const EdgeInsets.only(bottom: 3),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border(
                  top: BorderSide(
                    width: 1,
                    color: theme.colorScheme.surface,
                  ),
                  left: BorderSide(
                    width: 1,
                    color: theme.colorScheme.surface,
                  ),
                  bottom: BorderSide(
                    width: 0,
                    color: theme.colorScheme.surface,
                  ),
                  right: BorderSide(
                    width: 1,
                    color: theme.colorScheme.surface,
                  ))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            icon,
            Text(
              value,
              style: theme.textTheme.bodySmall!
                  .copyWith(color: AppColors.slightlyGrey),
            )
          ])),
    ]);
  }
}
