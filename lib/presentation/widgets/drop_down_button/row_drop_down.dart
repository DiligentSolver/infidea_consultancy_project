import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/helpers/helper_functions.dart';

class RowCustomDropdown extends StatefulWidget {
  final String label1;
  final String label2;
  final String? question;
  final int minValue1;
  final int maxValue1;
  final int minValue2;
  final int maxValue2;
  final bool isDown;
  final Function(int value1, int value2) onSelected;

  const RowCustomDropdown({
    super.key,
    required this.label1,
    required this.label2,
    required this.minValue1,
    required this.maxValue1,
    required this.minValue2,
    required this.maxValue2,
    required this.onSelected,
    this.question,
    this.isDown = false, // Default to dropdown opening below
  });

  @override
  State<RowCustomDropdown> createState() => _RowCustomDropdownState();
}

class _RowCustomDropdownState extends State<RowCustomDropdown> {
  int? selectedValue1;
  int? selectedValue2;
  TextEditingController searchController1 = TextEditingController();
  TextEditingController searchController2 = TextEditingController();
  late List<int> filteredItems1;
  late List<int> filteredItems2;

  @override
  void initState() {
    super.initState();
    filteredItems1 = List.generate(widget.maxValue1 - widget.minValue1 + 1, (index) => widget.minValue1 + index);
    filteredItems2 = List.generate(widget.maxValue2 - widget.minValue2 + 1, (index) => widget.minValue2 + index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.question != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.question!,
              style: MYAppTextStyles.labelLarge(),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: widget.label1,
                selectedValue: selectedValue1,
                controller: searchController1,
                items: filteredItems1,
                onChanged: (value) {
                  setState(() {
                    selectedValue1 = value;
                    widget.onSelected(selectedValue1!, selectedValue2!);
                  });
                },
              ),
            ),
            horizontalSpace(10),
            Expanded(
              child: _buildDropdown(
                label: widget.label2,
                selectedValue: selectedValue2,
                controller: searchController2,
                items: filteredItems2,
                onChanged: (value) {
                  setState(() {
                    selectedValue2 = value;
                    widget.onSelected(selectedValue1!, selectedValue2!);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required int? selectedValue,
    required TextEditingController controller,
    required List<int> items,
    required ValueChanged<int> onChanged,
  }) {
    return PopupMenuButton<int>(
      onSelected: (int value) {
        onChanged(value);
      },
      offset: Offset(0, widget.isDown ? -MySizes.fourty.sh : 10), // Handles dropdown positioning
      constraints: BoxConstraints(
        maxHeight: MySizes.thirty.sh,
        minWidth: MySizes.fifty.sw,
      ),
      position: PopupMenuPosition.under,
      elevation: MySizes.elevationXl,
      color: MYAppHelperFunctions.isDarkMode(context) ? null : MYColors.lightThemeBg,
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MYInputField(
                    controller: controller,
                    hintText: "Search...",
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (query) {
                      setState(() {
                        items = List.generate(
                          widget.maxValue1 - widget.minValue1 + 1,
                              (index) => widget.minValue1 + index,
                        ).where((item) => item.toString().contains(query)).toList();
                      });
                    },
                  ),
                ),
                ...items.map((item) {
                  final isSelected = selectedValue == item;
                  return ListTile(
                    title: Text(
                      "$item",
                      style: MYAppTextStyles.labelLarge(
                        color: MYAppHelperFunctions.isDarkMode(context)
                            ? MYColors.darkTextPrimaryColor
                            : MYColors.textPrimaryColor,
                      ),
                    ),
                    selected: isSelected,
                    onTap: () {
                      Navigator.of(context).pop(item);
                    },
                    trailing: isSelected ? const Icon(Icons.check, color: MYColors.secondaryColor) : null,
                  );
                }),
              ],
            ),
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: MYColors.secondarylighterColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                selectedValue == null ? label : "$selectedValue",
                overflow: TextOverflow.ellipsis,
                style: MYAppTextStyles.labelLarge(
                  color: selectedValue == null ? Colors.grey : null,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController1.dispose();
    searchController2.dispose();
    super.dispose();
  }
}
