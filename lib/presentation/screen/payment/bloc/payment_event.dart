import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class NameChangedEvent extends PaymentEvent {}

class PhoneNumberChangedEvent extends PaymentEvent {}

class LocationChangedEvent extends PaymentEvent {}
