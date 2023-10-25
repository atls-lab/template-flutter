import 'package:flutter/cupertino.dart';

import '../../../shared/widgets/widgets.dart';

class VerificationRow extends StatelessWidget {
  final double height;
  final List<TextEditingController> controllersList;

  const VerificationRow(
      {super.key,
      required this.height,
      required this.controllersList});

  @override
  Widget build(BuildContext context) {
    final int length = controllersList.length;

    List<Widget> list = List.generate(
        length,
        (index) => Expanded(
              child: InputOTP(
                  first: index == 0,
                  last: index == length - 1,
                  height: height,
                  controller: controllersList[index]),
            ),
        growable: false);

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list);
  }
}
