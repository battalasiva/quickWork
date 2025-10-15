import 'package:quickWork/data/datasource/work-request/get_work_requests_list_remote_data_source.dart';
import 'package:quickWork/data/model/work-request/GetWorkRequestsListModel.dart';
import 'package:quickWork/domain/repository/work-request/get_work_requests_list_repository.dart';

class GetWorkRequestsListRepositoryImpl
    implements GetWorkRequestsListRepository {
  final GetWorkRequestsListRemoteDataSource remoteDataSource;

  GetWorkRequestsListRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<GetWorkRequestsListModel>> fetchWorkRequests() async {
    return await remoteDataSource.fetchWorkRequests();
  }
}
