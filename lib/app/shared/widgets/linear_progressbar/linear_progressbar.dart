import 'package:flutter/material.dart';

import 'linear_progressbar_props.dart';

/// Progress bar.
///
/// If [value == null], will play infinite animation.
class LinearProgressBar extends StatelessWidget {
  final LinearProgressBarProps props;

  const LinearProgressBar({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: props.width,
      height: props.height,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: LinearProgressIndicator(
          value: props.value,
          semanticsValue: props.value.toString(),
          color: Theme.of(context).colorScheme.onPrimary,
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
