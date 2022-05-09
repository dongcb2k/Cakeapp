import 'dart:async';

import 'package:cakeapp/domain/usecase/shop/category_usecase.dart';
import 'package:cakeapp/domain/usecase/shop/shop_item_usecase.dart';
import 'package:cakeapp/main.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_event.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc(this._shopItemUseCase, this._getCategoryUseCase)
      : super(const ShopState()) {
    on<GetShopEvent>(_getShopEvent);

    on<GetCategoryEvent>(_getCategoryEvent);

    on<FilterDataEvent>(_filterDataEvent);
  }

  final GetShopItemUseCase _shopItemUseCase;
  final GetCategoryUseCase _getCategoryUseCase;

  Future<void> _getShopEvent(
    GetShopEvent event,
    Emitter<ShopState> emit,
  ) async {
    final resShop = await _shopItemUseCase.execute();

    if (resShop.isRight) {
      emit(state.copyWith(
        listCake: resShop.right,
      ));
    } else {
      logger.d("FAIL Shop Item");
    }
  }

  Future<void> _getCategoryEvent(
      GetCategoryEvent event,
      Emitter<ShopState> emit,
      ) async {
    final res = await _getCategoryUseCase.execute();

    if (res.isRight) {
      emit(state.copyWith(
        listCategory: res.right,
      ));
    } else {
      logger.d("FAIL Category");
    }
  }

  Future<void> _filterDataEvent(
    FilterDataEvent event,
    Emitter<ShopState> emit,
  ) async {
    final filterString = event.categoryFilter;
    final res = await _shopItemUseCase.execute();

    if (res.isRight) {
      final listFilter = res.right.where((element) => element.category == filterString).toList();

      emit(state.copyWith(listCake: listFilter));
    } else {
      logger.d("FAIL Filter Item");
    }
  }
}
