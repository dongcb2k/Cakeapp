import 'package:cakeapp/data/modals/cake.dart';
import 'package:equatable/equatable.dart';

class ShopState extends Equatable {
  const ShopState({
    this.listCake,
  });

  final List<CakeResponse>? listCake;


  @override
  List<Object?> get props => [
        listCake,
      ];

  ShopState copyWith({
    List<CakeResponse>? listCake,
  }) {
    return ShopState(
      listCake: listCake ?? this.listCake,
    );
  }
}
