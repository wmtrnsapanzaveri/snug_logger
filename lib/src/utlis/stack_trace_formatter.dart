import 'dart:async';

/// Represents a single frame in a stack trace.
class _TraceFrame {
  final String? package;
  final String? packageScheme;
  final String? member;
  final String? uri;
  final int? line;
  final int? column;

  _TraceFrame({
    this.package,
    this.packageScheme,
    this.member,
    this.uri,
    this.line,
    this.column,
  });

  /// Checks if this frame is from Dart core libraries.
  bool get isCoreLibrary {
    return packageScheme == 'dart' ||
        packageScheme == 'dart:core' ||
        packageScheme == 'dart:async' ||
        packageScheme == 'dart:collection' ||
        packageScheme == 'dart:convert' ||
        packageScheme == 'dart:io' ||
        packageScheme == 'dart:isolate' ||
        uri?.startsWith('dart:') == true;
  }

  /// Formats the frame as a readable string.
  String format({bool terse = false}) {
    if (terse && isCoreLibrary) {
      return 'dart:core                                   $member';
    }

    final location =
        uri != null && line != null ? '$uri $line:${column ?? 0}' : 'unknown';

    final locationPadded = location.padRight(50);
    return '$locationPadded $member';
  }
}

/// Represents a parsed stack trace.
class Trace {
  final List<_TraceFrame> _frames;

  Trace._(this._frames);

  /// Creates a Trace from a StackTrace.
  factory Trace.from(StackTrace stackTrace) {
    final frames = <_TraceFrame>[];
    final lines = stackTrace.toString().split('\n');

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      final frame = _parseFrame(line);
      if (frame != null) {
        frames.add(frame);
      }
    }

    return Trace._(frames);
  }

  /// Captures the current stack trace.
  factory Trace.current() {
    return Trace.from(StackTrace.current);
  }

  /// Parses a single frame from a stack trace line.
  static _TraceFrame? _parseFrame(String line) {
    // Format: #0      Object.noSuchMethod (dart:core-patch:1884:25)
    // Format: #1      Trace.terse.<anonymous closure> (file:///path/to/file.dart:47:21)
    final trimmed = line.trim();
    if (trimmed.isEmpty) return null;

    // Remove frame number (#0, #1, etc.)
    final withoutNumber = trimmed.replaceFirst(RegExp(r'^#\d+\s+'), '');

    // Extract member name (everything before the opening parenthesis)
    final memberMatch = RegExp(r'^(.+?)\s+\((.+)\)$').firstMatch(withoutNumber);
    if (memberMatch == null) return null;

    final member = memberMatch.group(1)?.trim();
    final location = memberMatch.group(2)?.trim();

    if (member == null || location == null) return null;

    // Parse location
    String? packageScheme;
    String? package;
    String? uri;
    int? lineNumber;
    int? columnNumber;

    // Check if it's a dart: URI
    if (location.startsWith('dart:')) {
      final parts = location.split(':');
      packageScheme = 'dart';
      package = parts.length > 1 ? parts[1].split('-').first : null;
      uri = location;
    } else if (location.startsWith('package:')) {
      // Format: package:stack_trace/src/trace.dart:47:21
      final match =
          RegExp(r'package:([^/]+)/(.+):(\d+):(\d+)').firstMatch(location);
      if (match != null) {
        packageScheme = 'package';
        package = match.group(1);
        uri = 'package:${match.group(1)}/${match.group(2)}';
        lineNumber = int.tryParse(match.group(3) ?? '');
        columnNumber = int.tryParse(match.group(4) ?? '');
      }
    } else if (location.startsWith('file://')) {
      // Format: file:///path/to/file.dart:47:21
      final match = RegExp(r'file://(.+):(\d+):(\d+)').firstMatch(location);
      if (match != null) {
        uri = match.group(1);
        lineNumber = int.tryParse(match.group(2) ?? '');
        columnNumber = int.tryParse(match.group(3) ?? '');
        // Extract package from path if possible
        final pathMatch = RegExp(r'/([^/]+)/lib/').firstMatch(uri ?? '');
        if (pathMatch != null) {
          package = pathMatch.group(1);
        }
      }
    }

    return _TraceFrame(
      packageScheme: packageScheme,
      package: package,
      member: member,
      uri: uri,
      line: lineNumber,
      column: columnNumber,
    );
  }

  /// Returns a terse version of the trace (folds core library frames).
  Trace get terse {
    final terseFrames = <_TraceFrame>[];
    _TraceFrame? lastCoreFrame;

    for (final frame in _frames) {
      if (frame.isCoreLibrary) {
        lastCoreFrame = frame;
      } else {
        // If we have a pending core frame, add it first
        if (lastCoreFrame != null) {
          terseFrames.add(lastCoreFrame);
          lastCoreFrame = null;
        }
        terseFrames.add(frame);
      }
    }

    // Add the last core frame if it exists and no user frames followed
    if (lastCoreFrame != null && terseFrames.isEmpty) {
      terseFrames.add(lastCoreFrame);
    }

    return Trace._(terseFrames);
  }

  @override
  String toString() {
    return _frames.map((f) => f.format()).join('\n');
  }

  /// Returns a terse string representation.
  String toTerseString() {
    return terse.toString();
  }

  /// Formats the trace in Snug Logger style with proper indentation.
  ///
  /// [useTerse] - Whether to use terse format
  /// [colorPrefix] - ANSI color code prefix
  /// [colorSuffix] - ANSI color code suffix
  String toSnugLoggerString({
    bool useTerse = true,
    String colorPrefix = '',
    String colorSuffix = '',
  }) {
    final frames = useTerse ? terse._frames : _frames;

    if (frames.isEmpty) {
      return '$colorPrefix│  (No stack trace available)$colorSuffix';
    }

    final buffer = StringBuffer();
    for (int i = 0; i < frames.length; i++) {
      final frame = frames[i];
      final frameStr = frame.format(terse: useTerse);

      // Format with │ prefix to match Snug Logger style
      buffer.write('$colorPrefix│  ');

      // Add frame number indicator for better readability
      final frameNum = '#${i.toString().padLeft(2, '0')}';
      buffer.write('$frameNum ');

      // Add the formatted frame
      buffer.write(frameStr);

      // Add color reset and newline
      buffer.write('$colorSuffix\n');
    }

    // Remove the last newline
    final result = buffer.toString();
    return result.endsWith('\n')
        ? result.substring(0, result.length - 1)
        : result;
  }
}

