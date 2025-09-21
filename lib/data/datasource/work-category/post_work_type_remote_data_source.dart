import 'package:dio/dio.dart';
import 'package:quickWork/core/constants/api_urls.dart';

abstract class PostWorkTypeRemoteDataSource {
  Future<void> postWorkType(Map<String, dynamic> body);
}

class PostWorkTypeRemoteDataSourceImpl implements PostWorkTypeRemoteDataSource {
  final Dio client;

  PostWorkTypeRemoteDataSourceImpl({required this.client});

  @override
  Future<void> postWorkType(Map<String, dynamic> body) async {
    try {
      final response = await client.post(createGetworkTypeUrl, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Work type created successfully: $response");
      } else {
        throw Exception("Failed to create work type: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error while creating work type: ${e.toString()}");
    }
  }
}
