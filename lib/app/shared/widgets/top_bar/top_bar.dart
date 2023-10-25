import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../generated/assets.gen.dart';

class TopBarProps {
  final String title;
  final double borderWidth;
  final Color? borderColor;

  TopBarProps({
    required this.title,
    this.borderWidth = 1,
    this.borderColor,
  });
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final TopBarProps props;

  const TopBar({super.key, required this.props});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border(
        bottom: BorderSide(
          color:
              props.borderColor ?? Theme.of(context).colorScheme.outlineVariant,
          width: props.borderWidth,
        ),
      ),
      title: Text(props.title),
      leading: IconButton(
        icon: Assets.icons.solarAltArrowLeftOutline.svg(
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.inverseSurface,
            BlendMode.srcIn,
          ),
        ),
        onPressed: () => AutoRouter.of(context).back(),
      ),
    );
  }
}
