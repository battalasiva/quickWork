abstract class RaiseTechnicianRequestState {}

class RaiseTechnicianRequestInitial extends RaiseTechnicianRequestState {}

class RaiseTechnicianRequestLoading extends RaiseTechnicianRequestState {}

class RaiseTechnicianRequestSuccess extends RaiseTechnicianRequestState {}

class RaiseTechnicianRequestError extends RaiseTechnicianRequestState {
  final String message;
  RaiseTechnicianRequestError(this.message);
}
