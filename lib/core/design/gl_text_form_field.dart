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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
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
