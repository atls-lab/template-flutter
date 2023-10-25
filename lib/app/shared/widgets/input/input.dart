import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../generated/assets.gen.dart';
import 'input_props.dart';
import 'input_styles.dart';

class Input extends StatefulWidget {
  final InputProps props;

  const Input({super.key, required this.props});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late bool obscurePassword;

  @override
  void initState() {
    if (widget.props.type == TextInputType.visiblePassword) {
      obscurePassword = true;
    } else {
      obscurePassword = widget.props.obscureText;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onPressHandler() {
      if (widget.props.type == TextInputType.visiblePassword) {
        setState(() => obscurePassword = !obscurePassword);
      }
      widget.props.onChange;
    }

    final styles = InputStyles(theme: Theme.of(context));

    SvgPicture iconPassword = obscurePassword
        ? Assets.icons.solarEyeClosedLineDuotone.svg(
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.inverseSurface,
              BlendMode.srcIn,
            ),
          )
        : Assets.icons.solarEyeLineDuotone.svg(
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.inverseSurface,
              BlendMode.srcIn,
            ),
          );

    if (widget.props.type == TextInputType.visiblePassword) {
      widget.props.icon = iconPassword;
    }

    final maxLines = widget.props.expands ? null : 1;

    return SizedBox(
      height: widget.props.height,
      child: SizedBox(
          width: widget.props.width,
          height: widget.props.height,
          child: TextFormField(
            inputFormatters: widget.props.inputFormatters,
            expands: widget.props.expands,
            maxLines: maxLines,
            textAlign: widget.props.textAlign ?? TextAlign.start,
            maxLength: widget.props.maxLength,
            showCursor: widget.props.showCursor ?? true,
            autofocus: widget.props.autoFocus ?? false,
            validator: widget.props.validator,
            obscureText: obscurePassword,
            enabled: widget.props.enabled,
            controller: widget.props.controller,
            autovalidateMode: widget.props.autoValidate,
            scrollPadding: widget.props.scrollPadding,
            enableSuggestions: widget.props.enableSuggestions,
            onChanged: widget.props.onChange,
            cursorColor: Theme.of(context).colorScheme.inverseSurface,
            keyboardType: widget.props.type,
            style: widget.props.style ??
                styles.contentStyle.merge(styles.baseStyle),
            decoration: styles.shapeStyle.copyWith(
              hintText: widget.props.hintText,
              hintStyle: widget.props.hintStyle,
              labelText: widget.props.label,
              suffixIcon: widget.props.icon != null
                  ? IconButton(
                      disabledColor: Colors.transparent,
                      onPressed: onPressHandler,
                      iconSize: 24,
                      color: Colors.transparent,
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      alignment: Alignment.center,
                      icon: widget.props.icon as Widget,
                    )
                  : null,
            ),
          )),
    );
  }
}
