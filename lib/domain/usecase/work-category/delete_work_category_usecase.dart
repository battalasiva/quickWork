import 'package:quickWork/domain/repository/work-category/delete_work_category_repository.dart';

class DeleteWorkCategoryUseCase {
  final DeleteWorkCategoryRepository repository;

  DeleteWorkCategoryUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteCategory(id);
  }
}
