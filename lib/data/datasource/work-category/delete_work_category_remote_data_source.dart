import 'package:dio/dio.dart';
import 'package:quickWork/core/constants/api_urls.dart';

abstract class DeleteWorkCategoryRemoteDataSource {
  Future<void> deleteWorkCategory(int id);
}

class DeleteWorkCategoryRemoteDataSourceImpl
    implements DeleteWorkCategoryRemoteDataSource {
  final Dio client;

  DeleteWorkCategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<void> deleteWorkCategory(int id) async {
    try {
      final response = await client.delete(workTypeById(id));

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Work category deleted successfully: $response");
      } else {
        throw Exception(
          "Failed to delete work category: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Error while deleting work category: ${e.toString()}");
    }
  }
}
