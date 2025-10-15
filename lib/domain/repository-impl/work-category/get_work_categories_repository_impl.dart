import 'package:quickWork/data/datasource/work-category/get_work_categories_remote_data_source.dart';
import 'package:quickWork/data/model/work-category/GetWorkCategoriesModel.dart';
import 'package:quickWork/domain/repository/work-category/get_work_categories_repository.dart';

class GetWorkCategoriesRepositoryImpl implements GetWorkCategoriesRepository {
  final GetWorkCategoriesRemoteDataSource remoteDataSource;

  GetWorkCategoriesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<GetWorkCategoriesModel>> fetchWorkCategories() async {
    return await remoteDataSource.getWorkCategories();
  }
}
