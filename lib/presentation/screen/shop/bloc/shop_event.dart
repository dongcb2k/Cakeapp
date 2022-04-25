import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetShopEvent extends ShopEvent {}
