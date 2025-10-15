import 'package:quickWork/data/model/work-request/GetWorkRequestsListModel.dart';
import 'package:quickWork/domain/repository/work-request/get_work_requests_list_repository.dart';

class GetWorkRequestsListUseCase {
  final GetWorkRequestsListRepository repository;

  GetWorkRequestsListUseCase(this.repository);

  Future<List<GetWorkRequestsListModel>> call() async {
    return await repository.fetchWorkRequests();
  }
}
