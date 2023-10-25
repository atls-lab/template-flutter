import 'package:flutter/material.dart';

import 'slider_props.dart';

class AppSlider extends StatefulWidget {
  final AppSliderProps props;

  const AppSlider({super.key, required this.props});

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  double currentValue = 0;

  @override
  void initState() {
    super.initState();
    currentValue = widget.props.value ?? 0;
  }

  void onChange(value) {
    setState(() {
      currentValue = value;
    });

    if (widget.props.onChange != null) widget.props.onChange!(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.props.width,
      height: widget.props.height,
      child: Slider(
        value: currentValue,
        onChanged: onChange,
        divisions: widget.props.divisions,
        max: widget.props.max,
        min: widget.props.min,
      ),
    );
  }
}
