import 'package:quickWork/data/model/work-request/GetWorkRequestsListModel.dart';

abstract class GetWorkRequestsListRepository {
  Future<List<GetWorkRequestsListModel>> fetchWorkRequests();
}
