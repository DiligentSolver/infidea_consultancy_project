import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"name": "IT & Software", "icon": Icons.computer},
      {"name": "Marketing", "icon": Icons.trending_up},
      {"name": "Finance", "icon": Icons.attach_money},
      {"name": "Design", "icon": Icons.brush},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(category["icon"] as IconData, size: 30), // Cast here
                ),
                const SizedBox(height: 5),
                Text(category["name"]!, style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}
