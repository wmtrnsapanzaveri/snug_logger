import 'package:snug_logger/src/base_logger/log_handler.dart';
import 'package:snug_logger/src/utlis/log_type.dart';

snugLog(
    [dynamic content = "Debug Message",
    LogType logType = LogType.debug,
    StackTrace? stackTrace]) {
  LogHandler.snugIt(content, logType, stackTrace);
}
