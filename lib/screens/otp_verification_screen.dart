import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobile;

  const OtpVerificationScreen({required this.mobile, super.key});

  @override
  OtpVerificationScreenState createState() => OtpVerificationScreenState();
}

class OtpVerificationScreenState extends State<OtpVerificationScreen> {

  // final TextEditingController _controllers = TextEditingController();
  int _resendTimer = 30;
  bool _canResend = true;
  Timer? _timer;
  String _otp = '';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  void startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
      if (state is Authenticated) {
        Navigator.pushNamedAndRemoveUntil(context, '/homeScreen', (route) => false);
      } else if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
      }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/login-page/otp.png',width: 300,height: 300),
                  Text(
                    'Enter the OTP sent to ${widget.mobile}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    textStyle: GoogleFonts.poppins(
                      color: Colors.white
                    ),
                    appContext: context,
                    length: 6,  // Set the number of OTP fields
                    obscureText: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeColor: const Color(0xFFffd700),
                      inactiveColor: Colors.white,
                      selectedColor: const Color(0xFFffd700),
                    ),
                    onChanged: (value) {
                     _otp = value;
                    },
                  ),
                  GestureDetector(
                    onTap: _canResend
                        ? () {
                      setState(() {
                        _canResend = false;
                        _resendTimer = 30; // Reset timer
                      });
                      context.read<AuthBloc>().add(ResendOtpEvent(widget.mobile));
                      startResendTimer();
                    }
                        : null, // Disable when timer is running
                    child: Text(
                      _canResend ? 'Resend OTP' : 'Resend in $_resendTimer sec',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: _canResend ? const Color(0xFFffd700) : Colors.grey,
                        decoration: _canResend ? TextDecoration.underline : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  state is AuthLoading
                      ? const CircularProgressIndicator(color: Color(0xFFffd700)):SizedBox(
                    width: double.infinity,
                    height: 50,
                    child:  ElevatedButton(
                    onPressed: state is AuthLoading ? null:() {
                      final otp = _otp;
                      if (otp.isNotEmpty) {
                        context
                            .read<AuthBloc>()
                            .add(VerifyOtpEvent(widget.mobile, otp));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter the OTP')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFffd700),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),),
                    child: Text('Verify OTP',style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                  )),
                  SizedBox(height: 150,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
