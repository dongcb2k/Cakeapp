import 'package:cakeapp/data/modals/cake.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  const CartState({
    this.listCake = const [],
    this.price = 0,
  });

  final List<CakeResponse> listCake;
  final int price;

  @override
  List<Object?> get props => [
        listCake,
        price,
      ];

  CartState copyWith({
    List<CakeResponse>? listCake,
    int? price,
  }) {
    return CartState(
        listCake: listCake ?? this.listCake, price: price ?? this.price);
  }
}
