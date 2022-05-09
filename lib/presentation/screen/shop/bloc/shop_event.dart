import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetShopEvent extends ShopEvent {}

class GetCategoryEvent extends ShopEvent {}

class FilterDataEvent extends ShopEvent {
  FilterDataEvent(this.categoryFilter);

  final String categoryFilter;

  @override
  List<Object?> get props => [categoryFilter];
}
