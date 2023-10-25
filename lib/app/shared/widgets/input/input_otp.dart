import 'package:flutter/material.dart';

import 'input.dart';
import 'input_props.dart';

class InputOTP extends StatelessWidget {
  final bool first;
  final bool last;
  final double? height;
  final TextEditingController? controller;

  const InputOTP({
    super.key,
    required this.first,
    required this.last,
    this.height,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Input(
      props: InputProps(
        autoFocus: true,
        showCursor: false,
        height: height ?? 100,
        textAlign: TextAlign.center,
        controller: controller,
        type: TextInputType.number,
        style: Theme.of(context).textTheme.headlineLarge,
        maxLength: 1,
        onChange: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
          if (value.length == 1 && last == true) {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}
