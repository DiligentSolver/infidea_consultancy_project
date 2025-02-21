import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';

// 1. SingleCustomDropdown
class SingleCustomDropdown extends StatefulWidget {
  final List<dynamic> items;
  final String? selectedItem;
  final String? question;
  final ValueChanged<String>? onSelectionChanged;
  final String labelKey;

  const SingleCustomDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    this.question,
    this.onSelectionChanged,
    this.labelKey = "name",
  });

  @override
  State<SingleCustomDropdown> createState() => _SingleCustomDropdownState();
}

class _SingleCustomDropdownState extends State<SingleCustomDropdown> {
  String? selectedItem;
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredItems = [];

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
    updateFilteredItems("");
  }

  @override
  void didUpdateWidget(SingleCustomDropdown oldWidget) {
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

  void _showSingleSelectModal() {
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MYInputField(
                      controller: searchController,
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      onChanged: (query) {
                        setModalState(() {
                          updateFilteredItems(query);
                        });
                      },
                    ),
                    Expanded(
                      child: filteredItems.isNotEmpty
                          ? ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          String label = item is Map
                              ? item[widget.labelKey].toString()
                              : item.toString();
                          return ListTile(
                            title: Text(label),
                            selected: selectedItem == label,
                            trailing: selectedItem == label
                                ? const Icon(Icons.check, color: MYColors.secondaryColor)
                                : null,
                            onTap: () {
                              setState(() {
                                selectedItem = label;
                              });
                              widget.onSelectionChanged?.call(label);
                              Navigator.pop(context);
                            },
                          );
                        },
                      )
                          : const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("No results found"),
                        ),
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
          onTap: () => _showSingleSelectModal(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: MYColors.secondarylighterColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedItem ?? "Select an option",
                  style: MYAppTextStyles.labelLarge(),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
