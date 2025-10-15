import 'package:dio/dio.dart';

abstract class DeleteTechnicianRemoteDataSource {
  Future<void> deleteTechnician(int id);
}

class DeleteTechnicianRemoteDataSourceImpl
    implements DeleteTechnicianRemoteDataSource {
  final Dio client;

  DeleteTechnicianRemoteDataSourceImpl({required this.client});

  @override
  Future<void> deleteTechnician(int id) async {
    try {
      final response = await client.delete(deleteTechnician(id) as String);

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Technician deleted successfully: $response");
      } else {
        throw Exception('Failed to delete technician: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error while deleting technician: ${e.toString()}');
    }
  }
}
