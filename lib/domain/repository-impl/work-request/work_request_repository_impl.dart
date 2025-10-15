import 'package:quickWork/data/datasource/work-request/work_request_remote_data_source.dart';
import 'package:quickWork/domain/repository/work-request/work_request_repository.dart';

class WorkRequestRepositoryImpl implements WorkRequestRepository {
  final WorkRequestRemoteDataSource remoteDataSource;

  WorkRequestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createWorkRequest(Map<String, dynamic> body) async {
    await remoteDataSource.createWorkRequest(body);
  }
}
