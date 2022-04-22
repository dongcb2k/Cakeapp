import 'dart:async';

import 'package:either_dart/either.dart';

import '../utils/error.dart';

abstract class UseCase<T, Params> {
  Future<Either<AppError, T>> execute(Params params);
}

abstract class WithoutParamUseCase<T> {
  Future<Either<AppError, T>> execute();
}
