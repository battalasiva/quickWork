import 'package:quickWork/data/datasource/technicians/approve_technician_remote_data_source.dart';
import 'package:quickWork/domain/repository/technicians/approve_technician_repository.dart';

class ApproveTechnicianRepositoryImpl implements ApproveTechnicianRepository {
  final ApproveTechnicianRemoteDataSource remoteDataSource;

  ApproveTechnicianRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> approveTechnician(int id) async {
    await remoteDataSource.approveTechnician(id);
  }
}
