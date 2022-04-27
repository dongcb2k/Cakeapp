import 'dart:async';

import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/domain/local/local_data.dart';
import 'package:cakeapp/domain/usecase/shop/shop_item_usecase.dart';
import 'package:cakeapp/main.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._shopItemUseCase, this._localData) : super(const CartState()) {
    on<AddCartEvent>(_checkAddItemToCart);
    on<GetAllCartEvent>(_getAllItemCart);
  }

  final GetShopItemUseCase _shopItemUseCase;
  final LocalData _localData;

  FutureOr<void> _checkAddItemToCart(
    AddCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final res = await _shopItemUseCase.execute();
    final id = event.id;

    if (res.isRight) {
      List<CakeResponse>? listCake = await _localData.getAllCart;
      final cake = res.right.firstWhere((element) => element.id == id);

      if (listCake != null) {
        listCake.add(cake);
      } else {
        listCake = [cake];
      }
      logger.d('CLICK ADD ' + listCake.toString());
      await _localData.saveItemCart(listCake);
    }
  }

  FutureOr<void> _getAllItemCart(
    GetAllCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final listCart = await _localData.getAllCart;
    logger.d('GET DATA: ' + listCart.toString());
    emit(state.copyWith(listCake: listCart));
  }
}
