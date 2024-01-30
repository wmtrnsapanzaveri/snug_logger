import 'package:snug_logger/src/base_logger/log_handler.dart';
import 'package:snug_logger/src/utlis/log_type.dart';

/// SnugLog is a logger that provides a simple and extensible API to log messages.
snugLog(
    [dynamic content = "Debug Message",
    LogType logType = LogType.debug,
    StackTrace? stackTrace]) {
  LogHandler.snugIt(content, logType, stackTrace);
}
