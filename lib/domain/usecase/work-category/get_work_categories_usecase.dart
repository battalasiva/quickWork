import 'package:quickWork/data/model/work-category/GetWorkCategoriesModel.dart';
import 'package:quickWork/domain/repository/work-category/get_work_categories_repository.dart';

class GetWorkCategoriesUseCase {
  final GetWorkCategoriesRepository repository;

  GetWorkCategoriesUseCase(this.repository);

  Future<List<GetWorkCategoriesModel>> call() async {
    return await repository.fetchWorkCategories();
  }
}
