import 'package:dio/dio.dart';
import 'package:snug_logger/src/utlis/common_utlis.dart';
import 'package:snug_logger/src/utlis/curl_utils.dart';
import 'package:snug_logger/src/utlis/network_titles.dart';

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
    contentHead = "${contentHead.replaceAll("\n", "$messageColors│")}${CommonUtils.resetColor}";

    final responseMessage = dioException.message;
    final data = dioException.response?.data;
    final headers = dioException.requestOptions.headers;

    /// Get curl data
    String curlMsg = CurlUtils.getFormattedCurl(dioException.requestOptions);

    var msg = '\u001b[31m';
    msg += '┌[${dioException.type.toString()}]\n';
    msg += '\n [Message]: ${responseMessage?.replaceAll("\n", "\n ")}';

    if (data != null) {
      final prettyData = CommonUtils.encoder.convert(data);
      msg += '\n Data: ${prettyData.replaceAll("\n", "$messageColors│")}';
    }
    if (headers.isNotEmpty) {
      final prettyHeaders = CommonUtils.encoder.convert(headers);
      msg += ' Headers: $prettyHeaders';
    }
    msg = "$contentHead${msg.replaceAll("\n", "$messageColors│")}"
        "$messageColors└${CommonUtils.getHorizontalLine()}${CommonUtils.resetColor}";

    // cURL Logging integrated
    if (curlMsg.isNotEmpty) {
      msg = '$curlMsg\n$msg';
    }

    return msg;
  }
}
