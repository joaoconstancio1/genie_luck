import 'package:flutter/services.dart';

class Formatters {
  List<TextInputFormatter>? dateFormatter = [
    FilteringTextInputFormatter.digitsOnly,
    TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text;
      String formatted = '';
      int selectionIndex = newValue.selection.end;

      for (int i = 0; i < text.length; i++) {
        if (i == 1 || i == 3) {
          if (text[i] != '/') {
            formatted += '/';
            if (i < selectionIndex) selectionIndex++;
          }
        }
        formatted += text[i];
      }

      if (formatted.length > 10) {
        formatted = formatted.substring(0, 10);
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(
          offset: selectionIndex.clamp(0, formatted.length),
        ),
      );
    }),
  ];
}
