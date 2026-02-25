# <span style="color:#00bfff;">Snug Logger</span> 🛋️

![Snug_Logger (2)](https://github.com/user-attachments/assets/a9678707-4f25-4091-9b3f-4d76f8842149)


<span> Spice up your logs with **Snug Logger**! 🎉🛋️ <br>
<a href="https://app.commanddash.io/agent/github_wmtrnsapanzaveri_snug_logger" style="font-weight:bold; color:#00bfff;">Click here to try it out! 🚀✨</a>  
</span>

## Welcome to Snug Logger! 🚀

Wave goodbye to mundane, dull logs and embrace the colorful, emoji-filled world of **Snug Logger**! 🎉💻✨ With us, debugging is no longer a chore but a lively, fun-filled experience.

## Why Choose Snug Logger?

- 🛋️ **Cozy to Use**: Vibrant and clear log messages that are as comforting as your favorite hoodie.
- 🎨 **Color-Coded Clarity**: Instantly spot log levels with our dynamic colors and emojis.
- 📊 **Professional Structure**: Playful yet organized, ensuring your logs are both engaging and easy to navigate.

## Features:

### 1. **Colorful Logging**:
- Brighten up your log readability with dynamic colors for different log levels.
- Emojis bring your logs to life: 🐞 for debug, ℹ️ for info, 🚨 for error, and more!

### 2. **Versatile Log Levels**:
- Log various levels: `debug`, `info`, `error`, and `production`. Each has its own role, keeping your logs purposeful and organized.

### 3. **SnugDioLogger for Network Requests**:
- Enhance your network request logs with **SnugDioLogger** for detailed insights into every request and response.
- Tailor what you log—headers, request data, and response content—with fine-tuned control.

### 4. **Structured Log Formatting**:
- Logs follow a clear, structured template, blending fun with functionality.
- Consistent formatting across all levels for a polished, professional look.

### 5. **Beautiful Stack Trace Formatting** 🎨:
- **Snug Logger Style Formatting**: Stack traces automatically match your log output's cozy, structured aesthetic with box-drawing characters (│), frame numbers, and proper color coding! 🛋️
- **Human-readable stack traces**: Formats stack traces in a clean, aligned format showing file paths, line numbers, and function names.
- **Terse formatting**: Simplifies stack traces by removing internal Dart core library details, focusing on your code.
- **Async stack chain support**: Track stack traces through asynchronous operations using Zones for complete error visibility.
- **Zero dependencies**: Fully self-contained implementation with no external packages required - everything built from scratch! ✨

## Installation:

Getting started with Snug Logger is a breeze! Add it to your `pubspec.yaml` file:

```yaml
dependencies:
  snug_logger: ^1.0.11
```

Then, fetch the package:

```bash
flutter pub get
```

## Quick Start:

### Import the Package:

```dart
import 'package:snug_logger/snug_logger.dart';
```

### Basic Usage:

Bring some flair to your logs with just a few lines of code!

#### Example: Info Log

```dart
snugLog(
  "This is an info message, filled with dad-joke-level wisdom and charm! 👨‍👧‍👦🤣", 
  logType: LogType.info
);
```

#### Example: Debug Log

```dart
snugLog(
  "Debugging with precision! No clowns involved, just pure detective work. 🤡🔍", 
  logType: LogType.debug
);
```

#### Example: Error Log with Beautiful Stack Trace

```dart
try {
  // Your code that might throw an error
  throw Exception('Something went wrong!');
} catch (error, stackTrace) {
  snugLog(
    "Oops! Something went wrong, but don't worry, I've got the toolkit ready! 🦸‍♂️🔧", 
    logType: LogType.error,
    stackTrace: stackTrace
  );
}
```

Error logs automatically include **beautifully formatted stack traces** in Snug Logger's signature style! 🎯 Stack traces are formatted with:
- Box-drawing characters (│) matching the log structure
- Frame numbers for easy reference
- Proper color coding (red for errors)
- Terse formatting that focuses on your code, not Dart internals
- Clean, aligned formatting that blends seamlessly with your logs

#### Example: Production Log

```dart
snugLog(
  "Production-ready logs: polished, professional, and prepared for the spotlight! 🎭😄", 
  logType: LogType.production
);
```

### Network Logging with SnugDioLogger:

Integrate **SnugDioLogger** for detailed network request logs:

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

You control exactly what gets logged—headers, request data, or full responses. 🕵️‍♂️

### Advanced: Stack Trace Formatting

Snug Logger provides powerful stack trace formatting utilities for advanced use cases. All features are **self-contained with zero external dependencies**! 🎉

#### Format Stack Traces in Snug Logger Style

```dart
import 'package:snug_logger/snug_logger.dart';

// Format in Snug Logger's cozy style (matches your log output!)
final snugFormatted = StackTraceFormatter.formatForSnugLogger(
  stackTrace,
  useTerse: true,
  colorPrefix: '\u001b[31m',  // Red color
  colorSuffix: '\u001b[0m',    // Reset
);

// Human-readable format
final formatted = StackTraceFormatter.format(stackTrace);

// Terse format (removes Dart core library frames)
final terse = StackTraceFormatter.formatTerse(stackTrace);

// Format specifically for errors
final errorTrace = StackTraceFormatter.formatForError(stackTrace, useTerse: true);
```

#### Capture Async Stack Chains

Track stack traces through asynchronous operations:

```dart
StackTraceFormatter.capture(() {
  Future.delayed(Duration(seconds: 1)).then((_) {
    throw 'Error in async operation!';
  });
}, onError: (error, chain) {
  print('Error: $error');
  print('Stack Chain:\n${StackTraceFormatter.formatChainTerse(chain)}');
});
```

#### Get Current Trace

```dart
final currentTrace = StackTraceFormatter.getCurrentTrace();
print(currentTrace.toTerseString());
```

#### Convert StackTrace to Trace Object

```dart
final trace = StackTraceFormatter.fromStackTrace(stackTrace);
print(trace.toString());              // Full format
print(trace.toTerseString());         // Terse format
print(trace.toSnugLoggerString());    // Snug Logger style format! 🛋️
```

#### Zero Dependencies! 🎉

All stack trace functionality is **completely self-contained** - no external packages required! We've implemented everything from scratch to give you full control and keep your dependencies minimal. The implementation includes:
- Custom stack trace parsing
- Beautiful formatting with aligned columns
- Terse formatting that removes clutter
- Async stack chain support using Dart Zones
- Snug Logger style formatting that matches your logs perfectly

## Join the Snug Squad!

Got ideas or feedback? We’re all ears! Here’s how to get involved:

- 💬 [Open an Issue](https://github.com/wmtrnsapanzaveri/snug_logger/issues)
- 📥 [Submit a Pull Request](https://github.com/wmtrnsapanzaveri/snug_logger/pulls)

Let’s make logging a delightful part of coding! 🚀✨

---

*Why did the programmer go broke? Because they used up all their cache! 💸😄*
