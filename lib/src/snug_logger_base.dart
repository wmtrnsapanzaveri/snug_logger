class SnugLogger {
  String _getTimeInMs() {
    final DateTime d = DateTime.now();
    final minutesPadded = '${d.minute}'.padLeft(2, '0');
    final secondsPadded = '${d.second}'.padLeft(2, '0');
    return '${d.hour}:$minutesPadded:$secondsPadded ${d.millisecond}ms';
  }

  String logify(
      [dynamic content = "Debug Message",
      LogType logType = LogType.debug,
      StackTrace? stackTrace]) {
    final Map<LogType, LogDetail> logTypeColor = {
      LogType.info: const LogDetail("📝", "\u001b[34m"), // Blue
      LogType.production: const LogDetail("🔬", '\u001b[32m'), // Green
      LogType.debug: const LogDetail('🔎', '\u001b[36m'), // cyan
      LogType.error: const LogDetail("🚨", '\u001b[31m',
          contentColor: "\u001b[31m"), // Red
      LogType.reset: const LogDetail("🔧", '\u001b[0m'), // White
    };

    LogDetail? logTypeValue = logTypeColor[logType];

    final logTemplate = '${logTypeValue?.color}'
        '${logTypeValue?.emoji} Start of ${logType.name.toUpperCase()} ${logTypeValue?.emoji}\n'
        '┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────\n'
        '│  [${logType.name.toUpperCase()}] | ${_getTimeInMs()}\n'
        '│  Content: ${logTypeValue?.contentColor}${content.toString().replaceAll("\n", "")}${logTypeValue?.color}\n'
/*      '│  Runtime Type: ${message.runtimeType}\n'*/
        '${stackTrace != null ? "│  Stack Trace: $stackTrace\n" : ""}'
        '└──────────────────────────────────────────────────────────────────────────────────────────────────────────────\n'
        'End of $logType Log 👋🏻'
        '${logTypeColor[LogType.reset]?.color}'; // Reset color

    return logTemplate;
  }
}

enum LogType { info, debug, production, error, reset }

class LogDetail {
  const LogDetail(this.emoji, this.color, {this.contentColor = '\u001b[93m'});

  final String emoji;
  final String color;
  final String contentColor;
}
