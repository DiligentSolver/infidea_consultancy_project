import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infidea_consultancy_app/core/utils/constants/texts.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';
import '../../../core/utils/constants/colors.dart';

class DateOfBirthPicker extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;

  const DateOfBirthPicker({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  DateOfBirthPickerState createState() => DateOfBirthPickerState();
}

class DateOfBirthPickerState extends State<DateOfBirthPicker> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime eighteenYearsAgo = DateTime.now().subtract(const Duration(days: 18 * 365));

    DateTime? picked = await showDatePicker(
      errorInvalidText: 'Below 18 years age are not allowed',
      context: context,
      initialDate: widget.selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: eighteenYearsAgo, // Ensures only 18+ age selection
      builder: (context, child) {
        return child!;
      },
    );

    if (picked != null) {
      widget.onDateSelected(picked);
    }
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController dobController = TextEditingController(text: widget.selectedDate != null
        ? "${widget.selectedDate!.day}/${widget.selectedDate!.month}/${widget.selectedDate!.year}"
        : null);
    return MYInputField(
      readOnly: true,
      controller: dobController,
      prefixIcon: const Icon(Icons.cake),
      suffixIcon: const Icon(FontAwesomeIcons.calendar),
      suffixIconColor: MYAppHelperFunctions.isDarkMode(context)? MYColors.secondarylighterColor:MYColors.secondaryColor,
      labelText: 'Date of Birth',
      hintText:  widget.selectedDate != null
          ? "${widget.selectedDate!.day}/${widget.selectedDate!.month}/${widget.selectedDate!.year}"
          : MYTexts.selectDateOfBirth,
      onTap: ()=>_selectDate(context),
    );
  }
}
