import 'package:dio/dio.dart';
import 'package:snug_logger/src/dio_logger/dio_handlers/snug_dio_error_handler.dart';
import 'package:snug_logger/src/dio_logger/dio_handlers/snug_dio_request_handler.dart';

import 'dio_handlers/snug_dio_response_handler.dart';

class SnugDioLogger extends Interceptor {
  final bool requestHeaders;
  final bool requestData;
  final bool responseHeaders;
  final bool responseData;
  final bool showCurl;
  void Function(Object object) logPrint;

  SnugDioLogger(
      {this.requestHeaders = false,
      this.requestData = false,
      this.responseHeaders = false,
      this.responseData = false,
      this.showCurl = false,
      this.logPrint = print});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final httpLog = SnugDioRequestHandler(
          requestOptions: options,
          requestHeaders: requestHeaders,
          requestData: requestData);
      if (httpLog.generateTextMessage() != null) {
        logPrint(httpLog.generateTextMessage() ?? "");
      }
    } catch (_) {}
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    try {
      final httpErrorLog = SnugDioErrorHandler(
        dioException: err,
      );
      logPrint(httpErrorLog.generateTextMessage());
    } catch (_) {}
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final httpLog = SnugDioResponseHandler(
        response: response,
        responseData: responseData,
        responseHeaders: responseHeaders,
        showCurl: showCurl,
      );
      logPrint(httpLog.generateTextMessage());
    } catch (_) {}
    super.onResponse(response, handler);
  }
}
