import 'package:cakeapp/data/modals/cake.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'shop_service.g.dart';

@RestApi()
@Singleton()
abstract class ShopService {
  @factoryMethod
  factory ShopService(@Named('base_url')Dio dio) = _ShopService;

  @GET('2f1cc49c-0985-4c0f-8b40-15ff4a4da470')
  Future<List<CakeResponse>> getCakeItem();
}