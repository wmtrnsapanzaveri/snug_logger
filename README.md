# Snug Logger 🛋️

![Snug_Logger](https://github.com/user-attachments/assets/a9678707-4f25-4091-9b3f-4d76f8842149?raw=true)

A colorful, structured logger for Flutter apps.

Snug Logger helps you:
- read logs faster with clean formatting and colors
- log by intent (`debug`, `info`, `error`, `production`)
- inspect Dio network traffic with optional cURL output
- get readable stack traces for error debugging

## Install

```yaml
dependencies:
  snug_logger: ^1.0.11
```

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:snug_logger/snug_logger.dart';

snugLog('App started', logType: LogType.info);
snugLog('Fetching user profile', logType: LogType.debug);
```

### Error Logging with Stack Trace

```dart
try {
  throw Exception('Something went wrong');
} catch (error, stackTrace) {
  snugLog(
    error,
    logType: LogType.error,
    stackTrace: stackTrace,
  );
}
```

## Network Logging (Dio)

```dart
_dio.interceptors.add(
  SnugDioLogger(
    requestHeaders: true,
    requestData: true,
    responseHeaders: true,
    responseData: true,
    showCurl: true,
    logPrint: (object) => debugPrint(object.toString()),
  ),
);
```

When `showCurl: true` is enabled, Snug Logger prints reproducible cURL commands so you can quickly share failing requests with backend teams.

## What You Can Configure

- `requestHeaders`: include request headers
- `requestData`: include request body/query
- `responseHeaders`: include response headers
- `responseData`: include response body
- `showCurl`: print cURL command for each request

## Advanced Stack Trace Utilities

If you want direct control over stack trace formatting:

```dart
final formatted = StackTraceFormatter.format(stackTrace);
final terse = StackTraceFormatter.formatTerse(stackTrace);
final snug = StackTraceFormatter.formatForSnugLogger(stackTrace);
```

## Contributing

- 💬 [Open an Issue](https://github.com/wmtrnsapanzaveri/snug_logger/issues)
- 📥 [Submit a Pull Request](https://github.com/wmtrnsapanzaveri/snug_logger/pulls)

## Thanks to Contributors

Thanks to everyone who contributed features, fixes, docs, and reviews, including the cURL printing enhancement.

### Contributor Wall

[![Contributors](https://contrib.rocks/image?repo=wmtrnsapanzaveri/snug_logger)](https://github.com/wmtrnsapanzaveri/snug_logger/graphs/contributors)

- 👥 [View all contributors](https://github.com/wmtrnsapanzaveri/snug_logger/graphs/contributors)
