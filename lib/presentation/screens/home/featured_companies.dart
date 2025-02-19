import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/constants/images.dart';

class FeaturedCompanies extends StatelessWidget {
  const FeaturedCompanies({super.key});

  @override
  Widget build(BuildContext context) {
    final companies = [
      {"name": "Google", "logo": MyImages.onBoardingPage1},
      {"name": "Microsoft", "logo":MyImages.onBoardingPage2},
      {"name": "Amazon", "logo": MyImages.onBoardingPage3},
    ];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(company["logo"]!),
                ),
                const SizedBox(height: 5),
                Text(company["name"]!, style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}
