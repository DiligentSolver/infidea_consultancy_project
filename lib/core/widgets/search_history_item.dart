
import 'package:flutter/material.dart';

import '../../models/search_item.dart';
import '../constants/App_colors.dart';

class SearchHistoryItem extends StatelessWidget {
  final SearchItem item;
  final VoidCallback onTap;

  const SearchHistoryItem({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.search, color: AppColors.primary),
      title: Text(item.title),
      subtitle: Text(item.location),
      onTap: onTap,
    );
  }
}