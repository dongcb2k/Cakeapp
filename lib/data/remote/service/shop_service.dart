import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/data/modals/category.dart';
import 'package:cakeapp/data/modals/voucher.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'shop_service.g.dart';

@RestApi()
@Singleton()
abstract class ShopService {
  @factoryMethod
  factory ShopService(@Named('base_url')Dio dio) = _ShopService;

  @GET('5eaa7f35-598e-4fa6-b4a8-b14d4f8f6c08')
  Future<List<CakeResponse>> getCakeItem();

  @GET('c1c7c80c-3a1b-4bfa-8a9a-93fc7e4b36c4')
  Future<List<VoucherResponse>> getVoucher();

  @GET('f3f12d22-c60a-4227-8057-f4a78a4e6d56')
  Future<List<CategoryResponse>> getCategory();
}
