import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {

  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LogoutEvent extends UserEvent {}

class GetInfoUserEvent extends UserEvent {}
