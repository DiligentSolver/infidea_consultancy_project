import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/core/utils/constants/sizes.dart';
import 'package:infidea_consultancy_app/presentation/widgets/buttons/elevated_button.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/text_styles/text_styles.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/blocs/auth/auth_event.dart';
import '../../../logic/blocs/auth/auth_state.dart';

class ServerProblemScreen extends StatefulWidget {
  const ServerProblemScreen({super.key});

  @override
  State<ServerProblemScreen> createState() => _ServerProblemScreenState();
}

class _ServerProblemScreenState extends State<ServerProblemScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                verticalSpace(20.r),
                Text(
                  "Oops!\nThere is a problem with the server.",
                  style: MYAppTextStyles.titleMedium(),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(10.r),
                Text(
                  "Please try again later.",
                  style: MYAppTextStyles.bodyMedium(),
                ),
                verticalSpace(30.r),
                // Bloc Consumer
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    print('Current state: $state'); // Debugging line
                    if (state is Authenticated) {
                      Navigator.popAndPushNamed(context, '/profileData');
                    } else if(state is Unauthenticated){
                      Navigator.pushReplacementNamed(
                          context,'/login');
                    } else if(state is NewUserState){
                      Navigator.pushReplacementNamed(
                          context,'/stepOneCollection');
                    }
                    else if (state is AuthError) {
                      Navigator.pushReplacementNamed(
                          context,'/login');
                    }
                  },
                  builder: (context, state) {
                    return state is AuthLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
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
