import 'package:equatable/equatable.dart';
import '../../../data/model/user_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class NewUserState extends AuthState {
}

class OtpSent extends AuthState {} // Added state for OTP sent success

class EmailVerifyOtpSent extends AuthState {} // Added state for OTP sent success

class OtpResent extends AuthState {}

class RegisterNewUser extends AuthState {}

class EmailVerifyOtpResent extends AuthState {}

class ServerProblemState extends AuthState {}

class NoInternetState extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class Authenticated extends AuthState {
  final UserModel user;
  Authenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {}
