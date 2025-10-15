import 'package:quickWork/domain/repository/technicians/approve_technician_repository.dart';

class ApproveTechnicianUseCase {
  final ApproveTechnicianRepository repository;

  ApproveTechnicianUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.approveTechnician(id);
  }
}
