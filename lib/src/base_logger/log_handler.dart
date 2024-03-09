import 'package:snug_logger/src/utlis/debug_print.dart';
import 'package:snug_logger/src/utlis/common_utlis.dart';
import 'package:snug_logger/src/model/log_detail.dart';
import 'package:snug_logger/src/utlis/log_type.dart';

String _getTimeInMs() {
  final DateTime d = DateTime.now();
  final minutesPadded = '${d.minute}'.padLeft(2, '0');
  final secondsPadded = '${d.second}'.padLeft(2, '0');
  return '${d.hour}:$minutesPadded:$secondsPadded ${d.millisecond}ms';
}

class LogHandler {
  LogHandler() : super();

  static snugIt(
      [dynamic content = "Debug Message",
      LogType logType = LogType.debug,
      StackTrace? stackTrace]) {
    final Map<LogType, LogDetail> logTypeColor = {
      LogType.info: const LogDetail("📝", "\u001b[34m"),
      // Blue
      LogType.production: const LogDetail("🔬", '\u001b[32m'),
      // Green // Production Log will be display in the release mode
      LogType.debug: const LogDetail('🔎', '\u001b[36m'),
      // cyan
      LogType.error:
          const LogDetail("🚨", '\u001b[31m', contentColor: "\u001b[31m"),
      // Red
      // White
    };

    LogDetail? logTypeValue = logTypeColor[logType];

    var colorSetup = "\u001b[0m\n${logTypeValue?.color}";

    final insideLogContent =
        '$colorSetup [${logType.name.toUpperCase()}] | ${_getTimeInMs()}\n'
        ' ${logType.name.toUpperCase()} Content: ${logTypeValue?.contentColor}${content.toString().replaceAll("\n", "")}${logTypeValue?.color}\n'
/*      '│  Runtime Type: ${message.runtimeType}\n'*/
        '${stackTrace != null ? "\u001b[1;91m Stack Trace: $stackTrace" : ""}';

    final logTemplate = '${logTypeValue?.color}'
        '${logTypeValue?.emoji} Start of ${logType.name.toUpperCase()} ${logTypeValue?.emoji}$colorSetup'
        '┌${CommonUtils.getHorizontalLine()}'
        '${insideLogContent.trim().replaceAll("\n", "$colorSetup│ ")}$colorSetup'
        '└${CommonUtils.getHorizontalLine()}$colorSetup'
        'End of ${logType.name.toUpperCase()} Log 👋🏻${CommonUtils.resetColor}'; // Reset color

    if (kDebugMode || logType == LogType.production) {
      debugPrintSnug(logTemplate,logTypeValue?.contentColor,CommonUtils.resetColor);
    }
  }
}
