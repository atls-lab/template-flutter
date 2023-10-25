class CircleProgressBarProps {
  final double? value;
  final double width;
  final double height;
  final String textTop;
  final String textBottom;

  CircleProgressBarProps({
    required this.value,
    this.width = 70,
    this.height = 70,
    this.textTop = 'Hello darkness',
    this.textBottom = 'my old friend',
  });
}
