import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../utils/constant.dart';
import 'auth_helper.dart';

class DioHelper {
  var logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
  InterceptorsWrapper getDioInterceptor() {
    return InterceptorsWrapper(
      onRequest: ((options, handler) async {
        final accessToken = await AuthHelper.getAccessToken();
        options.headers = {
          'Content-Type': Headers.jsonContentType,
        };
        if (accessToken != null) {
          options.headers.remove('Authorization');
          options.headers.addAll({'Authorization': 'Bearer $accessToken'});
        }

        logger.i(
            "${options.headers}\n${options.path}\n${options.queryParameters}");
        if (options.data != null) {
          logger.i("${options.data}");
        }

        return handler.next(options);
      }),
      onResponse: (response, handler) {
        try {
          logger.i("\n${response.statusCode}\n${response.data}");
          return handler.next(response);
        } catch (e) {
          logger.e("$response");
          return handler.next(response);
        }
      },
      onError: (DioError e, handler) {
        logger.e("$e");
        logger.e("${e.response}");
        return handler.next(e);
      },
    );
  }

  Dio getDioClient() {
    var dio = Dio();
    dio.interceptors.add(getDioInterceptor());
    dio.options.baseUrl = baseUrl;
    return dio;
  }
}
