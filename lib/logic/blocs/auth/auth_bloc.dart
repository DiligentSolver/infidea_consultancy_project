import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<LogoutEvent>(_onLogout);
    on<RegisterNewUserEvent>(_onRegisterNewUser);
    on<EmailVerifyOtpEvent>(_onVerifyEmailOtp);
    on<EmailVerifySendOtpEvent>(_onEmailVerifySendOtp);
    on<EmailVerifyResendOtpEvent>(_onEmailVerifyResendOtp);
    on<CheckAppStatusEvent>(_onCheckAppStatus);
    on<RegisterNewUserFormEvent>(_onRegisterNewUserForm);
  }

  Future<void> _onCheckAppStatus(CheckAppStatusEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      //  Check internet connection
      if (!(await _isConnected())) {
        emit(NoInternetState());
        return;
      }

      //  Check server status
      final isServerUp = await authRepository.isServerAvailable();
      if (!isServerUp) {
        emit(ServerProblemState());
        return;
      }

      //  Check login status
      final isLoggedIn = await authRepository.isLoggedIn();
      if (isLoggedIn) {
        final token = await authRepository.getToken();
        final userData = await authRepository.fetchUserDetails(token!);

        if (userData != null) {
          final user = UserModel.fromJson(userData);
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      await _emitErrorState(e, emit);
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      FlutterNativeSplash.remove();
    }
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      await authRepository.sendOtp(event.mobile);
      emit(OtpSent());
    } catch (e) {
      await _emitErrorState(e, emit);
    }
  }

  Future<void> _onEmailVerifySendOtp(EmailVerifySendOtpEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      await authRepository.sendVerifyEmailOtp(event.email);
      emit(OtpSent());
    } catch (e) {
      await _emitErrorState(e, emit);
    }
  }


  Future<void> _onVerifyOtp(VerifyOtpEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      final user = await authRepository.verifyOtp(event.mobile, event.otp);
      if (user == null) return emit(AuthError("Invalid OTP"));
      emit(Authenticated(user));
    } catch (e) {
      await _emitErrorState(e, emit);
    }
  }

  Future<void> _onVerifyEmailOtp(EmailVerifyOtpEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      final user = await authRepository.verifyOtp(event.email, event.otp);
      if (user == null) return emit(AuthError("Invalid OTP"));

      emit(Authenticated(user));
    } catch (e) {
      await _emitErrorState(e, emit);
    }
  }

  Future<void> _onRegisterNewUser(RegisterNewUserEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      final user = await authRepository.registerNewUser(event.userModel);
      if (user == null) return emit(AuthError("Invalid OTP"));

      emit(Authenticated(user));
    } catch (e) {
      await _emitErrorState(e, emit);
    }
  }

  Future<void> _onRegisterNewUserForm(RegisterNewUserFormEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      final user = await authRepository.registerNewUserForm(event.formData);
      if (user == null) return emit(AuthError("Problem with registering user"));

      print(user.fatherName);

      emit(Authenticated(user));
    } catch (e) {
      await _emitErrorState(e, emit);
    }
  }

  Future<void> _onResendOtp(ResendOtpEvent event,
      Emitter<AuthState> emit) async {
    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      await authRepository.resendOtp(event.mobile);
      emit(OtpResent());
    } catch (e) {
      await _emitErrorState(e, emit);
    }
  }

  Future<void> _onEmailVerifyResendOtp(EmailVerifyResendOtpEvent event,
      Emitter<AuthState> emit) async {
    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      await authRepository.resendOtp(event.email);
      emit(OtpResent());
    } catch (e) {
      await _emitErrorState(e, emit);
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(Unauthenticated());
  }

  Future<bool> _isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }


  Future<void> _emitErrorState(dynamic error, Emitter<AuthState> emit) async {
    if (error.toString().contains("No Internet Connection")) {
      emit(NoInternetState());
    } else if (error.toString().contains("Server Problem")) {
      emit(ServerProblemState());
    } else if (error is Map<String, dynamic> &&
        error.containsKey('message') &&
        error.containsKey('code') &&
        error.containsKey('user')) {
      try {
        if(error.containsKey('token')){
          await authRepository.saveToken(error['token']);
        }
        emit(NewUserState());
      } catch (e) {
        emit(AuthError("Failed to parse user data: $e"));
      }
    } else {
      emit(AuthError(error.toString()));
    }
  }
}