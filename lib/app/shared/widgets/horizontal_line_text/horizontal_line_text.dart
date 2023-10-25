import 'package:flutter/material.dart';

class HorizontalLineTextProps {
  final String text;
  final TextStyle? style;

  HorizontalLineTextProps({
    required this.text,
    this.style,
  });
}

class HorizontalLineText extends StatelessWidget {
  final HorizontalLineTextProps props;

  const HorizontalLineText({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Divider(),
          ),
        ),
        Text(
          props.text,
          textAlign: TextAlign.center,
          style: props.style ??
              Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.inverseSurface),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Divider(),
          ),
        ),
      ],
    );
  }
}
