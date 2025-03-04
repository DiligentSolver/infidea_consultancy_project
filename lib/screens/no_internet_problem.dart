import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class NoInternetProblem extends StatefulWidget {
  const NoInternetProblem({super.key});

  @override
  State<NoInternetProblem> createState() => _NoInternetProblemState();
}

class _NoInternetProblemState extends State<NoInternetProblem> {

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
              const SizedBox(height: 30,),
              // Bloc Consumer
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    Navigator.popAndPushNamed(
                        context, '/'
                    );
                  }
                  else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return state is AuthLoading
                  ? const CircularProgressIndicator(color: Color(0xFFffd700)):ElevatedButton(
                    onPressed: state is AuthLoading ? null:(){
                      BlocProvider.of<AuthBloc>(context).add(CheckAuthEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFffd700),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Retry",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
