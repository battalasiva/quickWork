import 'package:quickWork/data/model/work-category/GetWorkCategoriesModel.dart';

abstract class GetWorkCategoriesState {}

class GetWorkCategoriesInitial extends GetWorkCategoriesState {}

class GetWorkCategoriesLoading extends GetWorkCategoriesState {}

class GetWorkCategoriesSuccess extends GetWorkCategoriesState {
  final List<GetWorkCategoriesModel> categories;

  GetWorkCategoriesSuccess(this.categories);
}

class GetWorkCategoriesError extends GetWorkCategoriesState {
  final String message;

  GetWorkCategoriesError(this.message);
}
