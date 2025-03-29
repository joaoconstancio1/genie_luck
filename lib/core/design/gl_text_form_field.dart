import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlTextFormField extends StatelessWidget {
  const GlTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.decoration,
    this.validator,
    this.autovalidateMode,
    this.inputFormatters,
    this.obscureText,
    this.focusNode,
    this.onTap,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration:
          decoration?.copyWith(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ) ??
          InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
      validator: validator,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      onTap: onTap,
    );
  }
}
