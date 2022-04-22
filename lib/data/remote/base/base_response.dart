import 'dart:io';

import 'package:cakeapp/domain/utils/error.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:json_annotation/json_annotation.dart';

import 'json_convert.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  ApiResponse(this.status, this.message, this.code, this.results);

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Status status;

  String message;

  String? code;

  @Converter()
  T? results;

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}

enum Status { success, failure }

extension ApiResponseExt<T> on ApiResponse<T> {
  Either<AppError, T> get result {
    if (status == Status.success && results != null) {
      return Right(results!);
    } else {
      return Left(ServerError(message, code));
    }
  }

  Either<AppError, T?> get resultOfNull {
    if (status == Status.success) {
      return Right(results);
    } else {
      return Left(ServerError(message, code));
    }
  }

  Either<AppError, bool> get trueResult {
    if (status == Status.success) {
      return const Right(true);
    } else {
      return Left(ServerError(message, code));
    }
  }
}

AppError getError(dynamic error) {
  if (error is DioError && error.error is SocketException) {
    return const NetworkError('Network Error');
  }
  return const OtherFailure('Common Error');
}
