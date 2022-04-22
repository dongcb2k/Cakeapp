import 'package:cakeapp/domain/usecase/shop/shop_item_usecase.dart';
import 'package:cakeapp/presentation/screen/home/bloc/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getShopItemUseCase) : super(HomeState());

  final GetShopItemUseCase _getShopItemUseCase;
}