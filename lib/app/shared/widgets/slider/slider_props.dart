class AppSliderProps {
  final dynamic value;
  final void Function(double)? onChange;
  final int? divisions;
  final double min;
  final double max;
  final double width;
  final double height;

  AppSliderProps({
    required this.value,
    required this.onChange,
    this.divisions,
    this.min = 0,
    this.max = 1,
    this.width = 307,
    this.height = 10,
  });
}
