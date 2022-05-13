import 'dart:async';

import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/domain/local/local_data.dart';
import 'package:cakeapp/domain/usecase/shop/shop_item_usecase.dart';
import 'package:cakeapp/domain/usecase/voucher/voucher_usecase.dart';
import 'package:cakeapp/main.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sp_util/sp_util.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._shopItemUseCase, this._localData, this._voucherUseCase)
      : super(const CartState()) {
    on<AddCartEvent>(_checkAddItemToCart);

    on<GetAllCartEvent>(_getAllItemCart);

    on<RemoveItemByIdEvent>(_removeItemById);

    on<RemoveAllItemEvent>(((event, emit) {
      emit(state.copyWith(
          listCake: [],
          percent: 0,
          description: '',
          freeship: true,
          subPrice: 0));
      SpUtil.clear();
    }));

    on<GetAllVoucher>(_getAllVoucher);

    on<PickVoucherEvent>(_pickVoucher);

    on<IncreaseCount>(_increaseCount);

    on<DecreaseCount>(_decreaseCount);
  }

  final GetShopItemUseCase _shopItemUseCase;
  final GetVoucherUseCase _voucherUseCase;
  final LocalData _localData;

  Future<void> _checkAddItemToCart(
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

  Future<void> _getAllItemCart(
    GetAllCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final listCart = await _localData.getAllCart;
    double sum = _calculatePrice(listCart);

    emit(state.copyWith(listCake: listCart, subPrice: sum));
  }

  Future<void> _removeItemById(
    RemoveItemByIdEvent event,
    Emitter<CartState> emit,
  ) async {
    final id = event.id;
    final List<CakeResponse>? listCake = await _localData.getAllCart;
    final cake = listCake!.firstWhere((element) => element.id == id);
    var sum = 0.0;

    if(cake.count != null) {
      sum = state.subPrice - cake.price * cake.count!.toDouble();
    }

    listCake.removeWhere((element) => element.id == id);

    emit(state.copyWith(listCake: listCake, subPrice: sum, freeship: false));
    await _localData.saveItemCart(listCake);
  }

  Future<void> _getAllVoucher(
    GetAllVoucher event,
    Emitter<CartState> emit,
  ) async {
    final res = await _voucherUseCase.execute();

    if (res.isRight) {
      emit(state.copyWith(listVoucher: res.right, freeship: true));
    } else {
      logger.d('VOUCHER FAIL');
    }
  }

  Future<void> _pickVoucher(
    PickVoucherEvent event,
    Emitter<CartState> emit,
  ) async {
    final freeShip = event.freeship;

    emit(state.copyWith(
      subPrice: state.subPrice,
      freeship: freeShip,
      description: event.description,
      percent: freeShip ? 0 : event.percent,
    ));
  }

  Future<void> _increaseCount(
    IncreaseCount event,
    Emitter<CartState> emit,
  ) async {
    final int index = event.index;
    final List<CakeResponse>? listCake = await _localData.getAllCart;

    listCake![index].count = listCake[index].count! + 1;

    emit(state.copyWith(
        listCake: listCake, subPrice: _calculatePrice(listCake), freeship: false));
    await _localData.saveItemCart(listCake);
  }

  Future<void> _decreaseCount(
    DecreaseCount event,
    Emitter<CartState> emit,
  ) async {
    final int index = event.index;
    final List<CakeResponse>? listCake = await _localData.getAllCart;

    if (listCake![index].count! > 1) {
      listCake[index].count = listCake[index].count!- 1;
    }

    emit(state.copyWith(
        listCake: listCake, subPrice: _calculatePrice(listCake), freeship: false));
    await _localData.saveItemCart(listCake);
  }

  double _calculatePrice(List<CakeResponse>? listCart) {
    var sum = 0.0;
    for (var cake in listCart!) {
      sum += cake.price * (cake.count ?? 1);
    }
    return sum;
  }
}
