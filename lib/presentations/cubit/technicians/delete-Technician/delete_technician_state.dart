abstract class DeleteTechnicianState {}

class DeleteTechnicianInitial extends DeleteTechnicianState {}

class DeleteTechnicianLoading extends DeleteTechnicianState {}

class DeleteTechnicianSuccess extends DeleteTechnicianState {}

class DeleteTechnicianError extends DeleteTechnicianState {
  final String message;
  DeleteTechnicianError(this.message);
}
