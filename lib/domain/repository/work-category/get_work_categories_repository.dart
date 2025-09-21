import 'package:quickWork/data/model/work-category/GetWorkCategoriesModel.dart';

abstract class GetWorkCategoriesRepository {
  Future<List<GetWorkCategoriesModel>> fetchWorkCategories();
}
