import 'package:flutter/material.dart';

import '../../themes/src/colors.dart';

class SettingsDivider extends StatelessWidget {

  const SettingsDivider({super.key,});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 0.0,
      thickness: 1.0,
      color: AppColors.microGrey,
    );
  }
}