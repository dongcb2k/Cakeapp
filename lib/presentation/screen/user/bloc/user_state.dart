import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState({
    this.phone = '',
  });

  final String phone;

  @override
  List<Object?> get props => [
        phone,
      ];

  UserState copyWith({
    String? phone,
  }) {
    return UserState(
      phone: phone ?? this.phone,
    );
  }
}
