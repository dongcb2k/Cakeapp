import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  const PaymentState({
    this.name = '',
    this.phoneNumber = '',
    this.location = '',
    this.isValid = false,
    this.isLoading = false,
  });

  final String name;
  final String phoneNumber;
  final String location;
  final bool isValid;
  final bool isLoading;

  bool isValidField() =>
      name.isNotEmpty && phoneNumber.isNotEmpty && location.isNotEmpty;

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        location,
        isValid,
        isLoading,
      ];

  PaymentState copyWith({
    String? name,
    String? phoneNumber,
    String? location,
    bool? isValid,
    bool? isLoading,
  }) {
    return PaymentState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
