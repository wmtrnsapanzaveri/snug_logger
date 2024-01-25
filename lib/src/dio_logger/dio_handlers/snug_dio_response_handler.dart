import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snug_logger/src/model/common_utlis.dart';
import 'package:snug_logger/src/model/network_titles.dart';

const encoder = JsonEncoder.withIndent('  ');

class SnugDioRequestHandler {
  SnugDioRequestHandler(
      {required this.requestOptions,
      this.requestData = false,
      this.requestHeaders = false})
      : super();

  final RequestOptions requestOptions;
  final bool requestData;
  final bool requestHeaders;

  String get title => NetworkTitles.httpRequest.title;

  var messageColors = "\u001b[0m\n\x1B[38;5;208m";

  String generateTextMessage() {
    var msg = '\x1B[38;5;208m'
        '┌${CommonUtils.getHorizontalLine()}\n'
        ' [$title] [${requestOptions.method}] ${requestOptions.uri}';

    final data = requestOptions.data;
    final headers = requestOptions.headers;

    try {
      if (requestData && data != null) {
        final prettyData = encoder.convert(data);
        msg += '\n Data: $prettyData';
      }
      if (requestHeaders && headers.isNotEmpty) {
        final prettyHeaders = encoder.convert(headers);
        msg += '\n Headers: $prettyHeaders';
      }
      msg = "${msg.replaceAll("\n", "$messageColors│")}"
          "$messageColors└${CommonUtils.getHorizontalLine()}\u001b[0m";
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class SnugDioResponseHandler {
  SnugDioResponseHandler({
    required this.response,
    required this.responseMessage,
    required this.responseData,
    required this.responseHeaders,
  }) : super();

  final Response<dynamic> response;
  final bool responseMessage;
  final bool responseData;
  final bool responseHeaders;

  String get title => NetworkTitles.httpResponse.title;

  var messageColors = "\u001b[0m\n\u001b[1;92;5m";

  String generateTextMessage() {
    var msg = '\u001b[1;92;5m'
        '┌${CommonUtils.getHorizontalLine()}\n'
        ' [$title] [${response.requestOptions.method}] ${response.realUri}\n';

    final fetchResponseMessage = response.statusMessage;
    final data = response.data;
    final headers = response.headers.map;

    msg += ' Status: ${response.statusCode}';

    if (responseMessage && fetchResponseMessage != null) {
      msg += '\n Message: $fetchResponseMessage';
    }

    try {
      if (responseData && data != null) {
        final prettyData = encoder.convert(data);
        msg += '\n Data: $prettyData';
      }
      if (responseHeaders && headers.isNotEmpty) {
        final prettyHeaders = encoder.convert(headers);
        msg += '\n Headers: $prettyHeaders';
      }

      msg = "${msg.replaceAll("\n", "$messageColors│")}"
          "$messageColors└${CommonUtils.getHorizontalLine()}\u001b[0m";
    } catch (_) {}
    return msg;
  }
}

class SnugDioErrorHandler {
  SnugDioErrorHandler({required this.dioException}) : super();

  final DioException dioException;

  String get title => NetworkTitles.httpError.title;

  var messageColors = "\u001b[0m\n\u001b[31m";

  String generateTextMessage() {
    var msg = '\u001b[31m'
        '┌${CommonUtils.getHorizontalLine()}\n'
        ' [$title] [${dioException.requestOptions.method}] ${dioException.response?.realUri}';

    final responseMessage = dioException.message;
    final statusCode = dioException.response?.statusCode;
    final data = dioException.response?.data;
    final headers = dioException.requestOptions.headers;

    if (statusCode != null) {
      msg += '\n Status: ${dioException.response?.statusCode}';
    }
    msg += '\n Message: ${responseMessage?.replaceAll("\n", "\n ")}';

    if (data != null) {
      final prettyData = encoder.convert(data);
      msg += '\n Data: $prettyData';
    }
    if (headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      msg += '\n Headers: $prettyHeaders';
    }
    msg = "${msg.replaceAll("\n", "$messageColors│")}"
        "$messageColors└${CommonUtils.getHorizontalLine()}\u001b[0m";
    return msg;
  }
}