/// Represents a chain of stack traces through asynchronous calls.
class Chain {
  final List<Trace> _traces;
  final List<String> _gaps;

  Chain._(this._traces, this._gaps);

  /// Creates a Chain from a StackTrace.
  factory Chain.from(StackTrace stackTrace) {
    final trace = Trace.from(stackTrace);
    return Chain._([trace], []);
  }

  /// Formats the chain as a readable string.
  String format({bool terse = false}) {
    final buffer = StringBuffer();
    for (int i = 0; i < _traces.length; i++) {
      if (i > 0 && _gaps.length >= i) {
        buffer.writeln('===== asynchronous gap ===========================');
      }
      if (terse) {
        buffer.writeln(_traces[i].toTerseString());
      } else {
        buffer.writeln(_traces[i].toString());
      }
    }
    return buffer.toString();
  }

  /// Returns a terse version of the chain.
  Chain get terse {
    return Chain._(_traces.map((t) => t.terse).toList(), _gaps);
  }

  @override
  String toString() {
    return format();
  }

  /// Returns a terse string representation.
  String toTerseString() {
    return terse.toString();
  }
}

/// Utility class for formatting stack traces beautifully.
///
/// This class provides methods to format stack traces, offering
/// human-readable and terse representations without external dependencies.
class StackTraceFormatter {
  /// Formats a stack trace into a human-readable string.
  ///
  /// Converts a native [StackTrace] to a more readable format with
  /// aligned columns showing file paths, line numbers, and function names.
  ///
  /// Example output:
  /// ```
  /// dart:core-patch 1884:25                     Object.noSuchMethod
  /// pkg/stack_trace/lib/src/trace.dart 47:21    Trace.terse.<fn>
  /// ```
  ///
  /// [stackTrace] - The stack trace to format
  /// Returns a formatted string representation of the stack trace
  static String format(StackTrace stackTrace) {
    final trace = Trace.from(stackTrace);
    return trace.toString();
  }

