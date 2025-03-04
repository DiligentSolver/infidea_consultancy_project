import 'package:flutter/material.dart';
import '../core/constants/App_colors.dart';
import '../core/widgets/custom_tabs.dart';
import 'application_status.dart';
import 'interview_screen.dart';

class MyApplicationsScreen extends StatefulWidget {
  @override
  _MyApplicationsScreenState createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Applications',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Colors.white,
        elevation: 2,


      ),
      body: Column(
        children: [
          // Custom Tabs for navigation
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomTabs(
              tabs: ['Application Status', 'Interview'],
              selectedIndex: _selectedIndex,
              onTabChanged: _onTabChanged,
              selectedColor: AppColors.primary,
              unselectedColor: Colors.grey,
              selectedTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              unselectedTextStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
          // Swipeable PageView
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: [
                ApplicationStatus(),
                InterviewScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
