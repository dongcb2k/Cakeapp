import 'dart:async';

import 'package:cakeapp/domain/local/local_data.dart';
import 'package:cakeapp/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'phone_verify_event.dart';
import 'phone_verify_state.dart';

@Singleton()
@injectable
class PhoneVerifyBloc extends Bloc<PhoneVerifyEvent, PhoneVerifyState> {
  PhoneVerifyBloc(this._authRepository, this._localData)
      : super(const PhoneVerifyState()) {
    on<PhoneChangedEvent>(
        (event, emit) => emit(state.copyWith(phone: event.phone)));

    on<OtpChangedEvent>((event, emit) => emit(state.copyWith(otp: event.otp)));

    on<SendOtpSmsEvent>(_sendOtpEvent);

    on<VerifyOtpEvent>(_onVerifyOtp);

    on<OnPhoneOtpSent>((event, emit) =>
        emit(state.copyWith(verificationId: event.verificationId)));

    on<OnPhoneAuthErrorEvent>(
        (event, emit) => emit(state.copyWith(error: event.error)));

    on<OnPhoneAuthVerificationCompleteEvent>(_loginWithCredential);
  }

  final AuthRepository _authRepository;
  final LocalData _localData;

  Future<void> _sendOtpEvent(
    SendOtpSmsEvent event,
    Emitter<PhoneVerifyState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      var phone = event.phone;

      if(phone.startsWith('0')) {
        phone = phone.replaceFirst('0', '+84');
      }

      await _authRepository.signInWithPhone(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // On [verificationComplete], we will get the credential from the firebase
          // and will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc
          // and then will emit the [PhoneAuthVerified] state after successful login
          add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
        },
        codeSent: (String verificationId, int? resendToken) {
          // On [codeSent], we will get the verificationId and the resendToken from the firebase
          // and will send it to the [OnPhoneOtpSent] event to be handled by the bloc
          // and then will emit the [OnPhoneAuthVerificationCompleteEvent] event after receiving the code from the user's phone
          add(OnPhoneOtpSent(
              verificationId: verificationId, token: resendToken));
        },
        verificationFailed: (FirebaseAuthException e) {
          // On [verificationFailed], we will get the exception from the firebase
          // and will send it to the [OnPhoneAuthErrorEvent] event to be handled by the bloc
          // and then will emit the [PhoneAuthError] state in order to display the error to the user's screen
          add(OnPhoneAuthErrorEvent(error: e.code));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<PhoneVerifyState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      // After receiving the otp, we will verify the otp and then will create a credential from the otp and verificationId and then will send it to the [OnPhoneAuthVerificationCompleteEvent] event to be handled by the bloc and then will emit the [PhoneAuthVerified] state after successful login
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otpCode,
      );
      add(OnPhoneAuthVerificationCompleteEvent(credential: credential));
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _loginWithCredential(
    OnPhoneAuthVerificationCompleteEvent event,
    Emitter<PhoneVerifyState> emit,
  ) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(event.credential)
          .then((user) {
        if (user.user != null) {
          emit(state.copyWith(isVerifySuccess: true));
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(error: e.code));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
