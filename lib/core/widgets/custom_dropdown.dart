import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final String? errorText;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.errorText,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primary, // White text for label
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.background,
            errorText: errorText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.secondary, width: 2), // Orange outline
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.secondary, width: 2), // Orange on focus
            ),
          ),
          iconEnabledColor: AppColors.secondary, // Orange dropdown icon
          dropdownColor: AppColors.background, // Background color of the dropdown menu
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(color: AppColors.textPrimary), // Blue text inside dropdown
              ),
            );
          }).toList(),
          onChanged: onChanged,
          // **Validation Using AppStrings**
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.selectOption; // Use the string from app_strings.dart
            }
            return null;
          },

        ),
      ],
    );
  }
}
