// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/local/local_data_impl.dart' as _i6;
import '../../data/remote/service/shop_service.dart' as _i7;
import '../../data/repository/shop_repository_impl.dart' as _i9;
import '../../domain/local/local_data.dart' as _i5;
import '../../domain/repository/shop_repository.dart' as _i8;
import '../../domain/usecase/shop/shop_item_usecase.dart' as _i10;
import '../screen/cart/bloc/cart_bloc.dart' as _i12;
import '../screen/home/bloc/home_bloc.dart' as _i4;
import '../screen/shop/bloc/shop_bloc.dart' as _i11;
import 'app_module.dart' as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.singleton<_i3.Dio>(appModule.authDio, instanceName: 'base_url');
  gh.factory<_i4.HomeBloc>(() => _i4.HomeBloc());
  gh.singleton<_i5.LocalData>(_i6.LocalDataImpl());
  gh.singleton<_i7.ShopService>(
      _i7.ShopService(get<_i3.Dio>(instanceName: 'base_url')));
  gh.singleton<_i8.ShopRepository>(
      _i9.ShopRepositoryImpl(get<_i7.ShopService>()));
  gh.factory<_i10.GetShopItemUseCase>(
      () => _i10.GetShopItemUseCase(get<_i8.ShopRepository>()));
  gh.factory<_i11.ShopBloc>(
      () => _i11.ShopBloc(get<_i10.GetShopItemUseCase>()));
  gh.factory<_i12.CartBloc>(
      () => _i12.CartBloc(get<_i10.GetShopItemUseCase>()));
  return get;
}

class _$AppModule extends _i13.AppModule {}
