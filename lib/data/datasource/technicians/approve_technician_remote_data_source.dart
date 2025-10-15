import 'package:dio/dio.dart';
import 'package:quickWork/core/constants/api_urls.dart';

abstract class ApproveTechnicianRemoteDataSource {
  Future<void> approveTechnician(int id);
}

class ApproveTechnicianRemoteDataSourceImpl
    implements ApproveTechnicianRemoteDataSource {
  final Dio client;

  ApproveTechnicianRemoteDataSourceImpl({required this.client});

  @override
  Future<void> approveTechnician(int id) async {
    final url = approveTechnicianUrl(id);
    try {
      final response = await client.post(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Technician approved successfully: $response");
      } else {
        throw Exception('Failed to approve technician: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error while approving technician: ${e.toString()}');
    }
  }
}
