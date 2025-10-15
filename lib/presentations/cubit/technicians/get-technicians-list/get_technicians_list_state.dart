import 'package:quickWork/data/model/technicians/GetTechniciansListModel.dart';

abstract class GetTechniciansListState {}

class GetTechniciansListInitial extends GetTechniciansListState {}

class GetTechniciansListLoading extends GetTechniciansListState {}

class GetTechniciansListSuccess extends GetTechniciansListState {
  final List<GetTechniciansListModel> technicians;
  GetTechniciansListSuccess(this.technicians);
}

class GetTechniciansListError extends GetTechniciansListState {
  final String message;
  GetTechniciansListError(this.message);
}
