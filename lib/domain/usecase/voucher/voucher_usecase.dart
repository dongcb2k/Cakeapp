import 'package:cakeapp/data/modals/voucher.dart';
import 'package:cakeapp/domain/repository/shop_repository.dart';
import 'package:cakeapp/domain/usecase/usecase.dart';
import 'package:cakeapp/domain/utils/error.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVoucherUseCase extends WithoutParamUseCase<List<VoucherResponse>> {
  GetVoucherUseCase(this._shopRepository);

  final ShopRepository _shopRepository;

  @override
  Future<Either<AppError, List<VoucherResponse>>> execute() =>
      _shopRepository.getVoucher();
}
