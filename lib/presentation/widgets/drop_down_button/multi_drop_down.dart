import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';

class MultiDropdownSelect extends StatefulWidget {
  final List<dynamic> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>>? onSelectionChanged;
  final int maxSelection;
  final String? question;
  final bool isDown, isHint;
  final String labelKey; // Key for displaying labels

  const MultiDropdownSelect({
    super.key,
    required this.items,
    this.isDown = false,
    this.isHint = true,
    this.selectedItems = const [],
    this.onSelectionChanged,
    required this.maxSelection,
    this.question,
    this.labelKey = "name", // Default key for labels
  });

  @override
  State<MultiDropdownSelect> createState() => _MultiDropdownSelectState();
}

class _MultiDropdownSelectState extends State<MultiDropdownSelect> {
  late List<String> selectedItems;
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredItems = [];
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.selectedItems);
    updateFilteredItems("");
  }

  @override
  void didUpdateWidget(MultiDropdownSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      updateFilteredItems(searchController.text);
    }
    if (widget.selectedItems != oldWidget.selectedItems) {
      selectedItems = List.from(widget.selectedItems);
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
          onCanceled: () {
            setState(() {
              isOpened = false;
            });
          },
          onOpened: () {
            setState(() {
              isOpened = true;
            });
          },
          onSelected: (_) {},
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
              padding: const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
              child: StatefulBuilder(
                builder: (context, setState) => Column(
                  children: [
                    MYInputField(
                      controller: searchController,
                      hintText: "Search...",
                      prefixIcon: const Icon(Icons.search),
                      onChanged: (query) {
                        setState(() {
                          filteredItems = widget.items.where((item) {
                            String label = item is Map
                                ? item[widget.labelKey].toString()
                                : item.toString();
                            return label.toLowerCase().contains(query.toLowerCase());
                          }).toList();
                        });
                      },
                    ),
                    ...filteredItems.map((item) {
                      String label = item is Map ? item[widget.labelKey].toString() : item.toString();
                      final isSelected = selectedItems.contains(label);

                      return CheckboxListTile(
                        value: isSelected,
                        title: Text(
                          label,
                          style: MYAppTextStyles.labelLarge(
                            color: MYAppHelperFunctions.isDarkMode(context)
                                ? MYColors.darkTextPrimaryColor
                                : MYColors.textPrimaryColor,
                          ),
                        ),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              if (selectedItems.length < widget.maxSelection) {
                                selectedItems.add(label);
                              }
                            } else {
                              selectedItems.remove(label);
                            }
                          });
                          // Update parent state
                          this.setState(() {});
                          widget.onSelectionChanged?.call(List.from(selectedItems));
                        },
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
                    selectedItems.isEmpty
                        ? "You can select up to ${widget.maxSelection}"
                        : widget.isHint
                        ? selectedItems.join(", ")
                        : "You can select up to ${widget.maxSelection}",
                    overflow: TextOverflow.ellipsis,
                    style: MYAppTextStyles.labelLarge(),
                  ),
                ),
                Icon(isOpened ? Icons.close : Icons.arrow_drop_down),
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
