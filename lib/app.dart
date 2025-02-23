import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infidea_consultancy_app/logic/blocs/form/form_bloc.dart';
import 'package:infidea_consultancy_app/presentation/screens/auth/error_screen.dart';
import 'package:infidea_consultancy_app/presentation/screens/auth/login_screen.dart';
import 'package:infidea_consultancy_app/presentation/screens/auth/no_internet_notifier_screen.dart';
import 'package:infidea_consultancy_app/presentation/screens/auth/no_internet_problem.dart';
import 'package:infidea_consultancy_app/presentation/screens/auth/otp_verification_screen.dart';
import 'package:infidea_consultancy_app/presentation/screens/auth/server_problem_screen.dart';
import 'package:infidea_consultancy_app/presentation/screens/auth/terms&conditions.dart';
import 'package:infidea_consultancy_app/presentation/screens/home/home_screen.dart';
import 'package:infidea_consultancy_app/presentation/screens/onboarding/onboarding.dart';
import 'package:infidea_consultancy_app/presentation/screens/profile/form_pages.dart';
import 'package:infidea_consultancy_app/presentation/screens/profile/stepFourCollection.dart';
import 'package:infidea_consultancy_app/presentation/screens/profile/stepTwoCollection.dart';
import 'package:infidea_consultancy_app/presentation/screens/profile/stepfivecollection.dart';
import 'package:infidea_consultancy_app/presentation/screens/profile/steponecollection.dart';
import 'package:infidea_consultancy_app/presentation/screens/profile/stepthreecollection.dart';
import 'core/utils/theme/theme.dart';
import 'data/repositories/auth_repository.dart';
import 'logic/blocs/auth/auth_bloc.dart';
import 'logic/blocs/auth/auth_event.dart';
import 'logic/blocs/auth/auth_state.dart';

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  final AuthRepository authRepository;
  final String? token;

  const MyApp({
    super.key,
    required this.isFirstLaunch,
    required this.authRepository,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      connectionNotificationOptions: const ConnectionNotificationOptions(
        disconnectedConnectionNotification: NoInternetNotifierScreen(),
        animationDuration: Duration(seconds: 1),
        height: 50,
        connectedBackgroundColor: Colors.green,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
            AuthBloc(authRepository)..add(CheckAppStatusEvent()),
          ), BlocProvider<FormBloc>(
            create: (context) =>
           FormBloc(authRepository),
            lazy: false,
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812), // iPhone X
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: MYAppTheme.lightTheme,
                darkTheme: MYAppTheme.darkTheme,
                themeMode: ThemeMode.system,
                home: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is Authenticated) {
                      Navigator.pushReplacementNamed(
                        context,'/homeScreen');
                    } else if (state is Unauthenticated) {
                      if (isFirstLaunch) {
                        Navigator.pushReplacementNamed(
                            context,'/onboarding');
                      } else {
                        Navigator.pushReplacementNamed(
                            context,'/login');
                      }
                    } else if (state is NoInternetState) {
                      Navigator.pushReplacementNamed(
                          context,'/internetProblem');
                    } else if (state is ServerProblemState) {
                      Navigator.pushReplacementNamed(
                          context,'/serverProblem');
                    } else if (state is NewUserState) {
                      Navigator.pushReplacementNamed(
                          context,'/formPages');
                    }
                    else if(state is AuthError){
                      Navigator.pushReplacementNamed(
                          context,'/login');
                    }
                  },
                  child: const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                routes: {
                  '/onboarding': (context) => const OnboardingScreen(),
                  '/internetProblem': (context) => const NoInternetProblem(),
                  '/serverProblem': (context) => const ServerProblemScreen(),
                  '/login': (context) => const LoginScreen(),
                  '/termsAndConditions': (context) => const TermsAndConditionsPage(),
                  '/stepOneCollection': (context) => const StepOneCollection(),
                  '/stepTwoCollection': (context) => const StepTwoCollection(),
                  '/stepThreeCollection': (context) => const StepThreeCollection(),
                  '/stepFourCollection': (context) => const StepFourCollection(),
                  '/stepFiveCollection': (context) => const StepFiveCollection(),
                  '/formPages': (context) => const MultiStepFormPageView(),
                  '/errorScreen': (context)=> const ErrorScreen(),
                  '/homeScreen': (context)=> const HomePage(),
                  '/otpVerificationPage': (context) {
                    final phoneNumber =
                        ModalRoute.of(context)?.settings.arguments as String? ??
                            '';
                    return OTPVerificationScreen(phoneNumber: phoneNumber);
                  },
                },
              ),
            );
          },
        ),
      ),
    );
  }
}