import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snug_logger/snug_logger.dart';

void main() {
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snug Logger Use Case Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// Home page widget with state
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

    // Add SnugDioLogger to Dio instance in debug mode
    if (kDebugMode) {
      _dio.interceptors.add(
        SnugDioLogger(
          requestData: false,
          // Fetch request data
          requestHeaders: false,
          // Fetch request headers
          responseData: true,
          // Fetch response data
          responseHeaders: false,
          // Fetch response headers
          showCurl: true,
          // Gives you the request in curl format
          logPrint: (object) {
            // Use debugPrint to print logs so it won't be printed in release mode
            debugPrint(object.toString());
          },
        ),
      );
    }
  }

  // Method to handle division by zero error
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

  // Method to perform a sample Dio GET request
  Future<void> _performSampleRequest() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/1');
      snugLog('Dio Request Successful! Response: ${response.data} 🎉',
          logType: LogType.info);
      log("${response.data}");
    } catch (error, stackTrace) {
      snugLog('$error', logType: LogType.error, stackTrace: stackTrace);
    }
  }

  // Method to perform a Dio GET request with an intentional error
  Future<void> _performErrorRequest() async {
    try {
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
              onPressed: () =>
                  snugLog('Enjoying a Info message! 🌟', logType: LogType.info),
              child: const Text('Info message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  snugLog('Just having a good time with Debug! 🔍'),
              child: const Text('Debug message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => snugLog('Heavy Debugging in Production! 🛠️ ',
                  logType: LogType.production),
              child: const Text('Production message'),
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
          ],
        ),
      ),
    );
  }
}
