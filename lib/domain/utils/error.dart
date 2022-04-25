import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  const AppError([this.message = '', this.code]);

  final String message;

  final String? code;

  @override
  List<Object> get props => [message];
}

class ServerError extends AppError {
  const ServerError([String message = '', String? code]) : super(message, code);
}

class Auth0Error extends AppError {
  const Auth0Error([String message = '']) : super(message);
}

class OtherFailure extends AppError {
  const OtherFailure([String message = '']) : super(message);
}

class NetworkError extends AppError {
  const NetworkError([String message = '']) : super(message);
}

AppError getError(dynamic error) {
  if (error is DioError && error.error is SocketException) {
    return const NetworkError('Network Error');
  }
  return const OtherFailure('Common Error');
}

const commonError = OtherFailure('');
