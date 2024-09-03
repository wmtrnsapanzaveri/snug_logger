# <span style="color:#00bfff;">snug_logger</span> 🛋️

A logging package for Flutter that's as comfy as your favorite hoodie and as efficient as a
well-oiled machine.

<a href="https://app.commanddash.io/agent/github_wmtrnsapanzaveri_snug_logger"><img src="https://img.shields.io/badge/AI-Code%20Agent-EB9FDA"></a>

![Snug Logger Gif](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYmpldThtZTNyMzM3MGU2dmg1eHA4NTBseG1rMHZrdmRoN2Fpc3ByMSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/boJT0xmU97bUlb5HjU/giphy-downsized-large.gif)

## Welcome 🚀

Say goodbye to boring logs and hello to vibrant, colorful messages! Snug Logger makes logging a
joyful dance of information. Let it add a touch of fun to your code canvas and make your development
journey a lively celebration! 🌟💻🎉

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
  snug_logger: ^1.0.8
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

#### Info Message Example:

```dart
snugLog("This is an info message, just like a good dad joke, it's informative and amusing! 👨‍👧‍👦🤣", 
        logType:LogType.info);
```

#### Debug Message Example:

```dart
snugLog("This is a debug message, but don't worry, I'm debugging it with a magnifying glass, not a clown nose! 🤡🔍",
         logType:LogType.debug);
```

#### Error Message Example:

```dart
    snugLog(
        "Uh-oh, something went wrong! But don\'t worry, I'm on it! 🦸‍♂️🔧",
        logType:LogType.error,
        stackTrace: StackTrace.current
    );
```

#### Production Message Example:

```dart
snugLog("This is a production message, like a well-crafted joke, it's ready for the big stage! 🎭😄", 
        logType:LogType.production);
```
    
### SnugDioLogger for Dio Network Requests:

```dart
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

Feel free to contribute, discuss, or just spread good vibes! 🚀✨

If you have specific questions or optimizations you'd like me to explore in the code, please let me
know! We are all here to learn and grow together. 🌟

---

*Why don't programmers like nature? It has too many bugs! 🐜🌿* 😄