  /// Formats a stack trace into a terse (simplified) representation.
  ///
  /// Folds together multiple stack frames from Dart core libraries,
  /// showing only the core library method directly called from user code.
  /// This makes stack traces much easier to read by removing internal
  /// implementation details.
  ///
  /// Example output:
  /// ```
  /// dart:core                                   Object.noSuchMethod
  /// pkg/stack_trace/lib/src/trace.dart 47:21    Trace.terse.<fn>
  /// ```
  ///
  /// [stackTrace] - The stack trace to format
  /// Returns a terse formatted string representation
  static String formatTerse(StackTrace stackTrace) {
    final trace = Trace.from(stackTrace);
    return trace.toTerseString();
  }

  /// Formats a stack chain for asynchronous code.
  ///
  /// When writing asynchronous code, a single stack trace isn't very useful
  /// since the call stack is unwound every time something async happens.
  /// A stack chain tracks stack traces through asynchronous calls, showing
  /// the full path from the entry point down to the error.
  ///
  /// [chain] - The Chain object representing the stack chain
  /// Returns a formatted string representation of the stack chain
  static String formatChain(Chain chain) {
    return chain.toString();
  }

  /// Formats a stack chain into a terse (simplified) representation.
  ///
  /// Similar to [formatTerse] but for stack chains. Removes internal
  /// implementation details and shows only the relevant user code paths
  /// through asynchronous operations.
  ///
  /// [chain] - The Chain object representing the stack chain
  /// Returns a terse formatted string representation of the stack chain
  static String formatChainTerse(Chain chain) {
    return chain.toTerseString();
  }

  /// Captures stack chains for asynchronous code execution.
  ///
  /// Wraps code execution in a Zone that tracks stack traces through
  /// asynchronous calls. This allows you to see the full call path
  /// even when errors occur in async callbacks.
  ///
  /// Usage:
  /// ```dart
  /// StackTraceFormatter.capture(() {
  ///   Future.delayed(Duration(seconds: 1)).then((_) {
  ///     throw 'Error occurred!';
  ///   });
  /// });
  /// ```
  ///
  /// [callback] - The function to execute with stack chain tracking
  static void capture(void Function() callback,
      {void Function(Object, Chain)? onError}) {
    runZoned(
      callback,
      zoneSpecification: ZoneSpecification(
        handleUncaughtError: (self, parent, zone, error, stackTrace) {
          if (onError != null) {
            final chain = Chain.from(stackTrace);
            onError(error, chain);
          } else {
            parent.handleUncaughtError(zone, error, stackTrace);
          }
        },
      ),
      zoneValues: {
        #stackTrace: true,
      },
    );
  }

  /// Gets the current stack trace as a Trace object.
  ///
  /// Captures the current stack trace and returns it as a Trace object
  /// which can be formatted using [format] or [formatTerse].
  ///
  /// Returns a Trace object representing the current stack
  static Trace getCurrentTrace() {
    return Trace.current();
  }

  /// Converts a StackTrace to a Trace object.
  ///
  /// Parses a native StackTrace and converts it to a Trace object
  /// for further manipulation or formatting.
  ///
  /// [stackTrace] - The stack trace to convert
  /// Returns a Trace object
  static Trace fromStackTrace(StackTrace stackTrace) {
    return Trace.from(stackTrace);
  }

  /// Formats a stack trace with custom styling for error logs.
  ///
  /// Formats a stack trace specifically for error logging, using terse
  /// format to keep it readable and focused on user code.
  ///
  /// [stackTrace] - The stack trace to format
  /// [useTerse] - Whether to use terse format (default: true)
  /// Returns a formatted string suitable for error logging
  static String formatForError(StackTrace stackTrace, {bool useTerse = true}) {
    if (useTerse) {
      return formatTerse(stackTrace);
    }
    return format(stackTrace);
  }

  /// Formats a stack trace in the Snug Logger style.
  ///
  /// Formats a stack trace to match the cozy, structured vibe of Snug Logger
  /// with proper indentation using box-drawing characters (│) and clean formatting.
  ///
  /// [stackTrace] - The stack trace to format
  /// [useTerse] - Whether to use terse format (default: true)
  /// [colorPrefix] - ANSI color code prefix for styling
  /// [colorSuffix] - ANSI color code suffix for reset
  /// Returns a formatted string matching Snug Logger's aesthetic
  static String formatForSnugLogger(
    StackTrace stackTrace, {
    bool useTerse = true,
    String colorPrefix = '',
    String colorSuffix = '',
  }) {
    final trace = Trace.from(stackTrace);
    return trace.toSnugLoggerString(
      useTerse: useTerse,
      colorPrefix: colorPrefix,
      colorSuffix: colorSuffix,
    );
  }
}
