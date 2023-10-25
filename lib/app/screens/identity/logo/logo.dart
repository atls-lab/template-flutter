import 'package:flutter/material.dart';

import '../../../../generated/assets.gen.dart';


class LogoProps {
  final bool fill;
  final Alignment alignment;

  LogoProps({
    this.fill = false,
    this.alignment = Alignment.center,
  });
}

class Logo extends StatelessWidget {
  final LogoProps props;

  const Logo({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: props.fill ? double.infinity : 177,
      alignment: props.alignment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.logoHamster.svg(),
          Assets.images.logo.svg(),
        ],
      ),
    );
  }
}
