# <span style="color:#00bfff;">snug_logger</span> 🛋️

A cozy and efficient logging package for Flutter applications.

![Snug Logger Gif](assets/gif/snug-logger.gif)

## Welcome 🚀

Your vibrant Flutter companion, making logging a joyful dance of information. Let it add playfulness
to your code canvas. Relax, enjoy the coding fiesta, and let your development journey be a lively
celebration! 🌟💻🎉

## Features Overview:

### 1. Colorful Logging:

- Dynamic and colorful log messages for different levels, enhancing visual debugging.
- Emoji-based log level indicators add a playful touch to logs.

### 2. Dynamic Log Levels:

- Supports various log levels: debug, info, production, and error.

### 3. Network Request Handling:

- Introduces `SnugDioLogger` for handling Dio network requests with detailed logging options.
- Granular control over logging request headers, response headers, response data, and more.

### 4. Structured Log Formatting:

- Well-organized log templates with clear sections for easy readability.
- Consistent formatting across different log levels for a professional appearance.

## Installation:

Add the `snug_logger` package to your `pubspec.yaml` file:

```yaml
dependencies:
  snug_logger: ^1.0.4
```

Run:

```bash
flutter pub get
```

## Usage:

### Import the package:

```dart
import 'package:snug_logger/snug_logger.dart';
```

### Log Messages:

#### Debug Message Example:

```
snugLog
("This is a debug message
"
,LogType.
debug
,
);
```

#### Production Message Example:

```
snugLog
("This is a production message
"
,LogType.
debug
,
);
```

#### Info Message Example:

```
snugLog
("This is an info message
"
,LogType.
debug
,
);
```

### SnugDioLogger for Dio Network Requests:

```
Dio _dio = Dio();

_dio.interceptors.add(
  SnugDioLogger(
    responseMessage: true,
    responseData: true,
    requestData: true,
    responseHeaders: false,
    requestHeaders: false,
    logPrint: (object) {
      debugPrint(object.toString());
    },
  ),
);
```

## Join the Snug Squad:

- [Open an Issue](https://github.com/wmtrnsapanzaveri/snug_logger/issues)
- [Submit a Pull Request](https://github.com/wmtrnsapanzaveri/snug_logger/pulls)

[//]: # (- [Join our Discussion Forum]&#40;link_to_forum&#41;)

Feel free to contribute, discuss, or just spread good vibes! 🚀✨

If you have specific questions or optimizations you'd like me to explore in the code, please let me
know!
