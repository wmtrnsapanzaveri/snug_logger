import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:snug_logger/snug_logger.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();

    /// Add SnugDioLogger to Dio instance
    if (kDebugMode) {
      _dio.interceptors.add(
        SnugDioLogger(
          /// Use to fetch request data
          requestData: false,

          /// Use to fetch request headers
          requestHeaders: false,

          /// Use to fetch response message
          responseMessage: false,

          /// Use to fetch response data
          responseData: true,

          /// Use to fetch response headers
          responseHeaders: false,

          logPrint: (object) {
            /// use debugPrint to print logs so it won't be printed in release mode
            /// or add the interceptors with KDebugMode condition as shown above.
            debugPrint(object.toString());
          },
        ),
      );
    }
  }

  _handleError(int i, int divisor) {
    try {
      if (divisor == 0) {
        throw Exception(
            'Cannot divide by zero. Mathematical paradox detected! 🧮');
      }
      return i / divisor;
    } catch (error, stackTrace) {
      snugLog('$error', logType: LogType.error, stackTrace: stackTrace);
    }
  }

  Future<void> _performSampleRequest() async {
    try {
      // Sample Dio request
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/1');
      snugLog('Dio Request Successful! Response: ${response.data} 🎉',
          logType: LogType.info);
      log("${response.data}");
    } catch (error, stackTrace) {
      snugLog('$error', logType: LogType.error, stackTrace: stackTrace);
    }
  }

  Future<void> _performErrorRequest() async {
    try {
      // Sample Dio request with intentional error
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/invalid');
      snugLog('Dio Error Request Successful! Response: ${response.data} 🚨',
          logType: LogType.debug);
    } catch (error, stackTrace) {
      snugLog('$error', logType: LogType.error, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnugLogger Package Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => snugLog('Having fun with Demo Data! 🚀'),
              child: const Text('Demo Data Print'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => snugLog('Enjoying a Demo Info message! 🌟',
                  logType: LogType.info),
              child: const Text('Demo Info Print'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  snugLog('Just having a good time with Debug! 🔍'),
              child: const Text('Demo Debug message'),
            ),
            ElevatedButton(
              onPressed: () => snugLog('Heavy Debugging in Production! 🛠️ ',
                  logType: LogType.production),
              child: const Text('Demo Debug message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _handleError(10, 0),
              child: const Text('Throw Custom Error'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performSampleRequest,
              child: const Text('Perform Dio Request'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performErrorRequest,
              child: const Text('Perform Dio Request With Error'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performErrorRequest,
              child: const Text('Print custom logs'),
            ),
          ],
        ),
      ),
    );
  }
}
