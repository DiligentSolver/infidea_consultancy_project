import 'package:equatable/equatable.dart';

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

class VerifyOtpEvent extends AuthEvent {
  final String mobile;
  final String otp;

  VerifyOtpEvent(this.mobile, this.otp);

  @override
  List<Object?> get props => [mobile, otp];
}

class ResendOtpEvent extends AuthEvent {
  final String mobile;

  ResendOtpEvent(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

class VerifyNewUserOtpEvent extends AuthEvent {
  final String mobile;
  final String otp;
  final String name;
  final String email;
  final String age;
  final String gender;

  VerifyNewUserOtpEvent(this.mobile, this.otp, this.name, this.email, this.age, this.gender);
  @override
  List<Object?> get props => [mobile, otp,name,email,age,gender];
}

class SendNewUserOtpEvent extends AuthEvent {
  final String mobile;

  SendNewUserOtpEvent(this.mobile);
  @override
  List<Object?> get props => [mobile];
}

class ResendNewUserOtpEvent extends AuthEvent {
  final String mobile;

  ResendNewUserOtpEvent(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

class CheckAuthEvent extends AuthEvent {}


class LogoutEvent extends AuthEvent {}

