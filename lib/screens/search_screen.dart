import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/constants/app_colors.dart';
import '../core/widgets/multi_custom_dropdown.dart';
import '../core/widgets/search_history_item.dart';
import '../core/widgets/custom_tabs.dart';
import '../core/widgets/animated_search_hint.dart';
import '../models/search_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedTabIndex = 0; // 0 for Recent, 1 for Popular
  final TextEditingController _searchController = TextEditingController();
  String? selectedExperience;

  // Sample data - Move to a repository in production
  final List<SearchItem> _recentSearches = [
    SearchItem(title: 'Software Developer', location: 'Tukoganj, Indore'),
    SearchItem(title: 'Flutter Developer', location: 'Tukoganj, Indore'),
  ];

  final List<SearchItem> _popularSearches = [
    SearchItem(title: 'React Developer', location: 'Indore'),
    SearchItem(title: 'UI/UX Designer', location: 'Indore'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button and title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: AppColors.primary,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Animated Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
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
                      AnimatedSearchHint(), // Animation in Search Bar
                      Spacer(),
                      Icon(Icons.mic, color: AppColors.primary),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Search Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Implement search
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Search', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),

              // Custom Tabs
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomTabs(
                  tabs: const ['Recent searches', 'Popular searches'],
                  selectedIndex: _selectedTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  selectedColor: AppColors.primary,
                  unselectedColor: Colors.grey,
                  tabSpacing: 80,
                  indicatorWidth: 100,
                ),
              ),

              // Search History
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _selectedTabIndex == 0
                    ? _recentSearches.length
                    : _popularSearches.length,
                itemBuilder: (context, index) {
                  final item = _selectedTabIndex == 0
                      ? _recentSearches[index]
                      : _popularSearches[index];
                  return SearchHistoryItem(
                    item: item,
                    onTap: () {
                      _searchController.text = item.title;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
