import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For getting current year
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  String getCurrentYear() {
    return DateFormat('yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Terms and Conditions",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFffd700),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to our e-commerce app! Please read our terms and conditions carefully before using our platform.",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "1. User Agreement",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFffd700),
                  ),
                ),
                Text(
                  "By using this app, you agree to the terms and conditions outlined herein. You also agree to comply with all applicable laws.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "2. Privacy Policy",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFffd700),
                  ),
                ),
                Text(
                  "We value your privacy and will take necessary steps to protect your personal information. Please review our privacy policy for more details.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "3. Payment Terms",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFffd700),
                  ),
                ),
                Text(
                  "All transactions are secure and encrypted. We accept various payment methods as outlined in the payment section.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "4. Refund Policy",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFffd700),
                  ),
                ),
                Text(
                  "We offer a 30-day return policy. If you are not satisfied with your purchase, please contact us for a refund or exchange.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "5. Delivery Terms",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFffd700),
                  ),
                ),
                Text(
                  "We strive to deliver products in a timely manner. Delivery times may vary depending on your location and the availability of the product.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 120),
                Center(
                  child: Text(
                    "© ${getCurrentYear()} InfideaConsultancy. All rights reserved.\nInfideaConsultancy® is a registered trademark.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFffd700),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
