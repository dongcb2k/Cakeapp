
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddItemEvent extends CartEvent {}

class RemoveItemEvent extends CartEvent {}
