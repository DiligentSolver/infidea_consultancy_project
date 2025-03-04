import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<CheckAuthEvent>(_onCheckAuth);
    on<LogoutEvent>(_onLogout);
    on<SendNewUserOtpEvent>(_onSendNewUserOtp);
    on<ResendNewUserOtpEvent>(_onResendNewUserOtp);
    on<VerifyNewUserOtpEvent>(_onVerifyNewUserOtp);
  }

  Future<void> _onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // Check network connection before proceeding
    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      final token = await authRepository.getToken();
      if (token == null || token.isEmpty) {
        return emit(Unauthenticated());
      }

      final userData = await authRepository.fetchUserDetails(token);
      debugPrint("$userData");
      if (userData == null) {
        return emit(Unauthenticated());
      }

      emit(Authenticated(UserModel.fromJson(userData)));
    } catch (e) {
      _emitErrorState(e, emit);
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
      _emitErrorState(e, emit);
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      final user = await authRepository.verifyOtp(event.mobile, event.otp);
      if (user == null) return emit(AuthError("Invalid OTP"));

      emit(Authenticated(user));
    } catch (e) {
      _emitErrorState(e, emit);
    }
  }

  Future<void> _onResendOtp(ResendOtpEvent event, Emitter<AuthState> emit) async {
    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      await authRepository.resendOtp(event.mobile);
      emit(OtpResent());
    } catch (e) {
      _emitErrorState(e, emit);
    }
  }
  Future<void> _onSendNewUserOtp(SendNewUserOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      await authRepository.sendNewUserOtp(event.mobile);
      emit(NewUserOtpSent());
    } catch (e) {
      _emitErrorState(e, emit);
    }
  }


  Future<void> _onVerifyNewUserOtp(VerifyNewUserOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      final user = await authRepository.verifyNewUserOtp(event.name,event.email,event.age,event.gender,event.mobile,event.otp);
      if (user == null) return emit(AuthError("Invalid OTP"));

      emit(Authenticated(user));
    } catch (e) {
      _emitErrorState(e, emit);
    }
  }

  Future<void> _onResendNewUserOtp(ResendNewUserOtpEvent event, Emitter<AuthState> emit) async {
    if (!(await _isConnected())) {
      return emit(NoInternetState());
    }

    try {
      await authRepository.resendNewUserOtp(event.mobile);
      emit(NewUserOtpResent());
    } catch (e) {
      _emitErrorState(e, emit);
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

  void _emitErrorState(dynamic error, Emitter<AuthState> emit) {
    if (error.toString().contains("No Internet Connection")) {
      emit(NoInternetState());
    } else if (error.toString().contains("Server Problem")) {
      emit(ServerProblemState());
    } else {
      emit(AuthError(error.toString()));
    }
  }
}
