import 'package:cakeapp/data/modals/cake.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  const CartState({this.listCake});

  final List<CakeResponse>? listCake;

  CartState copyWith({
    List<CakeResponse>? listCake,
  }) {
    return CartState(
      listCake: listCake ?? this.listCake,
    );
  }

  @override
  List<Object?> get props => [listCake];
}