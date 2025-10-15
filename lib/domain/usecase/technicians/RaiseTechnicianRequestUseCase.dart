import 'package:quickWork/domain/repository/technicians/RaiseTechnicianRequestRepository.dart';

class RaiseTechnicianRequestUseCase {
  final RaiseTechnicianRequestRepository repository;

  RaiseTechnicianRequestUseCase(this.repository);

  Future<void> call(Map<String, dynamic> requestBody) async {
    return await repository.raiseRequest(requestBody);
  }
}
