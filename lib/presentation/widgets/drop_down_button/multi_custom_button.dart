import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';

class MultiCustomDropdown extends StatefulWidget {
  final List<dynamic> items;
  final String? question;
  final List<String> selectedItems;
  final ValueChanged<List<String>>? onSelectionChanged;
  final int maxSelection;
  final String labelKey;

  const MultiCustomDropdown({
    super.key,
    required this.items,
    this.question,
    this.selectedItems = const [],
    this.onSelectionChanged,
    required this.maxSelection,
    this.labelKey = "name",
  });

  @override
  MultiCustomDropdownState createState() => MultiCustomDropdownState();
}

class MultiCustomDropdownState extends State<MultiCustomDropdown> {
  List<String> selectedItems = [];
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredItems = [];

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.selectedItems);
    updateFilteredItems("");
  }

  @override
  void didUpdateWidget(MultiCustomDropdown oldWidget) {
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
        GestureDetector(
          onTap: () => _showMultiSelectModal(),
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
                        : selectedItems.join(", "),
                    overflow: TextOverflow.ellipsis,
                    style: MYAppTextStyles.labelLarge(),
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

  void _showMultiSelectModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
              child: SizedBox(
                height: MySizes.fifty.sh,
                child: Column(
                  children: [
                    MYInputField(
                      controller: searchController,
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      onChanged: (query) {
                        setModalState(() {
                          filteredItems = widget.items.where((item) {
                            String label = item is Map
                                ? item[widget.labelKey].toString()
                                : item.toString();
                            return label.toLowerCase().contains(query.toLowerCase());
                          }).toList();
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          String label = item is Map ? item[widget.labelKey].toString() : item.toString();
                          final isSelected = selectedItems.contains(label);
                          return CheckboxListTile(
                            value: isSelected,
                            title: Text(label),
                            onChanged: (checked) {
                              setModalState(() {
                                if (checked == true && selectedItems.length < widget.maxSelection) {
                                  selectedItems.add(label);
                                } else {
                                  selectedItems.remove(label);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
