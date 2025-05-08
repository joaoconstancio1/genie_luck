import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataPicker {
  TextEditingController? dateController;
  DateTime? selectedDate;

  DataPicker({this.dateController, this.selectedDate});

  Future<void> displayDatePicker(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? eighteenYearsAgo,
      firstDate: DateTime(now.year - 100, now.month, now.day),
      lastDate: eighteenYearsAgo,
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      final formattedDate = DateFormat("dd, MMMM, yyyy").format(pickedDate);
      dateController?.text = formattedDate;
    }
  }
}
