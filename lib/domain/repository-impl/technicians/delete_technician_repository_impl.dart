import 'package:quickWork/data/datasource/technicians/delete_technician_remote_data_source.dart';
import 'package:quickWork/domain/repository/technicians/delete_technician_repository.dart';

class DeleteTechnicianRepositoryImpl implements DeleteTechnicianRepository {
  final DeleteTechnicianRemoteDataSource remoteDataSource;

  DeleteTechnicianRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> deleteTechnician(int id) async {
    await remoteDataSource.deleteTechnician(id);
  }
}
