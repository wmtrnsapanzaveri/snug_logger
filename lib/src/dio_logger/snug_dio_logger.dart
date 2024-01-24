import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'dio_handlers/snug_dio_response_handler.dart';

class SnugDioLogger extends Interceptor {
  final bool responseData;
  final bool requestHeaders;
  final bool responseMessage;
  final bool requestData;
  final bool requestHeader;

  void Function(Object object) logPrint;

  SnugDioLogger(
      {this.responseData = false,
      this.requestHeaders = false,
      this.responseMessage = false,
      this.requestData = false,
      this.requestHeader = false,
      this.logPrint = print});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    try {
      final httpErrorLog = SnugDioErrorHandler(
        dioException: err,
      );
      logPrint(httpErrorLog.generateTextMessage());
    } catch (_) {
      //pass
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final httpLog = SnugDioResponseHandler(
        response: response,
        responseData: responseData,
        responseHeaders: requestHeaders,
        responseMessage: responseMessage,
      );
      logPrint(httpLog.generateTextMessage());
    } catch (_, st) {
      //pass
    }
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      // final message = '${options.uri}';
      final httpLog = SnugDioRequestHandler(
          requestOptions: options, requestHeaders: true, requestData: true);
      // _talker.logTyped(httpLog);
      print(httpLog.generateTextMessage());
    } catch (_) {
      //pass
    }
    super.onRequest(options, handler);
  }
}
