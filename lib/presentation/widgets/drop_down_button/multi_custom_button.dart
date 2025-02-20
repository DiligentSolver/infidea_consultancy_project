import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';

class MultiCustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedItemSingle, question;
  final List<String> selectedItemMulti;
  final ValueChanged<String>? onSingleSelectionChanged;
  final ValueChanged<List<String>>? onMultiSelectionChanged;
  final int maxSelection;
  final bool isMultiSelect;

  const MultiCustomDropdown({
    super.key,
    required this.items,
    this.selectedItemSingle,
    this.question,
    this.selectedItemMulti = const [],
    this.onSingleSelectionChanged,
    this.onMultiSelectionChanged,
    required this.maxSelection,
    required this.isMultiSelect,
  });

  @override
  MultiCustomDropdownState createState() => MultiCustomDropdownState();
}

class MultiCustomDropdownState extends State<MultiCustomDropdown> {
  String? selectedSingleItem;
  List<String> selectedMultiItems = [];
  TextEditingController searchController = TextEditingController();
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    selectedSingleItem = widget.selectedItemSingle;
    selectedMultiItems = List.from(widget.selectedItemMulti);
    filteredItems = List.from(widget.items);
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        widget.isMultiSelect
            ? _buildMultiSelectDropdown()
            : _buildSingleSelectDropdown(),
      ],
    );
  }

  /// **Single Selection Dropdown**
  Widget _buildSingleSelectDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedSingleItem,
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text("Select"),
        items: widget.items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedSingleItem = value;
          });
          if (value != null) {
            widget.onSingleSelectionChanged?.call(value);
          }
        },
      ),
    );
  }

  /// **Multi Selection Dropdown with Search**
  Widget _buildMultiSelectDropdown() {
    return GestureDetector(
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
                selectedMultiItems.isEmpty
                    ? "Select up to ${widget.maxSelection}"
                    : selectedMultiItems.join(", "),
                overflow: TextOverflow.ellipsis,
                style: MYAppTextStyles.labelLarge(),
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  /// **Multi-selection Modal with Search**
  void _showMultiSelectModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        List<String> tempSelectedItems = List.from(selectedMultiItems);
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace.r),
              child: SizedBox(
                height: MySizes.fifty.sh,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Bar
                    MYInputField(
                      controller: searchController,
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      onChanged: (query) {
                        setModalState(() {
                          filteredItems = widget.items
                              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
                              .toList();
                        });
                      },
                    ),

                    // Multi-select list
                    Expanded(
                      child: filteredItems.isNotEmpty
                          ? ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          final isSelected = tempSelectedItems.contains(item);
                          return CheckboxListTile(
                            value: isSelected,
                            title: Text(item),
                            onChanged: (checked) {
                              setModalState(() {
                                if (checked == true) {
                                  if (tempSelectedItems.length < widget.maxSelection) {
                                    tempSelectedItems.add(item);
                                  }
                                } else {
                                  tempSelectedItems.remove(item);
                                }
                              });
                            },
                          );
                        },
                      )
                          : const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("No results found"),
                      ),
                    ),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child:  Text("Cancel",style: MYAppTextStyles.labelLarge(color: MYAppHelperFunctions.isDarkMode(context)?MYColors.darkTextPrimaryColor:MYColors.textPrimaryColor),),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedMultiItems = tempSelectedItems;
                            });
                            widget.onMultiSelectionChanged?.call(List.from(selectedMultiItems));
                            Navigator.pop(context);
                          },
                          child:  Text("Done",style: MYAppTextStyles.labelLarge(color: MYAppHelperFunctions.isDarkMode(context)?MYColors.darkTextPrimaryColor:MYColors.textPrimaryColor),),
                        ),
                      ],
                    ),
                    verticalSpace(MySizes.spaceBtwSectionsSm.r)
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
