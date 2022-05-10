import 'dart:async';

import 'package:cakeapp/data/modals/cart_order.dart';
import 'package:cakeapp/domain/local/local_data.dart';
import 'package:cakeapp/presentation/screen/payment/bloc/payment_event.dart';
import 'package:cakeapp/presentation/screen/payment/bloc/payment_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(this._localData) : super(const PaymentState()) {
    on<NameChangedEvent>(_checkNameChanged);

    on<PhoneNumberChangedEvent>(_checkPhoneChanged);

    on<LocationChangedEvent>(_checkLocationChanged);

    on<OrderEvent>(_orderSuccessEvent);
  }

  final LocalData _localData;

  Future<void> _checkNameChanged(
    NameChangedEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(name: event.name));
    _checkEmpty(emit);
  }

  Future<void> _checkPhoneChanged(
    PhoneNumberChangedEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(phoneNumber: event.phone));
    _checkEmpty(emit);
  }

  Future<void> _checkLocationChanged(
    LocationChangedEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(location: event.location));
    _checkEmpty(emit);
  }

  void _checkEmpty(Emitter<PaymentState> emit) {
    if (state.name.isNotEmpty &&
        state.phoneNumber.isNotEmpty &&
        state.location.isNotEmpty) {
      emit(state.copyWith(isValid: true));
    } else {
      emit(state.copyWith(isValid: false));
    }
  }

  Future<void> _orderSuccessEvent(
    OrderEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final listCake = await _localData.getAllCart;
    String listCakeString = '';
    for (var element in listCake!) {
      listCakeString = listCakeString + '\n' + element.toJson().toString();
    }
    final order = CartOrder(state.name, state.phoneNumber, state.location,
            listCakeString, event.price)
        .toJson();

    await FirebaseFirestore.instance.collection('payment').add(order);
    emit(state.copyWith(isLoading: false));
  }
}
