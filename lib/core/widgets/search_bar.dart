import 'package:flutter/material.dart';
import '../../screens/search_screen.dart';
import '../constants/App_colors.dart';
import '../widgets/animated_search_hint.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: AppColors.primary),
            SizedBox(width: 12),
            AnimatedSearchHint(), // Using the new reusable animated widget
            Spacer(),
            Icon(Icons.mic, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
