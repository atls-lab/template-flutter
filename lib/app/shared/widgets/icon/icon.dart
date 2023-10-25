import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_props.dart';

class AppIcon extends StatelessWidget {
  final AppIconProps props;

  const AppIcon({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/${props.fileName}.svg',
      width: props.width,
      height: props.height,
      fit: props.fit,
      colorFilter: ColorFilter.mode(props.color, BlendMode.srcIn),
    );
  }
}
