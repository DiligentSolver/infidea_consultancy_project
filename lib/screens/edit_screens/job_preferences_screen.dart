import 'package:flutter/material.dart';
import 'package:infidea_consultancy_app/core/constants/app_colors.dart';

import '../../core/widgets/custom_tabs.dart';


class JobPreferencesScreen extends StatefulWidget {
  const JobPreferencesScreen({super.key});

  @override
  State<JobPreferencesScreen> createState() => _JobPreferencesScreenState();
}

class _JobPreferencesScreenState extends State<JobPreferencesScreen> {
  int _selectedTabIndex = 0; // 0 for Job Prep, 1 for Work Prep

  // Job roles data
  final List<Map<String, bool>> jobRoles = [
    {'Graphic': false},
    {'Developer': false},
    {'Painter': false},
    {'Accountant': false},
    {'Sales': false},
  ];

  // Work preferences data
  final Map<String, List<Map<String, bool>>> workPreferences = {
    'Preferred employment type': [
      {'Full Time': false},
      {'Part Time': false},
    ],
    'Preferred workplace': [
      {'Field Job': false},
      {'Work from Office': false},
      {'Work from Home': false},
    ],
    'Preferred shift': [
      {'Day Shift': false},
      {'Night Shift': false},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Job Preferences',
          style: TextStyle(color: AppColors.primary),
        ),
      ),
      body: Column(
        children: [
          // Custom Tabs
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTabs(
              tabs: const ['Job Preference', 'Work Preference'],
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

          // Content based on selected tab
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildJobRolesContent()
                : _buildWorkPreferencesContent(),
          ),

          // Save Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement save functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobRolesContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: jobRoles.length,
      itemBuilder: (context, index) {
        final role = jobRoles[index];
        final title = role.keys.first;
        return CheckboxListTile(
          title: Text(title),
          value: role[title],
          onChanged: (value) {
            setState(() {
              role[title] = value!;
            });
          },
          activeColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }

  Widget _buildWorkPreferencesContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: workPreferences.length,
      itemBuilder: (context, index) {
        final category = workPreferences.keys.elementAt(index);
        final preferences = workPreferences[category]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...preferences.map((pref) {
              final title = pref.keys.first;
              return CheckboxListTile(
                title: Text(title),
                value: pref[title],
                onChanged: (value) {
                  setState(() {
                    pref[title] = value!;
                  });
                },
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              );
            }).toList(),
          ],
        );
      },
    );
  }
}