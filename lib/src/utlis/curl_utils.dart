import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:snug_logger/src/utlis/common_utlis.dart';
import 'package:snug_logger/src/utlis/network_titles.dart';

class CurlUtils {
  static String generateCurl(RequestOptions options) {
    List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      if (options.data is FormData) {
        components.add('-d "${options.data.toString()}"');
      } else {
        try {
          final data = json.encode(options.data);
          components.add('-d "$data"');
        } catch (e) {
          components.add('-d "${options.data}"');
        }
      }
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' ');
  }

  static String getFormattedCurl(RequestOptions options) {
    String colorCode = "\x1B[38;2;0;195;255m";
    String curlMsg = '$colorCode'
        '┌${CommonUtils.getHorizontalLine()}\n'
        '│ [${NetworkTitles.httpRequestCurl.title}] '
        '${generateCurl(options)}';

    curlMsg += "\n$colorCode└${CommonUtils.getHorizontalLine()}${CommonUtils.resetColor}";
    return curlMsg;
  }
}
