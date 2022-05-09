import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/data/modals/category.dart';
import 'package:equatable/equatable.dart';

class ShopState extends Equatable {
  const ShopState({
    this.listCake = const [],
    this.listCategory = const [],
    this.isLoading = false,
  });

  final List<CakeResponse> listCake;
  final List<CategoryResponse> listCategory;
  final bool isLoading;

  @override
  List<Object?> get props => [
        listCake,
        listCategory,
        isLoading,
      ];

  ShopState copyWith({
    List<CakeResponse>? listCake,
    List<CategoryResponse>? listCategory,
    bool? isLoading,
  }) {
    return ShopState(
      listCake: listCake ?? this.listCake,
      listCategory: listCategory ?? this.listCategory,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
