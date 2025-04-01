import 'package:flutter/material.dart';

class DataPicker {
  TextEditingController? dateController;
  DateTime? selectedDate;
  DataPicker({this.dateController, this.selectedDate});

  Future<void> displayDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          selectedDate ?? DateTime.now().subtract(Duration(days: 365 * 18)),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 100)),
      lastDate: DateTime.now().subtract(Duration(days: 365 * 18)),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      dateController?.text =
          '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
    }
  }
}
