import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddCartEvent extends CartEvent {
  const AddCartEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class GetAllCartEvent extends CartEvent {}

class RemoveItemByIdEvent extends CartEvent {
  const RemoveItemByIdEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class RemoveAllItemEvent extends CartEvent {}
