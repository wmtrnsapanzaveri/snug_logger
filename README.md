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

## Installation:

Getting started with Snug Logger is a breeze! Add it to your `pubspec.yaml` file:

```yaml
dependencies:
  snug_logger: ^1.0.10
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

#### Example: Error Log

```dart
snugLog(
  "Oops! Something went wrong, but don't worry, I've got the toolkit ready! 🦸‍♂️🔧", 
  logType: LogType.error,
  stackTrace: StackTrace.current
);
```

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
    logPrint: (object) => debugPrint(object.toString()),
  ),
);
```

You control exactly what gets logged—headers, request data, or full responses. 🕵️‍♂️

## Join the Snug Squad!

Got ideas or feedback? We’re all ears! Here’s how to get involved:

- 💬 [Open an Issue](https://github.com/wmtrnsapanzaveri/snug_logger/issues)
- 📥 [Submit a Pull Request](https://github.com/wmtrnsapanzaveri/snug_logger/pulls)

Let’s make logging a delightful part of coding! 🚀✨

---

*Why did the programmer go broke? Because they used up all their cache! 💸😄*

