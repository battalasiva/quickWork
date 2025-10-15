import 'package:quickWork/domain/repository/work-request/work_request_repository.dart';

class CreateWorkRequestUseCase {
  final WorkRequestRepository repository;

  CreateWorkRequestUseCase(this.repository);

  Future<void> call(Map<String, dynamic> body) async {
    return await repository.createWorkRequest(body);
  }
}
