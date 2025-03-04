import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:infidea_consultancy_app/repository/onboarding_repository.dart';
import 'package:infidea_consultancy_app/screens/application_screen.dart';
import 'package:infidea_consultancy_app/screens/application_status.dart';
import 'package:infidea_consultancy_app/screens/drawer/notifications_screen.dart';
import 'package:infidea_consultancy_app/screens/edit_screens/education_screen.dart';
import 'package:infidea_consultancy_app/screens/edit_screens/job_preferences_screen.dart';
import 'package:infidea_consultancy_app/screens/edit_screens/personal_details_screen.dart';
import 'package:infidea_consultancy_app/screens/edit_screens/profile_screen.dart';
import 'package:infidea_consultancy_app/screens/edit_screens/resume_screen.dart';
import 'package:infidea_consultancy_app/screens/edit_screens/skills_screen.dart';
import 'package:infidea_consultancy_app/screens/edit_screens/work_experience_screen.dart';
import 'package:infidea_consultancy_app/screens/forms/form_screen_1.dart';
import 'package:infidea_consultancy_app/screens/forms/form_screen_2.dart';
import 'package:infidea_consultancy_app/screens/forms/form_screen_3.dart';
import 'package:infidea_consultancy_app/screens/forms/form_screen_4.dart';
import 'package:infidea_consultancy_app/screens/forms/form_screen_5.dart';
import 'package:infidea_consultancy_app/screens/home_screen.dart';
import 'package:infidea_consultancy_app/screens/interview_screen.dart';
import 'package:infidea_consultancy_app/screens/job_screen.dart';
import 'package:infidea_consultancy_app/screens/no_internet_notifier_screen.dart';
import 'package:infidea_consultancy_app/screens/no_internet_problem.dart';
import 'package:infidea_consultancy_app/screens/onboarding_screen.dart';
import 'package:infidea_consultancy_app/screens/otp_verification_screen.dart';
import 'package:infidea_consultancy_app/screens/profile_details_screen.dart';
import 'package:infidea_consultancy_app/screens/profile_screen.dart';
import 'package:infidea_consultancy_app/screens/search_screen.dart';
import 'package:infidea_consultancy_app/screens/server_problem_screen.dart';
import 'package:infidea_consultancy_app/screens/terms&conditions.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_event.dart';
import 'bloc/auth/auth_state.dart';
import 'core/theme/app_theme.dart';
import 'repository/auth_repository.dart';
import 'screens/login_screen.dart';


Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); // Ensure widget binding is initialized

  // Preserve splash screen while loading data
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize repositories
  final AuthRepository authRepository = AuthRepository();
  //final VideosRepository videosRepository = VideosRepository();
  final OnboardingRepository onboardingRepository = OnboardingRepository();

  // Load token and first-time status
  String? token = await authRepository.getToken();
  bool isFirstTime = await onboardingRepository.checkFirstTime(); // Ensure it's not null

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    authRepository: authRepository,
    //videosRepository: videosRepository,
    token: token,
    isFirstTime: isFirstTime,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final String? token;
  final bool isFirstTime;

  const MyApp({
    super.key,
    required this.authRepository,
    this.token,
    required this.isFirstTime,
  });

  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      connectionNotificationOptions: const ConnectionNotificationOptions(
          disconnectedConnectionNotification: NoInternetNotifierScreen(),
          animationDuration: Duration(seconds: 1),
          height: 50,
          connectedBackgroundColor: Colors.green
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository)..add(CheckAuthEvent()),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          home: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              debugPrint("Auth State Changed: $state");

              Future.delayed(const Duration(milliseconds: 200), () {
                if (state is Authenticated) {
                  debugPrint("Navigating to /homeView...");
                  Navigator.pushReplacementNamed(context, '/homeScreen');
                } else if (state is Unauthenticated) {
                  debugPrint("Navigating to Login...");
                  Navigator.pushReplacementNamed(
                      context, isFirstTime ? '/onBoarding' : '/homeScreen');
                } else if (state is ServerProblemState) {
                  debugPrint("Navigating to Server Problem Page...");
                  Navigator.pushReplacementNamed(context, '/serverProblem');
                } else if (state is NoInternetState) {
                  debugPrint("Navigating to No Internet Page...");
                  Navigator.pushReplacementNamed(context, '/noInternet');
                }
              });
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return _getScreenForState(state);
              },
            ),
          ),
          routes: {
            '/onBoarding':(context) => const OnboardingScreen(),
            '/formScreen1':(context) =>  const FormScreen1(),
            '/formScreen2':(context) =>  const FormScreen2(),
            '/formScreen3':(context) =>  const FormScreen3(),
            '/formScreen4':(context) =>  const FormScreen4(),
            //'/formScreen5':(context) =>  const FormScreen5(),
            '/login': (context) => const LoginScreen(),
            '/verifyOtp': (context) => OtpVerificationScreen(
              mobile: ModalRoute.of(context)!.settings.arguments as String,
            ),
            '/termsAndConditions': (context) => const TermsAndConditionsPage(),
            '/homeScreen': (context) =>  const HomeScreen(),
            '/jobScreen': (context) =>  const JobsScreen(),
            '/searchScreen': (context) => const SearchScreen(),
            '/serverProblem': (context) => const ServerProblemScreen(),
            '/noInternet': (context) => const NoInternetProblem(),
            '/homeView': (context) => const HomeScreen(),
            '/application': (context) => MyApplicationsScreen(),
            '/interview': (context) =>  InterviewScreen(),
            '/profileDetails': (context) =>  ProfileDetailsScreen(),
            '/edit_job_preferences': (context) =>  JobPreferencesScreen(),
            '/edit_resume': (context) =>  EditResumeScreen(),
            '/edit_work_experience': (context) =>  EditWorkExperienceScreen(experiences: [],),
            '/edit_skills': (context) =>  EditSkillsScreen(skills: [],),
            '/edit_education': (context) =>  EditEducationScreen(),
            '/edit_profile': (context) =>  EditProfileScreen(),
            '/edit_personal_details': (context) => EditPersonalDetailsScreen(),
            '/notifications': (context) =>const NotificationsScreen(),


          },
        ),
      ),
    );
  }

  Widget _getScreenForState(AuthState state) {
    // Remove splash screen after initialization
    Future.delayed(const Duration(seconds: 3),(){FlutterNativeSplash.remove();});
    if (state is Authenticated) {
      return const ProfilePage();
    } else {
      return isFirstTime ? const OnboardingScreen() :  const HomeScreen();
    }
  }
}



