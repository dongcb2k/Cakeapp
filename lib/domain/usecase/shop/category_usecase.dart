import 'package:cakeapp/data/modals/category.dart';
import 'package:cakeapp/domain/repository/shop_repository.dart';
import 'package:cakeapp/domain/usecase/usecase.dart';
import 'package:cakeapp/domain/utils/error.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryUseCase extends WithoutParamUseCase<List<CategoryResponse>> {
  GetCategoryUseCase(this._shopRepository);

  final ShopRepository _shopRepository;

  @override
  Future<Either<AppError, List<CategoryResponse>>> execute() =>
      _shopRepository.getCategory();
}
