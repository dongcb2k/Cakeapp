import 'package:cakeapp/domain/utils/error.dart';
import 'package:either_dart/either.dart';

import '../../data/modals/cake.dart';

abstract class ShopRepository {
  Future<Either<AppError, CakeResponse>> getCakeItem();

  void dispose();
}
