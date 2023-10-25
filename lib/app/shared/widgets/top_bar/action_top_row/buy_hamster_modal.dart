import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../themes/src/colors.dart';
import '../../widgets.dart';

class AddHamsterModal extends StatelessWidget {
  const AddHamsterModal({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations intl = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.slightlyGrey),
          ),
          child: Assets.images.spend.image(),
        ),
        const SizedBox(height: 24),
        Button(
            props: ButtonProps(
          text: '${intl.buy} ${intl.hamsters}',
          fill: true,
          onPressed: () => Navigator.pop(context),
        ))
      ],
    );
  }
}
