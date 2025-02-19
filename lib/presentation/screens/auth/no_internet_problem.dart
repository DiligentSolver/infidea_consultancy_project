import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_event.dart';
import '../../../logic/blocs/auth/auth_state.dart';
import '../../widgets/buttons/elevated_button.dart';

class NoInternetProblem extends StatefulWidget {
  const NoInternetProblem({super.key});

  @override
  State<NoInternetProblem> createState() => _NoInternetProblemState();
}

class _NoInternetProblemState extends State<NoInternetProblem> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off,size: MySizes.iconXxl*2,color: MYColors.errorColor,),
                verticalSpace(20),
                Text(
                    "No Internet Connection",
                    style: MYAppTextStyles.headlineSmall()
                ),
                verticalSpace(10),
                Text(
                    "Please check your internet connection and try again.",
                    style:  MYAppTextStyles.bodyMedium()
                ),
                verticalSpace(30),
                // Bloc Consumer
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is Authenticated) {
                      Navigator.popAndPushNamed(context, '/profileData');
                    } else if(state is NewUserState){
                      Navigator.pushReplacementNamed(
                          context,'/stepOneCollection');
                    }else if(state is Unauthenticated){
                      Navigator.pushReplacementNamed(
                          context,'/login');
                    }
                    else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return state is AuthLoading
                    ? const CircularProgressIndicator():SizedBox(
                      width: MySizes.buttonWidth,
                      child: MYElevatedButton(
                        onPressed: state is Authenticated
                            ? null
                            : () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(CheckAppStatusEvent());
                        },
                        child: const Text(
                          "Retry",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
