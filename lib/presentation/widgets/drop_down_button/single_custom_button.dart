import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';

class SingleCustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final String? question;
  final ValueChanged<String>? onSelectionChanged;

  const SingleCustomDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    this.question,
    this.onSelectionChanged,
  });

  @override
  State<SingleCustomDropdown> createState() => _SingleCustomDropdownState();
}

class _SingleCustomDropdownState extends State<SingleCustomDropdown> {
  String? selectedItem;
  TextEditingController searchController = TextEditingController();
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
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
              style: MYAppTextStyles.labelLarge(),
            ),
          ),
        GestureDetector(
          onTap: () => _showSingleSelectModal(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
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

  /// **Single-selection Modal with Search**
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

                    // Single-select list
                    Expanded(
                      child: filteredItems.isNotEmpty
                          ? ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                selectedItem = item;
                              });
                              widget.onSelectionChanged?.call(item);
                              Navigator.pop(context);
                            },
                          );
                        },
                      )
                          : const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("No results found"),
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
