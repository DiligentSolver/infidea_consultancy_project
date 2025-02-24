import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../core/utils/text_styles/text_styles.dart';

class SingleSearchDropdownButton extends StatelessWidget {
  final List<dynamic> items;
  final  dynamic Function(dynamic)? onChanged;
  final double overlayHeight;
  final String? question,hintText;

  const SingleSearchDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.overlayHeight = MySizes.fourty, this.question, this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              question!,
              style: MYAppTextStyles.labelLarge(),
            ),
          ),
          CustomDropdown.search(
          noResultFoundText: "Select State first or no result found",
          items: items,
          onChanged: onChanged,
          overlayHeight: overlayHeight.sh,
          closeDropDownOnClearFilterSearch: true,
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
                  borderSide: BorderSide(color: MYColors.secondarylighterColor)
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
            hintText: hintText ?? "Select an option",
        ),
      ],
    );
  }
}
