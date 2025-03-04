import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

class NoInternetNotifierScreen extends StatefulWidget {
  const NoInternetNotifierScreen({super.key});

  @override
  State<NoInternetNotifierScreen> createState() => _NoInternetNotifierScreenState();
}

class _NoInternetNotifierScreenState extends State<NoInternetNotifierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 80, color: Color(0xFFffd700)),
              SizedBox(height: 20),
              Text(
                "No Internet Connection",
                style: GoogleFonts.poppins(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Please check your internet connection\nand try again.",
                style: GoogleFonts.poppins(color: Colors.white70,fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
