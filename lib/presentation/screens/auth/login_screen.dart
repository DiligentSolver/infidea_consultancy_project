import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infidea_consultancy_app/core/utils/constants/colors.dart';
import 'package:infidea_consultancy_app/core/utils/constants/images.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/bars.dart';
import 'package:infidea_consultancy_app/core/utils/helpers/helper_functions.dart';
import 'package:infidea_consultancy_app/core/utils/text_styles/text_styles.dart';
import 'package:infidea_consultancy_app/presentation/widgets/input_fields/text_form_field.dart';
import '../../../core/utils/validators/validator.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_event.dart';
import '../../../logic/blocs/auth/auth_state.dart';
import '../../widgets/buttons/elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isChecked = false;
  bool _isValid = false;

  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(
                horizontal: MySizes.defaultSpace.r), // Responsive padding
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      MyImages
                          .welcomeImg, // You'll need to add this to your assets
                      height: MySizes.imageBannerHeightMd.h,
                      width: MySizes.imageBannerHeightMd.w,
                    ),
                    // Welcome Text
                    RichText(
                        text: TextSpan(
                            children: [
                          TextSpan(
                            text: "Welcome to ",
                            style: MYAppTextStyles.headlineLarge(
                              color: MYAppHelperFunctions.isDarkMode(context)
                                  ? MYColors.darkTextPrimaryColor
                                  : MYColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: "Inf",
                            style: MYAppTextStyles.headlineLarge(
                              color: MYColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: "i",
                            style: MYAppTextStyles.headlineLarge(
                                color: MYColors.secondaryColor),
                          ),
                          TextSpan(
                            text: "dea",
                            style: MYAppTextStyles.headlineLarge(
                              color: MYColors.primaryColor,
                            ),
                          ),
                        ])),
                    // Subtitle
                    Text(
                      "Get start your career now",
                      style: MYAppTextStyles.bodyLarge(
                        color: MYAppHelperFunctions.isDarkMode(context)
                            ? MYColors.darkTextSecondaryColor
                            : MYColors.primaryLightColor,
                      ),
                    ),
                    verticalSpace(MySizes.spaceBtwSectionsLg.r),
                    // Email / Phone Number Field
                    MYInputField(
                      controller: _mobileController,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) =>
                          MYValidator.validatePhoneNumber(value),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: SizedBox(
                          width: 85,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/india-flag-icon.svg',
                                  width: 20,
                                  height: 20),
                              horizontalSpace(10),
                              Text("+91", style: MYAppTextStyles.titleSmall(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value){
                        context.read<AuthBloc>().add(SendOtpEvent(_mobileController.text.replaceAll(" ", "").replaceAll("+91", "")));
                      },
                      hintText: 'Enter your mobile number',
                      labelText: 'Mobile Number',
                      onChanged: (value){
                        if(value.length==10){
                          setState(() {
                            _isValid = true;
                          });
                        }else{
                          setState(() {
                            _isValid = false;
                          });
                        }
                      },
                    ),
                    verticalSpace(MySizes.spaceBtwItems.r),
                    // Terms and Conditions with Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: _onCheckboxChanged,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/termsAndConditions'),
                            child: RichText(
                              text: TextSpan(
                                text: "By continuing, you agree to our ",
                                style: MYAppTextStyles.bodyLarge(color: MYAppHelperFunctions.isDarkMode(context)?MYColors.darkTextPrimaryColor:MYColors.textPrimaryColor),
                                children: [
                                  TextSpan(
                                    text: "Terms of Services and Privacy Policy",
                                    style: MYAppTextStyles.bodyLarge(color: MYColors.hyperlinkUnvisited),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(MySizes.spaceBtwSections.r),
                    // Bloc Consumer for Auth State
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        // Format the phone number before passing
                        final formattedNumber = _mobileController.text
                            .replaceAll(" ", "")
                            .replaceAll("+91", "");

                        if (state is OtpSent) {
                          Navigator.pushNamed(
                            context,
                            '/otpVerificationPage',
                            arguments: formattedNumber,
                          );
                        } else if (state is AuthError) {
                          Bars.showErrorSnackBar(context: context, title: state.message);
                        }
                      },
                      builder: (context, state) {
                        return state is AuthLoading
                            ? const CircularProgressIndicator()
                            : // Login Button
                        MYElevatedButton(
                          onPressed: _isChecked&&_isValid? () {
                            if (_formKey.currentState!.validate()&&_isChecked) {
                               state is AuthLoading ? null : context.read<AuthBloc>().add(SendOtpEvent(_mobileController.text.replaceAll(" ", "").replaceAll("+91", "")));
                            }
                          }:null,
                          child: const Text("Start"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}