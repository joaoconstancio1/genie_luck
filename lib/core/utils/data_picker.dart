import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataPicker {
  final TextEditingController dateController;
  DateTime? selectedDate;
  DataPicker({required this.dateController, this.selectedDate});

  Future<void> showDataPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Center(
            child: SizedBox(
              child: CupertinoDatePicker(
                use24hFormat: true,
                mode: CupertinoDatePickerMode.date,
                initialDateTime:
                    selectedDate ??
                    DateTime.now().subtract(Duration(days: 365 * 18)),
                maximumYear: DateTime.now().year - 18,
                minimumYear: DateTime.now().year - 100,
                onDateTimeChanged: (DateTime dateValue) {
                  selectedDate = dateValue;
                  dateController.value = TextEditingValue(
                    text:
                        '${dateValue.day.toString().padLeft(2, '0')}/${dateValue.month.toString().padLeft(2, '0')}/${dateValue.year}',
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
