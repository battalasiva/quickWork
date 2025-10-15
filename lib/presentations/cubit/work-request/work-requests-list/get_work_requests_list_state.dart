import 'package:quickWork/data/model/work-request/GetWorkRequestsListModel.dart';

abstract class GetWorkRequestsListState {}

class GetWorkRequestsListInitial extends GetWorkRequestsListState {}

class GetWorkRequestsListLoading extends GetWorkRequestsListState {}

class GetWorkRequestsListLoaded extends GetWorkRequestsListState {
  final List<GetWorkRequestsListModel> workRequests;
  GetWorkRequestsListLoaded(this.workRequests);
}

class GetWorkRequestsListError extends GetWorkRequestsListState {
  final String message;
  GetWorkRequestsListError(this.message);
}
