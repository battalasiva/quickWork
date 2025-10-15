import 'package:dio/dio.dart';
import 'package:quickWork/core/constants/api_urls.dart';
import 'package:quickWork/data/model/technicians/GetTechniciansListModel.dart';

abstract class GetTechniciansListRemoteDataSource {
  Future<List<GetTechniciansListModel>> fetchTechnicians();
}

class GetTechniciansListRemoteDataSourceImpl
    implements GetTechniciansListRemoteDataSource {
  final Dio client;

  GetTechniciansListRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GetTechniciansListModel>> fetchTechnicians() async {
    try {
      final response = await client.get(getTechnitiansUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => GetTechniciansListModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load technicians: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error while fetching technicians: ${e.toString()}');
    }
  }
}
