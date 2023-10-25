import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [Input] field configuration.
///
/// [expands] field is responsible for expanding the input field in height.
/// Note: when [expands] is true, the [maxLines] and [minLines] should be [null].
/// More information you'll get from [https://api.flutter.dev/flutter/material/TextField/expands.html].
/// [inputFormatters] field is predicate for input text.
class InputProps {
  final String? label;
  final String? hintText;
  final double width;
  final double height;
  Widget? icon;
  final void Function(String)? onChange;
  final bool enabled;
  final TextInputType type;
  final String? Function(String?)? validator;
  final AutovalidateMode autoValidate;
  final bool enableSuggestions;
  final bool obscureText;
  final EdgeInsets scrollPadding;
  final void Function()? onPress;
  final TextEditingController? controller;
  final int? maxLength;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool? autoFocus;
  final bool? showCursor;
  final bool expands;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;

  InputProps(
      {this.autoFocus,
      this.showCursor,
      this.style,
      this.maxLength,
      this.label,
      this.width = 60,
      this.height = 50,
      this.icon,
      this.scrollPadding = const EdgeInsets.all(20.0),
      this.controller,
      this.obscureText = false,
      this.onPress,
      this.onChange,
      this.enabled = true,
      this.type = TextInputType.text,
      this.hintText,
      this.validator,
      this.autoValidate = AutovalidateMode.disabled,
      this.enableSuggestions = true,
      this.textAlign,
      this.expands = false,
      this.hintStyle,
      this.inputFormatters});
}
