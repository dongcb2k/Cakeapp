// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/local/local_data_impl.dart' as _i9;
import '../../data/remote/service/shop_service.dart' as _i10;
import '../../domain/local/local_data.dart' as _i8;
import '../../domain/repository/shop_repository.dart' as _i6;
import '../../domain/usecase/shop/shop_item_usecase.dart' as _i5;
import '../screen/cart/bloc/cart_bloc.dart' as _i3;
import '../screen/home/bloc/home_bloc.dart' as _i7;
import 'app_module.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.CartBloc>(() => _i3.CartBloc());
  gh.singleton<_i4.Dio>(appModule.authDio, instanceName: 'base_url');
  gh.factory<_i5.GetShopItemUseCase>(
      () => _i5.GetShopItemUseCase(get<_i6.ShopRepository>()));
  gh.factory<_i7.HomeBloc>(() => _i7.HomeBloc(get<_i5.GetShopItemUseCase>()));
  gh.singleton<_i8.LocalData>(_i9.LocalDataImpl());
  gh.singleton<_i10.ShopService>(_i10.ShopService(get<_i4.Dio>()));
  return get;
}

class _$AppModule extends _i11.AppModule {}
