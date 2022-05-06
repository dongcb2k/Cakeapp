import 'package:cakeapp/data/modals/voucher.dart';
import 'package:cakeapp/domain/utils/error.dart';
import 'package:either_dart/either.dart';

import '../../data/modals/cake.dart';

abstract class ShopRepository {
  Future<Either<AppError, List<CakeResponse>>> getCakeItem();

  Future<Either<AppError, List<VoucherResponse>>> getVoucher();

}
