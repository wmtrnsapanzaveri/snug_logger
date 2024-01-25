import 'package:dio/dio.dart';
import 'dio_handlers/snug_dio_response_handler.dart';

class SnugDioLogger extends Interceptor {
  final bool requestHeaders;
  final bool requestData;
  final bool responseMessage;
  final bool responseHeaders;
  final bool responseData;

  void Function(Object object) logPrint;

  SnugDioLogger(
      {this.requestHeaders = false,
      this.requestData = false,
      this.responseMessage = false,
      this.responseHeaders = false,
      this.responseData = false,
      this.logPrint = print});

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
        responseMessage: responseMessage,
      );
      logPrint(httpLog.generateTextMessage());
    } catch (_) {}
    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final httpLog = SnugDioRequestHandler(
          requestOptions: options,
          requestHeaders: requestHeaders,
          requestData: requestData);
      logPrint(httpLog.generateTextMessage());
    } catch (_) {}
    super.onRequest(options, handler);
  }
}
