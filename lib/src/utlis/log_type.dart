/// Enum representing different types of log messages.
enum LogType {
  /// Informational log message.
  ///
  /// Used for providing general information about the application's state or events.
  info,

  /// Debug log message.
  ///
  /// Intended for detailed debugging information, usually not shown in production.
  debug,

  /// Production log message.
  ///
  /// Indicates messages meant for production use, providing insights into the system's operation.
  /// Warning: This log will be displayed in the release mode.
  production,

  /// Error log message.
  ///
  /// Used to log errors or exceptional situations in the application.
  error,
}
