import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../themes/src/colors.dart';
import '../../widgets.dart';

class ChargeModal extends StatelessWidget {
  const ChargeModal({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations intl = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(style: theme.textTheme.bodySmall, children: [
          TextSpan(text: intl.homeChargeModalSubTitle),
          TextSpan(
              text: intl.homeChargeModalSubTitleGreen,
              style: const TextStyle(color: AppColors.toxicGreen)),
        ])),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),
        Text(intl.homeLevelUpYouSpend, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 8),
        StatRow(text: intl.chargingTime, value: '02:59'),
        const SizedBox(height: 24),
        Text(intl.homeLevelUpYouReceive, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 8),
        StatRow(
          text: intl.energy,
          value: '4',
          icon: Assets.icons.solarBoltLineDuotone.svg(),
        ),
        const SizedBox(height: 24),
        Button(
            props: ButtonProps(
                text: '${intl.restore} ${intl.energy}',
                fill: true,
                onPressed: () => Navigator.pop(context),
                icon: Assets.icons.solarPlugCircleLineDuotone.svg(
                    colorFilter: const ColorFilter.mode(
                        AppColors.black, BlendMode.srcIn))))
      ],
    );
  }
}
