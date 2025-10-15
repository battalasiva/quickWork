import 'package:quickWork/domain/repository/work-category/post_work_type_repository.dart';

class PostWorkTypeUseCase {
  final PostWorkTypeRepository repository;

  PostWorkTypeUseCase(this.repository);

  Future<void> call(Map<String, dynamic> body) async {
    return await repository.createWorkType(body);
  }
}
