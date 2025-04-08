import 'package:flutter/material.dart';

class GlCheckBoxTile extends StatelessWidget {
  const GlCheckBoxTile({
    super.key,
    required this.onChanged,
    this.value,
    this.controlAffinity,
    this.title,
  });
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final ListTileControlAffinity? controlAffinity;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      controlAffinity: controlAffinity,
      title: title,
    );
  }
}
