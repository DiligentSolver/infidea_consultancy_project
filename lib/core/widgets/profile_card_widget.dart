/*
import 'package:flutter/material.dart';

import '../constants/App_colors.dart';


class ProfileCardWidget extends StatelessWidget {
  final String title;
  final List<String>? details;
  final Widget? customContent;
  final String navigationDestination;

  const ProfileCardWidget({
    Key? key,
    required this.title,
    this.details,
    this.customContent,
    required this.navigationDestination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                if (details != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: details!
                        .map((detail) => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(detail, style: TextStyle(fontSize: 14)),
                    ))
                        .toList(),
                  ),
                if (customContent != null) customContent!,
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.edit, color: AppColors.primary),
              onPressed: () {
                // Navigate to the specific screen based on card type
                Navigator.of(context).pushNamed(navigationDestination);
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import '../constants/App_colors.dart';

class ProfileCardWidget extends StatelessWidget {
  final String title;
  final List<String>? details;
  final Widget? customContent;
  final String navigationDestination;

  const ProfileCardWidget({
    Key? key,
    required this.title,
    this.details,
    this.customContent,
    required this.navigationDestination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(navigationDestination);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            if (details != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details!
                    .map((detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    detail,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ))
                    .toList(),
              ),
            if (customContent != null) customContent!,
          ],
        ),
      ),
    );
  }
}
