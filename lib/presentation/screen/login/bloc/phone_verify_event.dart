import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneVerifyEvent extends Equatable {
  const PhoneVerifyEvent();

  @override
  List<Object> get props => [];
}

class PhoneChangedEvent extends PhoneVerifyEvent {
  const PhoneChangedEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class OtpChangedEvent extends PhoneVerifyEvent {
  const OtpChangedEvent(this.otp);

  final String otp;
}

class SendOtpSmsEvent extends PhoneVerifyEvent {
  const SendOtpSmsEvent(this.phone);

  final String phone;
}

class VerifyOtpEvent extends PhoneVerifyEvent {
  final String otpCode;
  final String verificationId;

  const VerifyOtpEvent(this.otpCode, this.verificationId);

  @override
  List<Object> get props => [otpCode, verificationId];
}

class OnPhoneOtpSent extends PhoneVerifyEvent {
  final String verificationId;
  final int? token;

  const OnPhoneOtpSent({
    required this.verificationId,
    required this.token,
  });

  @override
  List<Object> get props => [verificationId];
}

class OnPhoneAuthErrorEvent extends PhoneVerifyEvent {
  final String error;

  const OnPhoneAuthErrorEvent({required this.error});

  @override
  List<Object> get props => [error];
}

class OnPhoneAuthVerificationCompleteEvent extends PhoneVerifyEvent {
  final AuthCredential credential;

  const OnPhoneAuthVerificationCompleteEvent({
    required this.credential,
  });
}
