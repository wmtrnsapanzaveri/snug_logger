import 'package:dio/dio.dart';
import 'package:snug_logger/src/utlis/common_utlis.dart';
import 'package:snug_logger/src/utlis/curl_utils.dart';
import 'package:snug_logger/src/utlis/network_titles.dart';

class SnugDioResponseHandler {
  SnugDioResponseHandler({
    required this.response,
    required this.responseData,
    required this.responseHeaders,
    required this.showCurl,
  }) : super();

  final Response<dynamic> response;
  final bool responseData;
  final bool responseHeaders;
  final bool showCurl;

  String get title => NetworkTitles.httpResponse.title;

  var messageColors = "\u001b[0m\n\u001b[1;92;5m";

  String generateTextMessage() {
    var contentHead = '\u001b[1;92;5m'
        '┌${CommonUtils.getHorizontalLine()}\n'
        ' [$title] [${response.requestOptions.method}]  [Status: ${response.statusCode} ${response.statusMessage}]\n'
        ' ${response.realUri}';
    contentHead = "${contentHead.replaceAll("\n", "$messageColors│")}${CommonUtils.resetColor}";

    final data = response.data;
    final headers = response.headers.map;
    String msg = "";
    String curlMsg = "";

    try {
      /// Get curl data
      curlMsg = showCurl ? CurlUtils.getFormattedCurl(response.requestOptions) : "";

      if (responseData || responseHeaders) {
        msg = '\u001b[1;92;5m';
        if (responseData && data != null) {
          final prettyData = CommonUtils.encoder.convert(data);
          msg += '┌[Body]$messageColors│ ${prettyData.replaceAll("\n", "$messageColors│")}';
        }
        if (responseHeaders && headers.isNotEmpty) {
          final prettyHeaders = CommonUtils.encoder.convert(headers);
          msg +=
              '${responseData && data != null ? messageColors : ""}┌[Response Header]$messageColors│ ${prettyHeaders.replaceAll("\n", "$messageColors│")}';
        }
      }

      msg = "$contentHead${msg.isEmpty || msg == "\u001b[1;92;5m" ? "" : "\n$msg"}"
          "$messageColors└${CommonUtils.getHorizontalLine()}${CommonUtils.resetColor}";
    } catch (_) {}

    // cURL Logging integrated
    if (curlMsg.isNotEmpty) {
      msg = '$curlMsg\n$msg';
    }
    return msg;
  }
}
