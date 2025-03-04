import 'package:flutter/material.dart';

class CustomTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;
  final Color selectedColor;
  final Color unselectedColor;
  final double tabSpacing;
  final double indicatorWidth;
  final double indicatorHeight;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  const CustomTabs({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.tabSpacing = 80,
    this.indicatorWidth = 100,
    this.indicatorHeight = 2,
    this.selectedTextStyle,
    this.unselectedTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tabs.length * 2 - 1,
              (index) {
            // Return spacing between tabs
            if (index.isOdd) {
              return SizedBox(width: tabSpacing);
            }
            // Return tab
            final tabIndex = index ~/ 2;
            return _buildTab(tabs[tabIndex], tabIndex);
          },
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: isSelected
                ? (selectedTextStyle ?? TextStyle(
              color: selectedColor,
              fontWeight: FontWeight.bold,
            ))
                : (unselectedTextStyle ?? TextStyle(
              color: unselectedColor,
              fontWeight: FontWeight.normal,
            )),
          ),
          const SizedBox(height: 4),
          Container(
            height: indicatorHeight,
            width: indicatorWidth,
            color: isSelected ? selectedColor : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
