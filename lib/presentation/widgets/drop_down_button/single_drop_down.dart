import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';

import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../input_fields/text_form_field.dart';

class SingleDropdownSelect extends StatefulWidget {
  final List<dynamic> items;
  final String? selectedItem;
  final ValueChanged<String?>? onSelectionChanged;
  final String? question;
  final String? hintText;
  final bool isDown;
  final String? labelKey;

  const SingleDropdownSelect({
    super.key,
    required this.items,
    this.selectedItem,
    this.isDown = false,
    this.onSelectionChanged,
    this.question,
    this.hintText,
    this.labelKey = "name",
  });

  @override
  State<SingleDropdownSelect> createState() => _SingleDropdownSelectState();
}

class _SingleDropdownSelectState extends State<SingleDropdownSelect> {
  String? selectedItem;
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredItems = [];

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
    // Initialize filteredItems with all items
    updateFilteredItems("");
  }

  @override
  void didUpdateWidget(SingleDropdownSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      updateFilteredItems(searchController.text);
    }
    if (widget.selectedItem != oldWidget.selectedItem) {
      selectedItem = widget.selectedItem;
    }
  }

  void updateFilteredItems(String query) {
    filteredItems = widget.items.where((item) {
      String label = item is Map
          ? item[widget.labelKey].toString()
          : item.toString();
      return label.toLowerCase().contains(query.toLowerCase());
    }).toList();
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
        PopupMenuButton<String>(
          onSelected: (String value) {
            setState(() {
              selectedItem = value;
            });
            widget.onSelectionChanged?.call(value);
          },
          offset: Offset(0, widget.isDown ? -MySizes.fourty.sh : 10),
          constraints: BoxConstraints(
            maxHeight: MySizes.thirty.sh,
            minWidth: MySizes.ninty.sw,
          ),
          position: PopupMenuPosition.under,
          elevation: MySizes.elevationXl,
          color: MYAppHelperFunctions.isDarkMode(context) ? null : MYColors.lightThemeBg,
          itemBuilder: (context) => [
            PopupMenuItem(
              enabled: false,
              padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
              child: StatefulBuilder(
                builder: (context, setPopupState) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MYInputField(
                        controller: searchController,
                        hintText: "Search...",
                        prefixIcon: const Icon(Icons.search),
                        onChanged: (query) {
                          setPopupState(() {
                            updateFilteredItems(query);
                          });
                        },
                      ),
                    ),
                    if (filteredItems.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "No items found",
                          style: MYAppTextStyles.labelLarge(
                            color: MYColors.grey,
                          ),
                        ),
                      )
                    else
                      ...filteredItems.map((item) {
                        String label = item is Map
                            ? item[widget.labelKey].toString()
                            : item.toString();
                        final isSelected = selectedItem == label;
                        return ListTile(
                          title: Text(
                            label,
                            style: MYAppTextStyles.labelLarge(
                              color: MYAppHelperFunctions.isDarkMode(context)
                                  ? MYColors.darkTextPrimaryColor
                                  : MYColors.textPrimaryColor,
                            ),
                          ),
                          selected: isSelected,
                          onTap: () {
                            Navigator.of(context).pop(label);
                          },
                          trailing: isSelected
                              ? const Icon(Icons.check, color: MYColors.secondaryColor)
                              : null,
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
                    selectedItem ?? (widget.hintText ?? "Select an option"),
                    overflow: TextOverflow.ellipsis,
                    style: MYAppTextStyles.labelLarge(
                      color: selectedItem == null ? MYColors.grey : null,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}