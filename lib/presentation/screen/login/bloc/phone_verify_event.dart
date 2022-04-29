import 'package:equatable/equatable.dart';

abstract class PhoneVerifyEvent extends Equatable {
  const PhoneVerifyEvent();

  @override
  List<Object> get props => [];
}

class PhoneInput extends PhoneVerifyEvent {
  const PhoneInput(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}
