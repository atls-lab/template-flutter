import 'package:flutter/material.dart';

import 'circle_progressbar_props.dart';

class CircleProgressBar extends StatelessWidget {
  final CircleProgressBarProps props;

  const CircleProgressBar({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: SizedBox(
            width: props.width,
            height: props.height,
            child: CircularProgressIndicator(
              value: props.value,
              semanticsValue: props.value.toString(),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              props.textTop,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface),
            ),
            Text(
              props.textBottom,
              style: Theme.of(context).textTheme.bodySmall!,
            ),
          ],
        )
      ],
    );
  }
}
