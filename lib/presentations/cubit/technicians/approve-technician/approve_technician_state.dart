abstract class ApproveTechnicianState {}

class ApproveTechnicianInitial extends ApproveTechnicianState {}

class ApproveTechnicianLoading extends ApproveTechnicianState {}

class ApproveTechnicianSuccess extends ApproveTechnicianState {}

class ApproveTechnicianError extends ApproveTechnicianState {
  final String message;
  ApproveTechnicianError(this.message);
}
