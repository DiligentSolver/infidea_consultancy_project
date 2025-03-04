import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class MultiCustomDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? selectedItemSingle;
  final List<String> selectedItemMulti;
  final ValueChanged<String>? onSingleSelectionChanged;
  final ValueChanged<List<String>>? onMultiSelectionChanged;
  final int maxSelection;
  final bool isMultiSelect;

  const MultiCustomDropdown({
    super.key,
    required this.label,
    required this.items,
    this.selectedItemSingle,
    this.selectedItemMulti = const [],
    this.onSingleSelectionChanged,
    this.onMultiSelectionChanged,
    required this.maxSelection,
    required this.isMultiSelect,
  });

  @override
  _MultiCustomDropdownState createState() => _MultiCustomDropdownState();
}

class _MultiCustomDropdownState extends State<MultiCustomDropdown> {
  bool isExpanded = false;
  TextEditingController searchController = TextEditingController();
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.items);
  }

  void _toggleSelection(String item) {
    setState(() {
      if (widget.isMultiSelect) {
        List<String> updatedSelection = List.from(widget.selectedItemMulti);
        if (updatedSelection.contains(item)) {
          updatedSelection.remove(item);
        } else if (updatedSelection.length < widget.maxSelection) {
          updatedSelection.add(item);
        }
        widget.onMultiSelectionChanged?.call(updatedSelection);
      } else {
        widget.onSingleSelectionChanged?.call(item);
        isExpanded = false; // Close dropdown after selection
      }
    });
  }

  void _filterSearch(String query) {
    setState(() {
      filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleDropdown() {
    setState(() {
      isExpanded = !isExpanded;
      if (!isExpanded) searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.primary)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: isExpanded
                      ? TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: AppColors.textPrimary),
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                    onChanged: _filterSearch,
                    style: TextStyle(color: AppColors.secondary),
                  )
                      : Text(
                    widget.isMultiSelect
                        ? (widget.selectedItemMulti.isEmpty
                        ? "Select up to ${widget.maxSelection}"
                        : widget.selectedItemMulti.join(", "))
                        : (widget.selectedItemSingle?.isEmpty ?? true
                        ? "Select one"
                        : widget.selectedItemSingle!),
                    style: TextStyle(
                      color: (widget.isMultiSelect
                          ? widget.selectedItemMulti.isEmpty
                          : widget.selectedItemSingle?.isEmpty ?? true)
                          ? AppColors.textPrimary
                          : AppColors.secondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.close : Icons.arrow_drop_down,
                  color: AppColors.secondary,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.secondary),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            constraints: const BoxConstraints(maxHeight: 200), // Limit dropdown height
            child: SingleChildScrollView(
              child: Column(
                children: filteredItems.isNotEmpty
                    ? filteredItems.map((item) {
                  final bool isSelected = widget.isMultiSelect
                      ? widget.selectedItemMulti.contains(item)
                      : widget.selectedItemSingle == item;
                  return InkWell(
                    onTap: () => _toggleSelection(item),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item,
                            style: TextStyle(
                              color: isSelected ? AppColors.secondary : Colors.black,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          if (isSelected) const Icon(Icons.check, color: AppColors.secondary),
                        ],
                      ),
                    ),
                  );
                }).toList()
                    : [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("No results found", style: TextStyle(color: Colors.grey)),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}