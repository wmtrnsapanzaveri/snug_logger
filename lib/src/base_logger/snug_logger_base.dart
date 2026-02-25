import 'package:snug_logger/src/base_logger/log_handler.dart';
import 'package:snug_logger/src/utlis/log_type.dart';

/// SnugLog is a logger that provides a simple and extensible API to log messages.
void snugLog(dynamic content,
    {StackTrace? stackTrace, LogType logType = LogType.debug}) {
  LogHandler.snugIt(
      content: content,
      logType: logType,
      stackTrace: stackTrace ?? StackTrace.current);
}
