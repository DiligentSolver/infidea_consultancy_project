import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../core/utils/exception_handling/exceptions.dart';
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

        if (userData.containsKey('user')) {
          final user = UserModel.fromJson(userData['user']);
          emit(Authenticated(user));
        } else {
          // Handle the case where 'user' key is missing
          emit(Unauthenticated());
        }

      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      await _emitErrorState(e, emit);
    } finally {
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
      if (user == null) return emit(AuthError(UnknownException().toString()));
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
    if (error is NoInternetException) {
      emit(NoInternetState());
    } else if (error is BadRequestException ||
        error is UnauthorizedException ||
        error is NotFoundException ||
        error is ServerException) {
      emit(AuthError(error.toString()));
    } else if (error is Map<String, dynamic> &&
        error.containsKey('code') &&
        error.containsKey('user')) {
      try {
        if (error.containsKey('token')) {
          await authRepository.saveToken(error['token']);
        }
        emit(NewUserState());
      } catch (e) {
        emit(AuthError("Failed to setup user."));
      }
    } else {
      emit(AuthError("An unexpected error occurred."));
    }
  }


}