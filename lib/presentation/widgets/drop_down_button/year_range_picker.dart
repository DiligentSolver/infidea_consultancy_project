import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/presentation/widgets/drop_down_button/single_search_drop_down.dart';

class YearRangePicker extends StatefulWidget {
  final List<String> startYears;
  final List<String> endYears;
  final String? selectedStartYear;
  final String? selectedEndYear;
  final Function(String)? onStartYearChanged;
  final Function(String)? onEndYearChanged;
  final String? startYearQuestion;
  final String? endYearQuestion;
  final String? startHintText;
  final String? endHintText;

  const YearRangePicker({
    super.key,
    required this.startYears,
    required this.endYears,
    this.selectedStartYear,
    this.selectedEndYear,
    this.onStartYearChanged,
    this.onEndYearChanged,
    this.startYearQuestion,
    this.endYearQuestion,
    this.startHintText,
    this.endHintText,
  });

  @override
  YearRangePickerState createState() => YearRangePickerState();
}

class YearRangePickerState extends State<YearRangePicker> {
  String? selectedStartYear;
  String? selectedEndYear;

  @override
  void initState() {
    super.initState();
    selectedStartYear = widget.selectedStartYear;
    selectedEndYear = widget.selectedEndYear;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleSearchDropdownButton(
            question: widget.startYearQuestion ?? "Start Year",
            hintText: widget.startHintText ?? "Select Start Year",
            items: widget.startYears,
            onChanged: (value) {
              setState(() {
                selectedStartYear = value;

                // Reset end year if it's invalid
                if (selectedEndYear != null &&
                    int.parse(selectedEndYear!) <= int.parse(selectedStartYear!)) {
                  selectedEndYear = null;
                  _showSnackBar("End year must be greater than start year.");
                }
              });
              if (widget.onStartYearChanged != null) {
                widget.onStartYearChanged!(value);
              }
            },
          ),
        ),
        SizedBox(width: MySizes.spaceBtwItems.r), // Space between dropdowns
        Expanded(
          child: SingleSearchDropdownButton(
            question: widget.endYearQuestion ?? "End Year",
            hintText: widget.endHintText ?? "Select End Year",
            items: selectedStartYear == null
                ? widget.endYears
                : widget.endYears
                .where((year) => int.parse(year) > int.parse(selectedStartYear!))
                .toList()..sort((a, b) => int.parse(a).compareTo(int.parse(b))), // Sorting in increasing order
            onChanged: (value) {
              if (selectedStartYear != null && int.parse(value) <= int.parse(selectedStartYear!)) {
                _showSnackBar("End year must be greater than start year.");
                return;
              }
              setState(() {
                selectedEndYear = value;
              });

              if (widget.onEndYearChanged != null) {
                widget.onEndYearChanged!(value);
              }
            },
          ),
        ),
      ],
    );
  }
}
