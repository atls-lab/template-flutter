import 'package:flutter/material.dart';

import 'switcher_props.dart';

class Switcher extends StatefulWidget {
  final SwitcherProps props;

  const Switcher({super.key, required this.props});

  @override
  State<Switcher> createState() => _Switcher();
}

class _Switcher extends State<Switcher> {
  late bool active = widget.props.value;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(null);
      }
      return const Icon(null);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: active,
      thumbIcon: thumbIcon,
      onChanged: (bool val) {
        setState(() {
          active = val;
        });
        widget.props.onChange!(val);
      },
      inactiveThumbColor: Theme.of(context).colorScheme.inverseSurface,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}
