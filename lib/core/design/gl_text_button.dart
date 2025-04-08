import 'package:flutter/material.dart';

class GlTextButton extends StatelessWidget {
  const GlTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.underlineColor,
    this.buttonPadding,
    this.buttonAlignment,
  });

  final String text;
  final Function onPressed;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final Color? underlineColor;
  final EdgeInsetsGeometry? buttonPadding;
  final AlignmentGeometry? buttonAlignment;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: buttonPadding,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: buttonAlignment,
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: textDecoration,
          decorationColor: underlineColor,
        ),
      ),
    );
  }
}
