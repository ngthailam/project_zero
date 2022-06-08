import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@Singleton()

class DioClient {
  final Dio dio = Dio();

  DioClient() {
    dio
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) => requestInterceptor(options, handler),
          onResponse: (options, handler) =>
              responseInterceptor(options, handler),
        ),
      )
      ..options = BaseOptions(
        contentType: 'application/json',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        validateStatus: (_) => true,
        // contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      );
  }

//responseInterceptor
  responseInterceptor(Response options, ResponseInterceptorHandler handler) {
    debugPrint(options.statusCode.toString() +
        "--> ${options.requestOptions.method != null ? options.requestOptions.method.toUpperCase() : 'METHOD'} ${"" + (options.requestOptions.baseUrl) + (options.requestOptions.path)}");

    if (options.data != null) {
      print('response: ->${options.data.toString()}');
    }
    return handler.next(options);
  }

//requestInterceptor
  requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
        "--> ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl) + (options.path)}");
    print('Headers:');
    options.headers.forEach((k, v) => print('$k: $v'));
    print('queryParameters:');
    options.queryParameters.forEach((k, v) => print('$k: $v'));
    if (options.data != null) {
      print('Body: ${options.data}');
    }
    print(
        "--> END ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'}");
    return handler.next(options);
  }
}
