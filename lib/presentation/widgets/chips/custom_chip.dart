import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';

class CustomChoiceChip<T> extends StatelessWidget {
  final String label;
  final String? question;
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  const CustomChoiceChip({
    super.key,
    required this.label,
    this.question,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (question != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              question!,
              style: MYAppTextStyles.labelLarge(),
            ),
          ),
        ChoiceChip(
          label: Text(
            label,
          ),
          selected: groupValue == value,
          onSelected: (selected) {
            if (selected) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }
}
