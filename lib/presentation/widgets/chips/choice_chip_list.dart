import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import 'custom_chip.dart';

class CustomChoiceChipList extends StatelessWidget {
  const CustomChoiceChipList({
    super.key,
    required this.options, required this.groupValue, required this.onChanged,this.question,
  });

  final List<String> options;
  final String? groupValue,question;
  final void Function(String?) onChanged;

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
        Wrap(
          spacing: MySizes.spaceBtwItems.r,
          children: options.map((option) {
            return CustomChoiceChip<String>(
              label: option,
              value: option,
              groupValue: groupValue,
              onChanged: onChanged,
            );
          }).toList(),
        ),
      ],
    );
  }
}