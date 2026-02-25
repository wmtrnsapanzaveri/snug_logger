/// A cozy and efficient logging package for Flutter applications.
///
/// Snug Logger provides:
/// - Colorful, emoji-filled log messages with structured formatting
/// - Multiple log levels: debug, info, error, and production
/// - Beautiful stack trace formatting that matches the log aesthetic
/// - Network request logging with SnugDioLogger
/// - Zero external dependencies for stack trace functionality
///
/// Example:
/// ```dart
/// import 'package:snug_logger/snug_logger.dart';
///
/// snugLog('Hello, Snug Logger! 🛋️', logType: LogType.info);
///
/// try {
///   throw Exception('Error!');
/// } catch (error, stackTrace) {
///   snugLog('Error occurred', logType: LogType.error, stackTrace: stackTrace);
/// }
/// ```
library snug_logger;

export 'src/base_logger/snug_logger_base.dart';
export 'src/dio_logger/snug_dio_logger.dart';
export 'src/utlis/log_type.dart';
export 'src/utlis/stack_trace_formatter.dart';
