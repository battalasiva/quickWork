import 'package:dio/dio.dart';
import 'package:quickWork/core/constants/api_urls.dart';
import 'package:quickWork/data/model/work-request/GetWorkRequestsListModel.dart';

abstract class GetWorkRequestsListRemoteDataSource {
  Future<List<GetWorkRequestsListModel>> fetchWorkRequests();
}

class GetWorkRequestsListRemoteDataSourceImpl
    implements GetWorkRequestsListRemoteDataSource {
  final Dio client;

  GetWorkRequestsListRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GetWorkRequestsListModel>> fetchWorkRequests() async {
    try {
      final response = await client.get(workRequestUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => GetWorkRequestsListModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load work requests: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error while fetching work requests: ${e.toString()}');
    }
  }
}
