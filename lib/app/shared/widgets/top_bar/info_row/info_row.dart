import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../router/app_router.dart';
import '../../widgets.dart';

class InfoRowFragment extends StatelessWidget {
  const InfoRowFragment({super.key});

  handleAvatarTap() => GetIt.I<AppRouter>().pushNamed('/settings');

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations intl = AppLocalizations.of(context)!;
    final Size currentSize = MediaQuery.of(context).size;
    final double avatarRadius = currentSize.height * 0.025;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          child: InkWell(
              onTap: () => handleAvatarTap(),
              splashColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(Assets.images.avatar.path),
                radius: avatarRadius,
              )),
        ),
        Row(children: [
          InfoContainer(
              icon: Assets.icons.hamc.svg(width: 16),
              value: '9999',
              label: intl.hamc),
          SizedBox(width: currentSize.width * 0.03),
          InfoContainer(
              icon: Assets.icons.mingcuteBinanceCoinBnbFill.svg(width: 16),
              value: '9999',
              label: intl.bnb),
        ]),
        Button(
          props: ButtonProps(
            variant: ButtonVariant.primary,
            onPressed: () {},
            small: true,
            icon: Assets.icons.solarAddCircleLineDuotone.svg(
              colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimary, BlendMode.srcIn),
            ),
          ),
        ),
      ]
          .map((widget) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: widget,
              ))
          .toList(),
    );
  }
}
