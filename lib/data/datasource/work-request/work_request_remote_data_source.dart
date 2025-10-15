import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:quickWork/core/constants/api_urls.dart';

abstract class WorkRequestRemoteDataSource {
  Future<void> createWorkRequest(Map<String, dynamic> body);
}

class WorkRequestRemoteDataSourceImpl implements WorkRequestRemoteDataSource {
  final Dio client;

  WorkRequestRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createWorkRequest(Map<String, dynamic> body) async {
    try {
      debugPrint('BODY :: $workRequestUrl $body');
      final response = await client.post(
        workRequestUrl, // define this in api_constants.dart
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Work Request created successfully: $response");
      } else {
        throw Exception(
          'Failed to create Work Request: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error while creating Work Request: ${e.toString()}');
    }
  }
}
