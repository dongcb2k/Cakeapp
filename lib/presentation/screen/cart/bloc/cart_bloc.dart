import 'dart:async';

import 'package:cakeapp/domain/usecase/shop/shop_item_usecase.dart';
import 'package:cakeapp/main.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._shopItemUseCase) : super(const CartState()) {
    on<AddItemEvent>(_checkAddItemToCart);
  }

  final GetShopItemUseCase _shopItemUseCase;

  FutureOr<void> _checkAddItemToCart(
    AddItemEvent event,
    Emitter<CartState> emit,
  ) async {
    final res = await _shopItemUseCase.execute();
    final id = event.id;

    if(res.isRight) {
      final cake = res.right.firstWhere((element) => element.id == id);
      final listCake = [cake];
      logger.d('LIST CART: ' + listCake.toString());
      emit(state.copyWith(listCake: listCake));
    }
  }
}
