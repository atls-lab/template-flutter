import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import '../../../../generated/assets.gen.dart';
import '../../../router/router.dart';
import '../../../screens/marketplace/marketplace_modal.dart';
import '../modal/modal.dart';
import '../modal/modal_props.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() => _selectedIndex = index);
        GetIt.I<AppRouter>().push(const HomeScreenRoute());
        return;
      case 1:
        return;
      case 2:
        setState(() => _selectedIndex = index);
        GetIt.I<AppRouter>().push(const GameScreenRoute());
        return;
      case 3:
        showDialog(
            context: context,
            builder: (context) => Modal(
                    props: ModalProps(
                  title: AppLocalizations.of(context)!.bottomNavBarMarketPlace,
                  subTitle: AppLocalizations.of(context)!
                      .bottomNavBarMarketPlaceModalSubTitle,
                  titleIcon: Assets.icons.solarTagPriceLineDuotone.svg(),
                  child: const MarketPlaceModal(),
                )));
        return;
    }
  }

  ColorFilter _getColorFilter(int index) {
    bool isSelected = index == _selectedIndex;
    Color selected = Theme.of(context).colorScheme.primary;
    Color unSelected = Theme.of(context).colorScheme.inverseSurface;

    return ColorFilter.mode(
        isSelected ? selected : unSelected, BlendMode.srcIn);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations intl = AppLocalizations.of(context)!;
    final double height = MediaQuery.of(context).size.height * 0.1;

    return SizedBox(
      height: height,
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Assets.icons.solarPawLineDuotone
                .svg(colorFilter: _getColorFilter(0)),
            label: intl.bottomNavBarHome,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.solarBackpackLineDuotone
                .svg(colorFilter: _getColorFilter(1)),
            label: intl.bottomNavBarCollection,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.solarCupStarLineDuotone
                .svg(colorFilter: _getColorFilter(2)),
            label: intl.bottomNavBarGame,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.solarTagPriceLineDuotone
                .svg(colorFilter: _getColorFilter(3)),
            label: intl.bottomNavBarMarketPlace,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
