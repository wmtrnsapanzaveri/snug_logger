import 'package:dio/dio.dart';
import 'package:snug_logger/src/utlis/common_utlis.dart';
import 'package:snug_logger/src/utlis/network_titles.dart';

class SnugDioRequestHandler {
  SnugDioRequestHandler({required this.requestOptions, this.requestData = false, this.requestHeaders = false}) : super();

  final RequestOptions requestOptions;
  final bool requestData;
  final bool requestHeaders;

  String get title => NetworkTitles.httpRequest.title;

  var messageColors = "\u001b[0m\n\x1B[38;5;208m";

  String? generateTextMessage() {
    String msg = "";

    var contentHead = '\x1B[38;5;208m'
        '┌${CommonUtils.getHorizontalLine()}\n'
        ' [$title] [${requestOptions.method}] ${requestOptions.uri}';
    contentHead = "${contentHead.replaceAll("\n", "$messageColors│")}${CommonUtils.resetColor}";
    // Normal Request Logging
    if (requestData || requestHeaders) {
      msg = '\x1B[38;5;208m';
      // '┌${CommonUtils.getHorizontalLine()}\n'
      // ' [$title] [${requestOptions.method}] ${requestOptions.uri}';

      final data = requestOptions.data;
      final headers = requestOptions.headers;

      try {
        if (requestData && data != null) {
          final prettyData = CommonUtils.encoder.convert(data);
          msg += '\n Data: $prettyData';
        }
        if (requestHeaders && headers.isNotEmpty) {
          final prettyHeaders = CommonUtils.encoder.convert(headers);
          msg += '\n Headers: $prettyHeaders';
        }
      } catch (_) {
        // TODO: add handling can`t convert
      }
    }

    msg = "$contentHead${msg.isEmpty || msg == "\x1B[38;5;208m" ? "" : msg.replaceAll("\n", "$messageColors│")}"
        "$messageColors└${CommonUtils.getHorizontalLine()}${CommonUtils.resetColor}";

    return msg;
  }
}
