import 'package:flutter/material.dart';

import 'button_props.dart';
import 'button_styles.dart';

class Button extends StatelessWidget {
  final ButtonProps props;

  const Button({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    final styles = ButtonStyles(
      theme: Theme.of(context),
      onPressed: props.onPressed,
      fill: props.fill,
      variant: props.variant,
      small: props.small,
    );

    if (props.icon != null) {
      List<Widget> content() {
        if (props.text != '') {
          return [
            Text(
              props.text,
              style: styles.baseStyle.merge(styles.contentStyle),
            ),
            Padding(
              padding: props.iconPlacement == IconPlacement.left
                  ? const EdgeInsets.only(right: 8)
                  : const EdgeInsets.only(left: 8),
              child: props.icon,
            )
          ];
        } else {
          return [props.icon!];
        }
      }

      return Directionality(
        textDirection: props.iconPlacement == IconPlacement.left
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: SizedBox(
          width: props.fill ? double.infinity : null,
          child: ElevatedButton(
            onPressed: props.onPressed,
            style: styles.variantStyle.merge(styles.shapeStyle),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: content(),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: props.fill ? double.infinity : null,
      child: ElevatedButton(
        onPressed: props.onPressed,
        style: styles.variantStyle.merge(styles.shapeStyle),
        child: Text(
          props.text,
          style: styles.baseStyle.merge(styles.contentStyle),
        ),
      ),
    );
  }
}
