import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class DateOfBirthPicker extends StatefulWidget {
  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;

  const DateOfBirthPicker({
    super.key,
    required this.label,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  _DateOfBirthPickerState createState() => _DateOfBirthPickerState();
}

class _DateOfBirthPickerState extends State<DateOfBirthPicker> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: AppColors.secondary, // Orange header
            hintColor: AppColors.secondary,
            colorScheme: const ColorScheme.light(primary: AppColors.secondary),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.background, // Light Blue
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.secondary), // Orange border
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.selectedDate != null
                  ? "${widget.selectedDate!.day}/${widget.selectedDate!.month}/${widget.selectedDate!.year}"
                  : AppStrings.selectDateOfBirth,
              style: TextStyle(
                color: widget.selectedDate != null
                    ? AppColors.secondary
                    : AppColors.primary, // blue if no date is selected
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.calendar_today, color: AppColors.secondary),
          ],
        ),
      ),
    );
  }
}
