import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:snug_logger/snug_logger.dart';

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
    // Add TalkerDioLogger to Dio instance
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talker Package Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => snugLog('Having fun with Demo Data! 🚀',LogType.info),
              child: const Text('Demo Data Print'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => snugLog('Enjoying a Demo Info message! 🌟'),
              child: const Text('Demo Info Print'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  snugLog('Just having a good time with Debug! 🔍'),
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

  _handleError(int i, int divisor) {
    try {
      if (divisor == 0) {
        throw Exception(
            'Cannot divide by zero. Mathematical paradox detected! 🧮');
      }
      return i / divisor;
    } catch (error, stackTrace) {
      snugLog('$error', LogType.error, stackTrace);
    }
  }

  Future<void> _performSampleRequest() async {
    try {
      // Sample Dio request
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/1');
      snugLog('Dio Request Successful! Response: ${response.data} 🎉',
          LogType.info);
      log("${response.data}");
    } catch (error, stackTrace) {
      snugLog('$error', LogType.error, stackTrace);
    }
  }

  Future<void> _performErrorRequest() async {
    try {
      // Sample Dio request with intentional error
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts/invalid');
      snugLog('Dio Error Request Successful! Response: ${response.data} 🚨',
          LogType.debug);
    } catch (error, stackTrace) {
      snugLog('$error', LogType.error, stackTrace);
    }
  }
}
