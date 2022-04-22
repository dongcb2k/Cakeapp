import 'package:cakeapp/data/modals/cake.dart';
import 'package:cakeapp/domain/repository/shop_repository.dart';
import 'package:cakeapp/domain/usecase/usecase.dart';
import 'package:cakeapp/domain/utils/error.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetShopItemUseCase extends WithoutParamUseCase<CakeResponse> {
  GetShopItemUseCase(this._shopRepository);

  final ShopRepository _shopRepository;

  @override
  Future<Either<AppError, CakeResponse>> execute() =>
      _shopRepository.getCakeItem();
}
