import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snug_logger/src/utlis/common_utlis.dart';
import 'package:snug_logger/src/utlis/network_titles.dart';

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

  String? generateTextMessage() {
    if (requestData || requestHeaders) {
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
            "$messageColors└${CommonUtils.getHorizontalLine()}${CommonUtils.resetColor}";
      } catch (_) {
        // TODO: add handling can`t convert
      }
      return msg;
    }
    return null;
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
    var contentHead = '\u001b[1;92;5m'
        '┌${CommonUtils.getHorizontalLine()}\n'
        ' [$title] [${response.requestOptions.method}]  [Status: ${response.statusCode} ${response.statusMessage}]\n'
        ' ${response.realUri}';
    contentHead =
        "${contentHead.replaceAll("\n", "$messageColors│")}${CommonUtils.resetColor}";

    final data = response.data;
    final headers = response.headers.map;

    var msg = '\u001b[1;92;5m';
    try {
      if (responseData && data != null) {
        final prettyData = encoder.convert(data);
        msg +=
            '┌[Body]$messageColors│ ${prettyData.replaceAll("\n", "$messageColors│")}';
      }
      if (responseHeaders && headers.isNotEmpty) {
        final prettyHeaders = encoder.convert(headers);
        msg +=
            '$messageColors┌[Response Header]$messageColors│ ${prettyHeaders.replaceAll("\n", "$messageColors│")}';
      }

      msg = "$contentHead\n$msg"
          "$messageColors└${CommonUtils.getHorizontalLine()}${CommonUtils.resetColor}";
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
    var contentHead = '\u001b[31m'
        '┌${CommonUtils.getHorizontalLine()}\n'
        ' [$title] [${dioException.requestOptions.method}]  [Status: ${dioException.response?.statusCode} ${dioException.response?.statusMessage}]\n'
        ' ${dioException.response?.realUri}';
    contentHead =
        "${contentHead.replaceAll("\n", "$messageColors│")}${CommonUtils.resetColor}";

    final responseMessage = dioException.message;
    final data = dioException.response?.data;
    final headers = dioException.requestOptions.headers;
    var msg = '\u001b[31m';

    msg += '┌[${dioException.type.toString()}]\n';
    msg += '\n [Message]: ${responseMessage?.replaceAll("\n", "\n ")}';

    if (data != null) {
      final prettyData = encoder.convert(data);
      msg += '\n Data: ${prettyData.replaceAll("\n", "$messageColors│")}';
    }
    if (headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      msg += ' Headers: $prettyHeaders';
    }
    msg = "$contentHead${msg.replaceAll("\n", "$messageColors│")}"
        "$messageColors└${CommonUtils.getHorizontalLine()}${CommonUtils.resetColor}";
    return msg;
  }
}
