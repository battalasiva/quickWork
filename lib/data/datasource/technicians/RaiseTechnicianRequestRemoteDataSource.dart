import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/api_urls.dart';

abstract class RaiseTechnicianRequestRemoteDataSource {
  Future<void> raiseRequest(Map<String, dynamic> requestBody);
}

class RaiseTechnicianRequestRemoteDataSourceImpl
    implements RaiseTechnicianRequestRemoteDataSource {
  final Dio client;

  RaiseTechnicianRequestRemoteDataSourceImpl({required this.client});

  @override
  Future<void> raiseRequest(Map<String, dynamic> requestBody) async {
    try {
      debugPrint('REQUEST BODY :: $createTechnitiansUrl $requestBody');
      final response = await client.post(
        createTechnitiansUrl, // defined in api_constants.dart
        data: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Technician request raised successfully: $response");
      } else {
        throw Exception(
          'Failed to raise technician request: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception(
        'Error while raising technician request: ${e.toString()}',
      );
    }
  }
}
