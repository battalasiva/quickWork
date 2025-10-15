import 'package:quickWork/data/datasource/work-category/post_work_type_remote_data_source.dart';
import 'package:quickWork/domain/repository/work-category/post_work_type_repository.dart';

class PostWorkTypeRepositoryImpl implements PostWorkTypeRepository {
  final PostWorkTypeRemoteDataSource remoteDataSource;

  PostWorkTypeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createWorkType(Map<String, dynamic> body) async {
    await remoteDataSource.postWorkType(body);
  }
}
