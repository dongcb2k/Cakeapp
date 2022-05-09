import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  const PaymentState({
    this.name = '',
    this.phoneNumber = '',
    this.location = '',
  });

  final String name;
  final String phoneNumber;
  final String location;

  @override
  List<Object?> get props => [
    name,
    phoneNumber,
    location,
  ];

  PaymentState copyWith({
    String? name,
    String? phoneNumber,
    String? location,
  }) {
    return PaymentState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
    );
  }
}
