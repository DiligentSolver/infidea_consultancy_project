import 'package:flutter/material.dart';

import '../../core/constants/App_colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white70],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Adds horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo Section
              Center(
                child: Image.asset(
                  'assets/app-logo/infidea_logo.png', // Replace with your logo path
                  height: 100,
                  width: 300,
                ),
              ),
              const SizedBox(height: 20),

              // Welcome Heading
              const Text(
                'Welcome to Infidea Consultancy & Services Private Limited',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Description
              const Text(
                'A leading recruitment firm established in 2018, situated in Indore, the heart of Madhya Pradesh.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Founders Description
              const Text(
                'Founded by Sunny Goutam and Swarnim Jhawar, Infidea has rapidly grown to become a trusted partner for leading businesses across the globe, offering specialized HR services with a unique and innovative approach.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Mission Statement
              const Text(
                'At Infidea, we believe that the cornerstone of success lies in setting realistic customer expectations and then not just meeting but exceeding them, often in unexpected and exceptionally helpful ways.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Vision Statement
              const Text(
                'Our mission is to understand the specific needs of our clients and deliver tailored solutions that precisely match their requirements. This customer-centric philosophy has enabled us to consistently provide top talent that drives our clients\' success.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Specialization
              const Text(
                'We specialize in sourcing highly qualified and experienced professionals across various levels, from senior executives to middle management and entry-level positions. In today’s highly competitive business environment, having the right talent is crucial, and we are dedicated to helping our clients secure experienced, skilled, and hardworking professionals who can provide them with a competitive edge.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
