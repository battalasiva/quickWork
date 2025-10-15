import 'package:quickWork/data/datasource/work-category/delete_work_category_remote_data_source.dart';
import 'package:quickWork/domain/repository/work-category/delete_work_category_repository.dart';

class DeleteWorkCategoryRepositoryImpl implements DeleteWorkCategoryRepository {
  final DeleteWorkCategoryRemoteDataSource remoteDataSource;

  DeleteWorkCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> deleteCategory(int id) async {
    await remoteDataSource.deleteWorkCategory(id);
  }
}
