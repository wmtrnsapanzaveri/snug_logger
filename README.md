# snug_logger 🛋️

A cozy and efficient logging package for Flutter applications.

## Welcome 🚀

Your vibrant Flutter companion, making logging a joyful dance of information. Let it add playfulness to your code canvas. Relax, enjoy the coding fiesta, and let your development journey be a lively celebration! 🌟💻🎉

## Features ✨

The `snug_logger` package brings a delightful blend of features to enhance your logging and network
request handling in Flutter development. Here's a breakdown of its key attributes:

1. **Colorful Logging:**
    - Dynamic and colorful log messages for different log levels, making debugging a visual and
      enjoyable experience.
    - Emoji-based log type indicators, adding a touch of playfulness to your logs.

2. **Dynamic Log Types:**
    - Supports various log types, including debug, info, production, and a error log type.

3. **Network Request Handling:**
    - A dedicated `SnugDioLogger()` for handling Dio network requests with detailed logging options.
    - Granular control over logging request headers, response headers, response data, and more.

4. **Structured Log Formatting:**
    - Well-organized log templates with clear sections for easy readability.
    - Consistent formatting across different log types for a professional and polished appearance.

In essence, `snug_logger` is not just a logging package; it's a toolkit designed to infuse color,
structure, and joy into your development journey. From dynamic and fun logs to seamless network
request handling, this package offers a cozy and feature-rich experience for Flutter developers.

## Installation 🚀

Get snug in seconds! Add `snug_logger` to your `pubspec.yaml` file:

```yaml
dependencies:
  snug_logger: ^1.0.0
  ```

## Then, run 🕺

```
flutter pub get
  ```

# Usage 🎭

## Import the package

```
import 'package:snug_logger/snug_logger.dart';
```

## Log Messages

```
snugLog(
  "This is a debug message",
  LogType.debug,
);

snugLog(
  "This is a debug message",
  LogType.info,
);

snugLog(
  "This is a debug message",
  LogType.production,
);

snugLog(
  "This is a debug message",
  LogType.error,
);
```

## Elevate Your Dio Network Logs with `SnugDioLogger()`! 🌐 🚀

#### Introducing the `SnugDioLogger` – your go-to companion for handling Dio network requests with style and precision. With just a few lines of code, elevate your network request logging game to a whole new level of coziness!

```
Dio _dio = Dio();
_dio.interceptors.add(SnugDioLogger());
  // customization
 _dio.interceptors.add(
   SnugDioLogger(
    responseMessage: true,
    responseData: true,
    requestData: true,
    requestHeader: true,
    requestHeaders: true,
    logPrint: (object) {
      debugPrint(object.toString());
    },
  ),
);
   ```

# 🚀 Join the Snug Squad!

#### Whether you're a coding ninja, a bug whisperer, or just someone spreading good vibes, we're all ears! Dive into the cozy chaos, open up an issue, or drop in a pull request – let's make this space warmer together. Your ideas, fixes, or just a virtual high-five are all welcome. The more, the merrier! ✨
