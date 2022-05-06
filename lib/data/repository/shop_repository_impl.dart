import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/data/modals/voucher.dart';
import 'package:cakeapp/data/remote/service/shop_service.dart';
import 'package:cakeapp/domain/repository/shop_repository.dart';
import 'package:cakeapp/domain/utils/error.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ShopRepository)
class ShopRepositoryImpl extends ShopRepository {
  ShopRepositoryImpl(this._shopService);

  final ShopService _shopService;

  @override
  Future<Either<AppError, List<CakeResponse>>> getCakeItem() async {
    try {
      final res = await _shopService.getCakeItem();

      if (res.isNotEmpty) {
        return Right(res);
      } else {
        return const Left(ServerError('Error', '100'));
      }
    } catch (e) {
      return Left(getError(e));
    }
  }

  @override
  Future<Either<AppError, List<VoucherResponse>>> getVoucher() async {
    try {
      final res = await _shopService.getVoucher();

      if (res.isNotEmpty) {
        return Right(res);
      } else {
        return const Left(ServerError('Error', '100'));
      }
    } catch (e) {
      return Left(getError(e));
    }
  }
}
