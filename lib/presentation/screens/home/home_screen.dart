import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';

import 'banner_slider.dart';
import 'featured_companies.dart';
import 'job_category_list.dart';
import 'job_recommended_list.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Your Dream Job"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {}, // Navigate to notifications
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Promotions
            const BannerSlider(),

            SizedBox(height: MySizes.spaceBtwItems),

            // Job Categories
            const Text("Browse by Category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const CategoryList(),

            SizedBox(height: MySizes.spaceBtwItems),

            // Recommended Jobs
            const Text("Recommended for You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            JobList(type: "recommended"),

            SizedBox(height: MySizes.spaceBtwItems),

            // Featured Companies
            const Text("Featured Companies",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const FeaturedCompanies(),

            SizedBox(height: MySizes.spaceBtwItems),

            // Latest Jobs
            const Text("Latest Jobs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            JobList(type: "latest"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MYColors.primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
