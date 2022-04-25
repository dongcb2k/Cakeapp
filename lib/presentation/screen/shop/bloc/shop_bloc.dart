import 'package:cakeapp/domain/usecase/shop/shop_item_usecase.dart';
import 'package:cakeapp/main.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_event.dart';
import 'package:cakeapp/presentation/screen/shop/bloc/shop_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc(this._shopItemUseCase) : super(const ShopState()) {
    on<GetShopEvent>(_getShopEvent);
  }

  final GetShopItemUseCase _shopItemUseCase;

  Future<void> _getShopEvent(
    GetShopEvent event,
    Emitter<ShopState> emit,
  ) async {
    final res = await _shopItemUseCase.execute();

    if (res.isRight) {
      final data = res.right;
      logger.d('RESPONSE ' + data.toString());
      emit(state.copyWith(listCake: data));
    } else {
      logger.d("FAIL");
    }
  }
}
