// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/local/local_data_impl.dart' as _i6;
import '../../data/remote/service/shop_service.dart' as _i7;
import '../../data/repository/auth_repository_impl.dart' as _i9;
import '../../data/repository/shop_repository_impl.dart' as _i12;
import '../../domain/local/local_data.dart' as _i5;
import '../../domain/repository/auth_repository.dart' as _i8;
import '../../domain/repository/shop_repository.dart' as _i11;
import '../../domain/usecase/shop/shop_item_usecase.dart' as _i13;
import '../../domain/usecase/voucher/voucher_usecase.dart' as _i14;
import '../screen/cart/bloc/cart_bloc.dart' as _i16;
import '../screen/home/bloc/home_bloc.dart' as _i4;
import '../screen/login/bloc/phone_verify_bloc.dart' as _i10;
import '../screen/shop/bloc/shop_bloc.dart' as _i15;
import 'app_module.dart' as _i17; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i8.AuthRepository>(
      _i9.AuthRepositoryImpl(get<_i5.LocalData>()));
  gh.singleton<_i10.PhoneVerifyBloc>(
      _i10.PhoneVerifyBloc(get<_i8.AuthRepository>(), get<_i5.LocalData>()));
  gh.singleton<_i11.ShopRepository>(
      _i12.ShopRepositoryImpl(get<_i7.ShopService>()));
  gh.factory<_i13.GetShopItemUseCase>(
      () => _i13.GetShopItemUseCase(get<_i11.ShopRepository>()));
  gh.factory<_i14.GetVoucherUseCase>(
      () => _i14.GetVoucherUseCase(get<_i11.ShopRepository>()));
  gh.factory<_i15.ShopBloc>(
      () => _i15.ShopBloc(get<_i13.GetShopItemUseCase>()));
  gh.factory<_i16.CartBloc>(() => _i16.CartBloc(get<_i13.GetShopItemUseCase>(),
      get<_i5.LocalData>(), get<_i14.GetVoucherUseCase>()));
  return get;
}

class _$AppModule extends _i17.AppModule {}
