import 'package:flutter/material.dart';

import '../../screens/drawer/about_us_screen.dart';
import '../../screens/drawer/faq_screen.dart';
import '../../screens/drawer/help_screen.dart';
import '../../screens/drawer/notifications_screen.dart';
import '../../screens/drawer/settings_screen.dart';
import '../../screens/drawer/signout_screen.dart';

class NavDrawerWidget extends StatelessWidget {
  const NavDrawerWidget({super.key});

  void _navigate(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Hello, User!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "user@example.com",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildDrawerItem(
                    Icons.notifications_outlined,
                    'Notifications',
                    '3 new notifications',
                    context,
                    const NotificationsScreen(),
                  ),
                  _buildDrawerItem(
                    Icons.settings_outlined,
                    'Settings',
                    'App preferences',
                    context,
                    const SettingsScreen(),
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    Icons.info_outline,
                    'About Us',
                    'Learn more about us',
                    context,
                    const AboutUsScreen(),
                  ),
                  _buildDrawerItem(
                    Icons.help_outline,
                    'FAQ',
                    'Frequently asked questions',
                    context,
                    const FAQScreen(),
                  ),
                  _buildDrawerItem(
                    Icons.support_outlined,
                    'Help',
                    'Get support',
                    context,
                    const HelpScreen(),
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    Icons.logout_outlined,
                    'Sign Out',
                    'Exit the application',
                    context,
                    const SignOutScreen(),
                    isDestructive: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      IconData icon,
      String title,
      String subtitle,
      BuildContext context,
      Widget screen, {
        bool isDestructive = false,
      }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.grey[700],
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      onTap: () => _navigate(context, screen),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }
}