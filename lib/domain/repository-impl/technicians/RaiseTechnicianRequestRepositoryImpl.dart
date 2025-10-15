import 'package:quickWork/data/datasource/technicians/RaiseTechnicianRequestRemoteDataSource.dart';
import 'package:quickWork/domain/repository/technicians/RaiseTechnicianRequestRepository.dart';

class RaiseTechnicianRequestRepositoryImpl
    implements RaiseTechnicianRequestRepository {
  final RaiseTechnicianRequestRemoteDataSource remoteDataSource;

  RaiseTechnicianRequestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> raiseRequest(Map<String, dynamic> requestBody) async {
    await remoteDataSource.raiseRequest(requestBody);
  }
}
