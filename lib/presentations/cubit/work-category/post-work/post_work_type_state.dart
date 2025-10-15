abstract class PostWorkTypeState {}

class PostWorkTypeInitial extends PostWorkTypeState {}

class PostWorkTypeLoading extends PostWorkTypeState {}

class PostWorkTypeSuccess extends PostWorkTypeState {}

class PostWorkTypeError extends PostWorkTypeState {
  final String message;
  PostWorkTypeError(this.message);
}
