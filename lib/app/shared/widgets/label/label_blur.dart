import 'package:flutter/material.dart';

import '../../themes/src/colors.dart';
import 'label_blur_props.dart';

class LabelBlur extends StatelessWidget {
  final LabelBlurProps props;

  const LabelBlur({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(
          top: 2.0, bottom: 2.0, left: 10.0, right: 8.0),
      decoration: ShapeDecoration(
          color: AppColors.toxicGreen.withOpacity(0.15),
          shape: StadiumBorder(
              side: BorderSide(
                width: 0.39,
                color: AppColors.white.withOpacity(0.1),
              )
          ),
          shadows: [
            BoxShadow(
              color: AppColors.toxicGreenAlt2.withOpacity(0.16),
              blurRadius: 10.908533096313477,
              blurStyle: BlurStyle.outer,
            ),
          ]
      ),
      child: Text(
        props.text,
        style: theme.textTheme.bodyMedium!.copyWith(color: AppColors
            .toxicGreen),
      ),
    );
  }
}