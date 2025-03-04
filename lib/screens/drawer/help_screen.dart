/*
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/App_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  Future<void> _launchUrl(String urlString, {LaunchMode? mode}) async {
    final Uri uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(
        uri,
        mode: mode ?? LaunchMode.platformDefault,
      )) {
        throw Exception('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'Jobs@infideaconsultancy.com',
    );
    try {
      if (!await launchUrl(emailUri)) {
        throw Exception('Could not launch email');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (!await launchUrl(telUri)) {
        throw Exception('Could not launch phone');
      }
    } catch (e) {
      debugPrint('Error launching phone: $e');
    }
  }

  Future<void> _launchMaps(String address) async {
    final String encodedAddress = Uri.encodeComponent(address);
    final Uri mapsUri = Uri.parse(
        'https://www.google.com/maps/search/$encodedAddress'
    );
    try {
      if (!await launchUrl(
        mapsUri,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch maps');
      }
    } catch (e) {
      debugPrint('Error launching maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help', style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary, // Change the icon color to your primary color
          onPressed: () {
            Navigator.of(context).pop(); // This will pop the current screen from the navigation stack
          },
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _launchUrl(
                'https://www.infideaconsultancy.com',
                mode: LaunchMode.externalApplication,
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.language, color: AppColors.primary),
                  title: const Text('Website', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text('www.infideaconsultancy.com', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _launchPhone('9303781155'),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.phone, color: AppColors.primary),
                  title: const Text('Call Us', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text('+91-9303781155, +91-9303781156', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _launchEmail,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.email, color: AppColors.primary),
                  title: const Text('Email', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text('Jobs@infideaconsultancy.com', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _launchMaps(
                  '404, 4th Floor, Milinda Manor, Regal Circle, opposite Central Mall, South Tukoganj, Indore, Madhya Pradesh - 452001'
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: AppColors.primary),
                  title: const Text('Address', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text(
                    '404, 4th Floor, Milinda Manor, Regal Circle, opposite Central Mall, South Tukoganj, Indore, Madhya Pradesh - 452001',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/App_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  Future<void> _launchUrl(String urlString, {LaunchMode? mode}) async {
    final Uri uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(
        uri,
        mode: mode ?? LaunchMode.platformDefault,
      )) {
        throw Exception('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'Jobs@infideaconsultancy.com',
    );
    try {
      if (!await launchUrl(emailUri)) {
        throw Exception('Could not launch email');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (!await launchUrl(telUri)) {
        throw Exception('Could not launch phone');
      }
    } catch (e) {
      debugPrint('Error launching phone: $e');
    }
  }

  Future<void> _launchMaps(String address) async {
    final String encodedAddress = Uri.encodeComponent(address);
    final Uri mapsUri = Uri.parse(
        'https://www.google.com/maps/search/$encodedAddress'
    );
    try {
      if (!await launchUrl(
        mapsUri,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch maps');
      }
    } catch (e) {
      debugPrint('Error launching maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help', style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primary, // Change the icon color to your primary color
          onPressed: () {
            Navigator.of(context).pop(); // This will pop the current screen from the navigation stack
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _launchUrl(
                'https://www.infideaconsultancy.com',
                mode: LaunchMode.externalApplication,
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.language, color: AppColors.primary),
                  title: const Text('Website', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text('www.infideaconsultancy.com', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Phone Number 1
            GestureDetector(
              onTap: () => _launchPhone('9303781155'),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.phone, color: AppColors.primary),
                  title: const Text('Call Us', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text('+91-9303781155', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Phone Number 2
            GestureDetector(
              onTap: () => _launchPhone('9303781156'),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.phone, color: AppColors.primary),
                  title: const Text('Call Us', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text('+91-9303781156', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: _launchEmail,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.email, color: AppColors.primary),
                  title: const Text('Email', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text('Jobs@infideaconsultancy.com', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _launchMaps(
                  '404, 4th Floor, Milinda Manor, Regal Circle, opposite Central Mall, South Tukoganj, Indore, Madhya Pradesh - 452001'
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.location_on, color: AppColors.primary),
                  title: const Text('Address', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary)),
                  subtitle: const Text(
                    '404, 4th Floor, Milinda Manor, Regal Circle, opposite Central Mall, South Tukoganj, Indore, Madhya Pradesh - 452001',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
