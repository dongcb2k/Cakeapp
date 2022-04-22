import 'package:cakeapp/presentation/screen/cart/bloc/cart_event.dart';
import 'package:cakeapp/presentation/screen/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddItemEvent>((event, emit) => null);
  }

}
