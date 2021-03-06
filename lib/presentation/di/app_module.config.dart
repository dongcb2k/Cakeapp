// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/local/local_data_impl.dart' as _i6;
import '../../data/remote/service/shop_service.dart' as _i8;
import '../../data/repository/auth_repository_impl.dart' as _i11;
import '../../data/repository/shop_repository_impl.dart' as _i14;
import '../../domain/local/local_data.dart' as _i5;
import '../../domain/repository/auth_repository.dart' as _i10;
import '../../domain/repository/shop_repository.dart' as _i13;
import '../../domain/usecase/shop/category_usecase.dart' as _i15;
import '../../domain/usecase/shop/shop_item_usecase.dart' as _i16;
import '../../domain/usecase/voucher/voucher_usecase.dart' as _i17;
import '../screen/cart/bloc/cart_bloc.dart' as _i19;
import '../screen/home/bloc/home_bloc.dart' as _i4;
import '../screen/login/bloc/phone_verify_bloc.dart' as _i12;
import '../screen/payment/bloc/payment_bloc.dart' as _i7;
import '../screen/shop/bloc/shop_bloc.dart' as _i18;
import '../screen/user/bloc/user_bloc.dart' as _i9;
import 'app_module.dart' as _i20; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.singleton<_i3.Dio>(appModule.authDio, instanceName: 'base_url');
  gh.factory<_i4.HomeBloc>(() => _i4.HomeBloc());
  gh.singleton<_i5.LocalData>(_i6.LocalDataImpl());
  gh.factory<_i7.PaymentBloc>(() => _i7.PaymentBloc(get<_i5.LocalData>()));
  gh.singleton<_i8.ShopService>(
      _i8.ShopService(get<_i3.Dio>(instanceName: 'base_url')));
  gh.factory<_i9.UserBloc>(() => _i9.UserBloc(get<_i5.LocalData>()));
  gh.singleton<_i10.AuthRepository>(
      _i11.AuthRepositoryImpl(get<_i5.LocalData>()));
  gh.factory<_i12.PhoneVerifyBloc>(
      () => _i12.PhoneVerifyBloc(get<_i10.AuthRepository>()));
  gh.singleton<_i13.ShopRepository>(
      _i14.ShopRepositoryImpl(get<_i8.ShopService>()));
  gh.factory<_i15.GetCategoryUseCase>(
      () => _i15.GetCategoryUseCase(get<_i13.ShopRepository>()));
  gh.factory<_i16.GetShopItemUseCase>(
      () => _i16.GetShopItemUseCase(get<_i13.ShopRepository>()));
  gh.factory<_i17.GetVoucherUseCase>(
      () => _i17.GetVoucherUseCase(get<_i13.ShopRepository>()));
  gh.factory<_i18.ShopBloc>(() => _i18.ShopBloc(
      get<_i16.GetShopItemUseCase>(), get<_i15.GetCategoryUseCase>()));
  gh.factory<_i19.CartBloc>(() => _i19.CartBloc(get<_i16.GetShopItemUseCase>(),
      get<_i5.LocalData>(), get<_i17.GetVoucherUseCase>()));
  return get;
}

class _$AppModule extends _i20.AppModule {}
