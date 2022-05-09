import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable{
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class NameChangedEvent extends PaymentEvent {
  const NameChangedEvent(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class PhoneNumberChangedEvent extends PaymentEvent {
  const PhoneNumberChangedEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class LocationChangedEvent extends PaymentEvent {
  const LocationChangedEvent(this.location);

  final String location;

  @override
  List<Object> get props => [location];
}
