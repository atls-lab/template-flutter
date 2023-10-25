import 'package:flutter/material.dart';

import 'action_top_row/action_top_row.dart';
import 'info_row/info_row.dart';

const double heightOfHomeTopBar = 104;

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(heightOfHomeTopBar);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 24),
        InfoRowFragment(),
        SizedBox(height: 8),
        ActionRowFragment(),
      ],
    );
  }
}
