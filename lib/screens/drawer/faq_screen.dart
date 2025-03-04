import 'package:flutter/material.dart';
import '../../core/constants/App_colors.dart'; // Assuming you have defined your colors in this file

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs', style: TextStyle(
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
        child: ListView(
          children: [
            _buildFAQItem(
              question: 'What is Infidea Consultancy?',
              answer:
              'Infidea Consultancy is a technology and business consultancy firm offering innovative solutions.',
            ),
            _buildFAQItem(
              question: 'How can I contact you?',
              answer: 'You can reach us via email, phone, or visit our office.',
            ),
            _buildFAQItem(
              question: 'Where is your office located?',
              answer:
              'Our office is located at 404, 4th Floor, Milinda Manor, Regal Circle, opposite Central Mall, South Tukoganj, Indore, Madhya Pradesh - 452001.',
            ),
            _buildFAQItem(
              question: 'What services do you offer?',
              answer:
              'We offer a range of services including business consulting, technology solutions, app development, and more.',
            ),
            _buildFAQItem(
              question: 'How do I apply for a job at Infidea Consultancy?',
              answer:
              'You can send your resume and cover letter to Jobs@infideaconsultancy.com or visit our website for more details.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary, // Setting question color to secondary
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Setting answer color to primary
              ),
            ),
          ),
        ],
      ),
    );
  }
}
