import 'package:equatable/equatable.dart';
import 'package:infidea_consultancy_app/data/model/user_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String mobile;

  SendOtpEvent(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

class EmailVerifySendOtpEvent extends AuthEvent {
  final String email;

  EmailVerifySendOtpEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class VerifyOtpEvent extends AuthEvent {
  final String mobile;
  final String otp;

  VerifyOtpEvent(this.mobile, this.otp);

  @override
  List<Object?> get props => [mobile, otp];
}

class EmailVerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;

  EmailVerifyOtpEvent(this.email, this.otp);

  @override
  List<Object?> get props => [email, otp];
}

class RegisterNewUserEvent extends AuthEvent {
  final UserModel userModel;
  RegisterNewUserEvent(this.userModel);
  @override
  List<Object?> get props => [userModel];
}

class RegisterNewUserFormEvent extends AuthEvent{
  final Map<String,dynamic> formData;
  RegisterNewUserFormEvent(this.formData);
  @override
  List<Object?> get props => [formData];
}

class ResendOtpEvent extends AuthEvent {
  final String mobile;

  ResendOtpEvent(this.mobile);

  @override
  List<Object?> get props => [mobile];
}


class EmailVerifyResendOtpEvent extends AuthEvent {
  final String email;

  EmailVerifyResendOtpEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class CheckAppStatusEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

