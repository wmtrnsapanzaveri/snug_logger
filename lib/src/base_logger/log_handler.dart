import 'package:snug_logger/src/utlis/debug_print.dart';
import 'package:snug_logger/src/utlis/common_utlis.dart';
import 'package:snug_logger/src/model/log_detail.dart';
import 'package:snug_logger/src/utlis/log_type.dart';
import 'package:snug_logger/src/utlis/stack_trace_formatter.dart';
import 'package:flutter/foundation.dart';

String _getTimeInMs() {
  final DateTime d = DateTime.now();
  final minutesPadded = '${d.minute}'.padLeft(2, '0');
  final secondsPadded = '${d.second}'.padLeft(2, '0');
  return '${d.hour}:$minutesPadded:$secondsPadded ${d.millisecond}ms';
}

class LogHandler {
  LogHandler() : super();

  static StackFrame stackData(List<StackFrame> stacks) {
    var logPoint = stacks.firstWhere(
      (StackFrame line) {
        return line.package != 'snug_logger';
      },
    );
    return logPoint;
  }

  static void snugIt(
      {dynamic content = "Debug Message",
      LogType logType = LogType.debug,
      required StackTrace stackTrace}) {
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

    final List<StackFrame> stackFrames1 =
        StackFrame.fromStackTrace(FlutterError.demangleStackTrace(stackTrace))
            .skipWhile((StackFrame frame) => frame.packageScheme == 'dart')
            .toList();

    StackFrame stackFrames = stackData(stackFrames1);

    // Format stack trace beautifully for error logs in Snug Logger style
    final formattedStackTrace = logType == LogType.error
        ? StackTraceFormatter.formatForSnugLogger(
            stackTrace,
            useTerse: true,
            colorPrefix: logTypeValue?.contentColor ?? '',
            colorSuffix: logTypeValue?.color ?? '',
          )
        : '';

    final insideLogContent =
        '$colorSetup [${logType.name.toUpperCase()}] | ${_getTimeInMs()} | ${stackFrames.packageScheme}:${stackFrames.package}/${stackFrames.packagePath}:${stackFrames.line}:${stackFrames.column}\n'
        ' ${logType.name.toUpperCase()} Content: ${logTypeValue?.contentColor}${content.toString().replaceAll("\n", "")}${logTypeValue?.color}\n'
/*      '│  Runtime Type: ${message.runtimeType}\n'*/
        '${logType == LogType.error ? "${CommonUtils.getHorizontalLine()}\n${logTypeValue?.color}│  Stack Trace: 🔍\n$formattedStackTrace" : ""}';

    final logTemplate = '${logTypeValue?.color}'
        '${logTypeValue?.emoji} Start of ${logType.name.toUpperCase()} ${logTypeValue?.emoji}$colorSetup'
        '┌${CommonUtils.getHorizontalLine()}'
        '${insideLogContent.trim().replaceAll("\n", "$colorSetup│ ")}$colorSetup'
        '└${CommonUtils.getHorizontalLine()}$colorSetup'
        'End of ${logType.name.toUpperCase()} Log 👋🏻${CommonUtils.resetColor}'; // Reset color

    if (kDebugMode || logType == LogType.production) {
      debugPrintSnug(
          logTemplate, logTypeValue?.contentColor, CommonUtils.resetColor);
    }
  }
}
