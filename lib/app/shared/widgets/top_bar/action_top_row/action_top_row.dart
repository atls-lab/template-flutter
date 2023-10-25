import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../themes/src/colors.dart';
import '../../widgets.dart';

class ActionRowFragment extends StatelessWidget {
  const ActionRowFragment({super.key});

  List<Widget> _renderButtonRow(
      BuildContext context, AppLocalizations intl, int numberOfHamsters) {
    final Widget chargeModal = Modal(
        props: ModalProps(
            title: intl.homeChargeModalTitle,
            child: const ChargeModal(),
            titleIcon:
                Assets.icons.solarRoundDoubleAltArrowUpBold.svg(width: 32)));

    final Widget addHamsterModal = Modal(
        props: ModalProps(
      title: '${intl.add} ${intl.energy}',
      subTitle: intl.homeAddEnergyModalSubTitle,
      child: const AddHamsterModal(),
      titleIcon: Assets.icons.solarBatteryChargeLineDuotone.svg(width: 30),
    ));

    return List.generate(
        4,
        (index) => Button(
            props: ButtonProps(
                small: true,
                onPressed: () => showDialog(
                    context: context,
                    builder: (_) => index < numberOfHamsters
                        ? chargeModal
                        : addHamsterModal),
                variant: index < numberOfHamsters
                    ? ButtonVariant.primary
                    : ButtonVariant.secondary,
                icon: index < numberOfHamsters
                    ? Assets.icons.solarBoltLineDuotone.svg(
                        width: 16,
                        colorFilter: const ColorFilter.mode(
                            AppColors.black, BlendMode.srcIn))
                    : Assets.icons.solarLockBold.svg(
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        )))));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations intl = AppLocalizations.of(context)!;
    final Size currentSize = MediaQuery.of(context).size;

    final double widthOfContainer = currentSize.width * 0.25;

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _renderButtonRow(context, intl, 1)
            .map((widget) => Container(
                  width: widthOfContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: widget,
                ))
            .toList());
  }
}
