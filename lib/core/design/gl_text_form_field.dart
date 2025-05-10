import 'dart:math';

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
    this.readOnly = false,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.enabled = true,
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
  final bool readOnly;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      enabled: enabled,
      onChanged: onChanged,
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: validator,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      onTap: onTap,
    );
  }
}
