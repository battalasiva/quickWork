import 'package:quickWork/domain/repository/technicians/delete_technician_repository.dart';

class DeleteTechnicianUseCase {
  final DeleteTechnicianRepository repository;

  DeleteTechnicianUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteTechnician(id);
  }
}
