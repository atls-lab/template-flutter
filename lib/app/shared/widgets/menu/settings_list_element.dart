import 'package:flutter/material.dart';

import '../../../../generated/assets.gen.dart';
import '../../themes/src/colors.dart';
import 'settings_list_element_props.dart';

class SettingsListElement extends StatelessWidget {
  final SettingsListElementProps props;

  const SettingsListElement({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    Widget action;
    final double height = MediaQuery.of(context).size.height * 0.07;
    final ThemeData theme = Theme.of(context);

    if (props.switcher == null) {
      action = Assets.icons.solarAltArrowRightLineDuotone.svg(
          colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surface, BlendMode.srcIn));
    } else {
      action = props.switcher!;
    }

    return InkWell(
      onTap: (props.onPressed == null) ? null : props.onPressed,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  props.icon,
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      props.settingText,
                      style: (props.settingTextColor == null)
                          ? Theme.of(context).textTheme.bodySmall
                          : Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: props.settingTextColor),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (props.valueText != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        props.valueText!,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: AppColors.mildlyGrey),
                      ),
                    ),
                  action,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
