import 'package:dio/dio.dart';
import 'package:quickWork/core/constants/api_urls.dart';
import 'package:quickWork/data/model/work-category/GetWorkCategoriesModel.dart';

abstract class GetWorkCategoriesRemoteDataSource {
  Future<List<GetWorkCategoriesModel>> getWorkCategories();
}

class GetWorkCategoriesRemoteDataSourceImpl
    implements GetWorkCategoriesRemoteDataSource {
  final Dio client;

  GetWorkCategoriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<GetWorkCategoriesModel>> getWorkCategories() async {
    try {
      final response = await client.get(createGetworkTypeUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => GetWorkCategoriesModel.fromJson(json)).toList();
      } else {
        throw Exception(
          "Failed to fetch work categories: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error while fetching work categories: ${e.toString()}");
    }
  }
}
