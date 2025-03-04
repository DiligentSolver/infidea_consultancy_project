import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController(text: "+91 ");
  bool _isChecked = false;

  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  void _sendOtp(BuildContext context) {
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the Terms & Conditions first')),
      );
      return;
    }

    final mobile = _mobileController.text.replaceAll(" ", "");
    final String mobileWithoutCode = mobile.replaceAll("+91", "");

    if (mobile.startsWith("+91") && mobileWithoutCode.length == 10) {
      context.read<AuthBloc>().add(SendOtpEvent(mobile));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit mobile number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/login-page/login.png', width: 200, height: 200),
              Text("Welcome!", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: const Color(0xFF1265A0))),
              const SizedBox(height: 8),
              Text("Login to continue", style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xFF1265A0))),
              const SizedBox(height: 32),

              // Mobile Input Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE65A1C), width: 1),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/login-page/india-flag-icon.svg', width: 32, height: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _mobileController,
                        style: GoogleFonts.poppins(color: Colors.black),
                        decoration: const InputDecoration(border: InputBorder.none),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Bloc Consumer for Auth State
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is OtpSent) {
                    Navigator.pushNamed(
                      context, '/verifyOtp',
                      arguments: _mobileController.text.replaceAll(" ", ""),
                    );
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return state is AuthLoading
                      ? const CircularProgressIndicator(color: Color(0xFFffd700)) : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is AuthLoading ? null : () => _sendOtp(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE65A1C),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                          "Send OTP",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color:  Colors.white)
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 10),

              // Terms and Conditions with Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: _onCheckboxChanged,
                    activeColor: Colors.black,
                    checkColor: const Color(0xFF1265A0),
                    side: const BorderSide(color: Colors.black),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/termsAndConditions'),
                      child: RichText(
                        text: TextSpan(
                          text: "By continuing, you agree to our ",
                          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Terms & Conditions",
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFFE65A1C)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 40),
              // Center(
              //   child: GestureDetector(
              //     onTap: () => Navigator.pushNamed(context, '/login'),
              //     child: RichText(
              //       text: TextSpan(
              //         text: "Don't have an account? ",
              //         style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              //         children: [
              //           TextSpan(
              //             text: "Signup",
              //             style: GoogleFonts.poppins(
              //               color: const Color(0xFFffd700),
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}