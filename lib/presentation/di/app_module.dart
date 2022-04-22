import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'app_module.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
GetIt configureDependencies() => $initGetIt(getIt);

@module
abstract class AppModule {
  @Singleton()
  @Named('base_url')
  Dio get authDio {
    return _createDio('https://mocki.io/v1/');
  }

  Dio _createDio(String url) {
    final BaseOptions options = BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      sendTimeout: 60000,
      baseUrl: url,

      /// Dio defaults to json parsing, specify it here to return UTF8 string and handle it yourself.
      /// (It can also be achieved through a custom transformer)
      responseType: ResponseType.plain,
      validateStatus: (_) {
        /// Do not use http status code to judge the status, use AdapterInterceptor to handle (applicable to standard REST style)
        return true;
      },
    );

    final dio = Dio(options);

    if (!kReleaseMode) {
      dio.interceptors
          .add(PrettyDioLogger(requestHeader: true, requestBody: true));
    }
    return dio;
  }
}
