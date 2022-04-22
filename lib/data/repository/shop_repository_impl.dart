import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/data/remote/base/base_response.dart';
import 'package:cakeapp/data/remote/service/shop_service.dart';
import 'package:cakeapp/domain/repository/shop_repository.dart';
import 'package:cakeapp/domain/utils/error.dart';
import 'package:either_dart/src/either.dart';

class ShopRepositoryImpl extends ShopRepository {
  ShopRepositoryImpl(this._shopService);

  final ShopService _shopService;

  @override
  Future<Either<AppError, CakeResponse>> getCakeItem() async {
    try {
      final res = await _shopService.getCakeItem();

      if (res.result.isRight) {
        return res.result;
      } else {
        return const Left(ServerError('Error', '100'));
      }
    } catch (e) {
      return Left(getError(e));
    }
  }

  @override
  void dispose() {}
}
