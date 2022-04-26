
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddItemEvent extends CartEvent {
  const AddItemEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class RemoveItemEvent extends CartEvent {}
