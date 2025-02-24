import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../core/utils/text_styles/text_styles.dart';

class MultiSearchDropdownButton extends StatefulWidget {
  final List<dynamic> items;
  final dynamic Function(dynamic)? onChanged;
  final double overlayHeight;
  final String? question,hintText;
  final int maxSelection; // Max selection limit

  const MultiSearchDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.overlayHeight = MySizes.fourty,
    this.question,
    this.maxSelection = 3, this.hintText, // Default max selection
  });

  @override
  State<MultiSearchDropdownButton> createState() =>
      _MultiSearchDropdownButtonState();
}

class _MultiSearchDropdownButtonState extends State<MultiSearchDropdownButton> {
  List<dynamic> selectedItems = [];


  void _handleSelection(List<dynamic> newSelection) {
    if (newSelection.length > widget.maxSelection) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You can select up to ${widget.maxSelection} only!",
            style: MYAppTextStyles.labelLarge(),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      setState(() {
        selectedItems = newSelection;
      });
      if (widget.onChanged != null) {
        widget.onChanged!(newSelection);
      }
    }
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
        CustomDropdown.multiSelectSearch(
          items: widget.items,
          onListChanged: _handleSelection,
          overlayHeight: widget.overlayHeight.sh,
          closeDropDownOnClearFilterSearch: true,
          hintText: widget.hintText ?? "You can select up to ${widget.maxSelection}",
          decoration: CustomDropdownDecoration(
            listItemDecoration: const ListItemDecoration(
              selectedColor:MYColors.transparent
            ),
            expandedFillColor: MYAppHelperFunctions.isDarkMode(context)
                ? MYColors.black
                : MYColors.bannerWhite,
            closedFillColor: MYColors.transparent,
            closedSuffixIcon: Icon(
              Icons.arrow_drop_down,
              color: MYAppHelperFunctions.isDarkMode(context)
                  ? MYColors.darkTextPrimaryColor
                  : MYColors.textPrimaryColor,
            ),
            expandedSuffixIcon: Icon(
              Icons.arrow_drop_up,
              color: MYAppHelperFunctions.isDarkMode(context)
                  ? MYColors.darkTextPrimaryColor
                  : MYColors.textPrimaryColor,
            ),
            noResultFoundStyle: MYAppTextStyles.labelLarge(),
            hintStyle: MYAppTextStyles.labelLarge(),
            headerStyle: MYAppTextStyles.labelLarge(),
            listItemStyle: MYAppTextStyles.labelLarge(),
            searchFieldDecoration: SearchFieldDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: MYColors.secondarylighterColor),
              ),
              fillColor: MYColors.transparent,
              prefixIcon: Icon(
                Icons.search,
                color: MYAppHelperFunctions.isDarkMode(context)
                    ? MYColors.darkTextPrimaryColor
                    : MYColors.secondaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
