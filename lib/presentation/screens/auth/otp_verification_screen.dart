import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/images.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/buttons/elevated_button.dart';
import 'package:infidea_consultancy_app/presentation/widgets/pin_code_text_field/pin_code_text.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_event.dart';
import '../../../logic/blocs/auth/auth_state.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({required this.phoneNumber, super.key});

  @override
  OTPVerificationScreenState createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends State<OTPVerificationScreen> with CodeAutoFill{
  // final TextEditingController _controllers = TextEditingController();
  int _resendTimer = 30;
  bool _canResend = true;
  Timer? _timer;
  String _otp = '';


  void listenForOtp() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  void codeUpdated() {
    if (code != null) {
      setState(() {
        _otp = code!;
      });

      // Automatically submit OTP when it's fully received
      if (_otp.length == 4) {
        context.read<AuthBloc>().add(VerifyOtpEvent(widget.phoneNumber, _otp));
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    cancel(); // Stop listening for OTP when screen is closed
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
  void initState() {
    // TODO: implement initState
    super.initState();
    listenForOtp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: MySizes.defaultSpace),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(MyImages.otpVerificationImg,
                          width: MySizes.imageBannerHeightMd.w,
                          height: MySizes.imageBannerHeightMd.h),
                      Text('Enter the OTP sent to ${widget.phoneNumber}',
                          textAlign: TextAlign.center,
                          style: MYAppTextStyles.titleLarge()),
                      verticalSpace(MySizes.spaceBtwItems.r),
                      MYOtpField(
                        width: 300,
                        onChanged: (value) {
                          setState(() {
                            _otp = value;
                          });

                          // Auto-submit when OTP is fully entered
                          if (_otp.length == 4) {
                            context.read<AuthBloc>().add(VerifyOtpEvent(widget.phoneNumber, _otp));
                          }
                        },
                      ),
                      verticalSpace(MySizes.spaceBtwItemsSm.r),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is Authenticated) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/homeScreen', (route) => false);
                          }else if(state is NewUserState){
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/stepOneCollection', (route) => false);
                          }
                          else if (state is AuthError) {
                            Bars.showErrorSnackBar(
                                context: context, title: state.message);
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: _canResend
                                    ? () {
                                        setState(() {
                                          _canResend = false;
                                          _resendTimer = 30; // Reset timer
                                        });
                                        context.read<AuthBloc>().add(
                                            ResendOtpEvent(widget.phoneNumber));
                                        startResendTimer();
                                      }
                                    : null, // Disable when timer is running
                                child: Text(
                                  _canResend
                                      ? 'Resend OTP'
                                      : 'Resend in $_resendTimer sec',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: _canResend
                                        ? MYColors.hyperlinkUnvisited
                                        : MYColors.hyperlinkVisited,
                                  ),
                                ),
                              ),
                              verticalSpace(MySizes.spaceBtwSectionsLg.r),
                              state is AuthLoading
                                  ? const CircularProgressIndicator()
                                  : MYElevatedButton(
                                      onPressed: state is AuthLoading
                                          ? null
                                          : () {
                                              final otp = _otp;
                                              if (otp.isNotEmpty) {
                                                context.read<AuthBloc>().add(
                                                    VerifyOtpEvent(
                                                        widget.phoneNumber,
                                                        otp));
                                              } else {
                                                Bars.showCustomToast(
                                                    context: context,
                                                    message:
                                                        'Please enter the OTP');
                                              }
                                            },
                                      child: const Text("Verify OTP"),
                                    )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

}
