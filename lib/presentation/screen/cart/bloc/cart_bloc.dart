import 'dart:async';

import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/domain/local/local_data.dart';
import 'package:cakeapp/domain/usecase/shop/shop_item_usecase.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sp_util/sp_util.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._shopItemUseCase, this._localData) : super(const CartState()) {
    on<AddCartEvent>(_checkAddItemToCart);
    on<GetAllCartEvent>(_getAllItemCart);
    on<RemoveItemByIdEvent>(_removeItemById);
    on<RemoveAllItemEvent>(((event, emit) {
      emit(state.copyWith(listCake: []));
      SpUtil.clear();
    }));
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
      var _checkExist = false;

      if (listCake != null && listCake.isNotEmpty) {
        for (var element in listCake) {
          if (element.id == id) {
            _checkExist = true;
          }
        }
        if (_checkExist == false) {
          listCake.add(cake);
        }
      } else {
        listCake = [cake];
      }
      await _localData.saveItemCart(listCake);
    }
  }

  FutureOr<void> _getAllItemCart(
    GetAllCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final listCart = await _localData.getAllCart;
    var sum = 0;
    for(var cake in listCart!) {
      sum += cake.price;
    }

    emit(state.copyWith(listCake: listCart, price: sum));
  }

  FutureOr<void> _removeItemById(
    RemoveItemByIdEvent event,
    Emitter<CartState> emit,
  ) async {
    final id = event.id;
    final List<CakeResponse>? listCake = await _localData.getAllCart;
    final sum = state.price - listCake!.firstWhere((element) => element.id == id).price;

    listCake.removeWhere((element) => element.id == id);

    emit(state.copyWith(listCake: listCake, price: sum));
    await _localData.saveItemCart(listCake);
  }
}
