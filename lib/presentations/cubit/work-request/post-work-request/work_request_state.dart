abstract class WorkRequestState {}

class WorkRequestInitial extends WorkRequestState {}

class WorkRequestLoading extends WorkRequestState {}

class WorkRequestSuccess extends WorkRequestState {}

class WorkRequestError extends WorkRequestState {
  final String message;
  WorkRequestError(this.message);
}
