class SwitcherProps {
  final bool value;
  final void Function(bool)? onChange;

  SwitcherProps({
    this.value = false,
    this.onChange,
  });
}
