import 'package:equatable/equatable.dart';

class PhoneVerifyState extends Equatable {
  const PhoneVerifyState({
    this.phone = '',
    this.otp = '',
    this.error = '',
    this.verificationId = '',
    this.isLoading = false,
    this.isVerifySuccess = false,
  });

  final String phone;
  final String otp;
  final String error;
  final String verificationId;
  final bool isLoading;
  final bool isVerifySuccess;

  @override
  List<Object> get props => [
        phone,
        otp,
        error,
        verificationId,
        isLoading,
        isVerifySuccess,
      ];

  PhoneVerifyState copyWith({
    String? phone,
    String? otp,
    String? error,
    String? verificationId,
    bool? isLoading,
    bool? isVerifySuccess,
  }) {
    return PhoneVerifyState(
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      error: error ?? this.error,
      verificationId: verificationId ?? this.verificationId,
      isLoading: isLoading ?? this.isLoading,
      isVerifySuccess: isVerifySuccess ?? this.isVerifySuccess,
    );
  }
}
