import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../shared/utils/print_duration.dart';
import '../../../shared/widgets/widgets.dart';

class TimerButton extends StatefulWidget {
  final int timer;
  final Function onPress;
  final String text;

  const TimerButton(
      {super.key,
      required this.timer,
      required this.onPress,
      required this.text});

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  late int timer;
  bool enabled = false;

  @override
  void initState() {
    super.initState();
    timer = widget.timer;

    Timer.periodic(const Duration(seconds: 1), (internalTimer) {
      if (timer > 0) {
        setState(() {
          timer--;
        });
      } else if (timer == 0) {
        setState(() {
          enabled = true;
        });
        internalTimer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Button(
        props: ButtonProps(
      onPressed: enabled
          ? () {
              widget.onPress();
            }
          : null,
      fill: true,
      variant: ButtonVariant.secondary,
      text:
          '${widget.text}${enabled ? '' : ' ${printTimerDuration(Duration(seconds: timer))}'}',
    ));
  }
}
